; Calling convention used in this program
; ---------------------------------------
;
; Unless otherwise noted, the first parameter, and the return value are stored as follows:
; 8 bits: L
; 16 bits: HL
; 32 bits: DEHL
;
; Additional parameters are passed on the stack, left-to-right.
; Parameters and return values larger than 32 bits are passed on the stack (return value
; space set up by caller as a hidden first argument).
; Callee saves/restores any modified registers.
; Caller pops arguments after call returns.
; AF registers are scratch (caller preserves, if needed).

; same as 'bin', except that the default fill byte for 'defs' etc. is 0xff
#target rom

#include "z80.inc"
#include "sysreg.inc"
#include "mmu.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"

; some macros that we have to declare before use
M_sio_puts  macro str
    ld	    hl, &str
    call    sio_puts
    endm

M_sio_putc  macro ch
    ld	    l, &ch
    call    sio_putc
    endm

; We set up the MMU so the Z80's memory map is as follows:
; PG0: 0x0000-0x3FFF ROM physical page 0 (ROM page 0)
; PG1: 0x4000-0x7FFF RAM physical page 8 (RAM page 0)
; PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)
; PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)

; We map our RAM area high so that our data fields don't clobber low memory where we're
; likely to be loading programs.
#data RAM, 0xFC00, 0x400
; define static variables here
Sysreg::    defs 1	; current value of SYSREG
#include "lib/data_seg.inc"

#code ROM, 0, 0x4000

; reset vector
RST0::
    di
    jp	    init
    defs    0x08-$

RST1::
    reti
    defs    0x10-$

RST2::
    reti
    defs    0x18-$

RST3::
    reti
    defs    0x20-$

RST4::
    reti
    defs    0x28-$

RST5::
    reti
    defs    0x30-$

RST6::
    reti
    defs    0x38-$

; maskable interrupt handler in interrupt mode 1:
RST7::
    reti

; non maskable interrupt:
; e.g. call debugger and on exit resume.
    defs    0x66-$
NMI::
    retn

; Empty ISR for interrupts we want to ignore
ISR_nop::
    ei
    reti

    defs    0x80-$
; Interrupt Vector Table
IVT::
; Table starts at 0x0080
; CTC has first 4 slots, so CTC Interrupt Vector register should be 0x80
    .word   ISR_nop	    ; CTC channel 0
    .word   ISR_nop	    ; CTC channel 1
    .word   ISR_nop	    ; CTC channel 2
    .word   ISR_ctc3	    ; CTC channel 3
; TODO: ISRs for PIO & SIO

startup_msg::
    .text   CR, LF, "ZED-80 monitor v1 ", __date__
    ; Falling through...
crlf::
    .text   CR, LF, NUL

; void init()
init::
    ; Need to initialize MMU without use of RAM, so be careful here
    xor	    a
    out	    (PORT_MMUPG0), a	; map frame 0 to 1st page of ROM
    ld	    a, MMU_RAM_BASE
    out	    (PORT_MMUPG1), a	; map frame 1 to 1st page of RAM
    ld	    a, MMU_RAM_BASE + 1
    out	    (PORT_MMUPG2), a	; map frame 2 to 2nd page of RAM
    ld	    a, MMU_RAM_BASE + 2
    out	    (PORT_MMUPG3), a	; map frame 3 to 3rd page of RAM
    ld	    a, SYS_MMUEN | SYS_SDCS | SYS_SDICLR
    out	    (PORT_SYSREG), a	; enable MMU
    ld	    (Sysreg), a
    ; set up a stack
    ld	    sp, RAM_end-1
    ; reset peripherals
    M_pio_reset
    ; M_sio_reset
    M_ctc_reset
    ; set up interrupts
    ld	    a, hi(IVT)
    ld	    i, a	    ; I gets high byte of IVT address
    im	    2		    ; select interrupt mode 2
    ei
    ; clear 7-segment display
    call    seg_init
    ; initialize peripherals
    call    ctc_init	    ; need to set up CTC to get SIO working (need baud rate gen)
    ; call    sio_init
    ; print startup banner
    ; M_sio_puts startup_msg
    ; call    cmd_loop
    call    0x4000
    jr	    $		    ; loop forever

; Include library routines.
#include "lib/seg_init.inc"
#include "lib/seg0_write.inc"
#include "lib/seg1_write.inc"
#include "lib/delay_1ms.inc"
#include "lib/delay_ms.inc"

; void ctc_init()
#local
ctc_init::
    ; load CTC Interrupt Vector Register
    ld	    a, lo(IVT)	    ; CTC interrupt vectors are the first 4 in the IVT
    out	    (PORT_CTCIVEC), a
    ; channel 0 is the baud rate generator for serial 0
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC0), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x16 gives 38400 baud)
    out	    (PORT_CTC0), a
    ; channel 1 is the baud rate generator for serial 1
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC1), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x16 gives 38400 baud)
    out	    (PORT_CTC1), a
    call    ctc_tick_on
    ret
#endlocal

; void ctc_tick_off()
ctc_tick_off::
    ld	    a, CTC_CONTROL | CTC_INTDIS
    out	    (PORT_CTC3), a
    ret

; void ctc_tick_on()
ctc_tick_on::
    ; channel 2 is used as a timer to divide down the system clock for channel 3
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_AUTO | CTC_RISING | CTC_SCALE16 | CTC_MODETMR
    out	    (PORT_CTC2), a
    ld	    a, 250	    ; 10MHz prescale by 16, divide by 250 is 2.5kHz
    out	    (PORT_CTC2), a
    ; channel 3 is used as a counter on the 2.5kHz signal from channel 2
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR | CTC_INTENA
    out	    (PORT_CTC3), a
    ld	    a, 250	    ; 2.5kHz divided by 250 is 10Hz
    out	    (PORT_CTC3), a
    ret

; CTC channel 3 ISR
; - do not modify IX or IY, or call any routine that does, as they aren't saved/restored!
ISR_ctc3::
    ex	    af, af'
    exx
    ld	    l, SEG_DP
    call    seg1_toggle
    exx
    ex	    af, af'
    ei
    reti

; void sio_init()
#local
sio_init::
    push    hl
    push    bc
    ; configure SIO port A
    ld	    bc, 0x0700 | PORT_SIOACTL
    ld	    hl, sioA_cfg
    otir
    ; configure SIO port B
    ld	    bc, 0x0700 | PORT_SIOBCTL
    ld	    hl, sioB_cfg
    otir
    pop	    bc
    pop	    hl
    ret
sioA_cfg:
sioB_cfg:
    .byte SIOWR0_CMD_RST_CHAN
    .byte SIOWR0_PTR_R4
    .byte SIOWR4_TXSTOP_1 | SIOWR4_CLK_x16
    ; No need to set up WR1/WR2, as they are only used for interrupts
    .byte SIOWR0_PTR_R3
    .byte SIOWR3_RXENA | SIOWR3_RX_8_BITS
    .byte SIOWR0_PTR_R5
    .byte SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    ; No need to set up WR6/WR7, as they are only used for synchronous modes
#endlocal

; void cmd_loop()
#local
cmd_loop::
    push    hl
    push    bc
prompt:
    M_sio_putc '>'
nextByte:
    call    sio_getc
    ; map input byte to upper case
    call    toupper
    ; switch on input byte, and dispatch to appropriate subroutine
    ld	    a, l
    ld	    hl, cmd_chars
    ld	    bc, num_cmds
    cpir
    jr	    nz, nextByte
    ld	    hl, cmd_procs
    ; add 2 * (num_cmds - 1 - c) to hl
    ld	    a, num_cmds-1
    sub	    c
    add	    a
    ld	    c, a
    add	    hl, bc
    M_deref_hl
    ; call hl
    call    jp_hl
    jr	    prompt
    pop	    bc
    pop	    hl
    ret

cmd_chars:
    .byte SOH,'B','W','C','R','I','O',CR
num_cmds	equ $-cmd_chars
cmd_procs:
    .word cmd_do_packet
    .word cmd_do_disp_bytes
    .word cmd_do_disp_words
    .word cmd_do_call
    .word cmd_do_reset
    .word cmd_do_input
    .word cmd_do_output
    .word cmd_do_cr
#endlocal

#local
cmd_do_packet::
    push    hl
    push    bc
    push    de
    ; get packet type
    call    sio_getc
    ld	    a, l
    cp	    'W'
    jr	    z, doWrite
    cp	    'C'
    jr	    z, doCall
    ; unrecognized packet type!
    ; might be nice to consume everything up to EOT, but how long should we wait?
failure:
    ld	    l, 'N'
    jr	    putcAndDone
success:
    ld	    l, 'A'
putcAndDone:
    call    sio_putc
done:
    pop	    de
    pop	    bc
    pop	    hl
    ret

doWrite:
    ; Write packet consists of:
    ;	'W'
    ;	2-byte address
    ;	2-byte length
    ;	data bytes
    ;	checksum byte
    ;	EOT
    ; place address in de and ix
    call    sio_getc
    ld	    e, l
    call    sio_getc
    ld	    d, l
    push    de
    pop	    ix
    ; place length in bc
    call    sio_getc
    ld	    c, l
    call    sio_getc
    ld	    b, l
    ; get a checksum started
    ld	    a, 'W'
    add	    e
    add	    d
    add	    c
    add	    b
    ; keep running checksum in d
    ld	    d, a
    ; read data bytes
writeLoop:
    ; test bc against 0
    xor	    a		    ; resets carry flag, sets a=0
    ld	    h, a
    ld	    l, a	    ; set hl=0
    sbc	    hl, bc	    ; test bc against 0
    jr	    z, writeDataDone
    dec	    bc
    call    sio_getc	    ; l = next byte
    ld	    (ix), l
    inc	    ix
    ; checksum data byte
    ld	    a, d
    add	    l
    ld	    d, a
    jr	    writeLoop
writeDataDone:
    call    sio_getc	    ; l = incoming checksum
    ld	    e, l
    call    sio_getc	    ; expecting an EOT
    ld	    a, l
    cp	    EOT
    jr	    nz, failure
    ; validate checksum
    ld	    a, d
    cp	    e
    jr	    z, success
    jr	    failure

doCall:
    ; Call packet consists of:
    ;	'C'
    ;	2-byte address
    ;	checksum byte
    ;	EOT
    ; place address in bc
    call    sio_getc
    ld	    c, l
    call    sio_getc
    ld	    b, l
    call    sio_getc	    ; l = incoming checksum
    ld	    e, l
    call    sio_getc	    ; expecting an EOT
    ld	    a, l
    cp	    EOT
    jr	    nz, failure
    ; calculate checksum
    ld	    a, 'C'
    add	    c
    add	    b
    ; validate checksum
    cp	    e
    jr	    nz, failure
    M_sio_putc 'A'
    ; af is scratch & we already save/restore bc, de, hl
    ; save/restore ix, iy too
    push    ix
    push    iy
    call    ctc_tick_off
    ; call bc
    call    jp_bc
    call    seg_init
    call    ctc_tick_on
    pop	    iy
    pop	    ix
    jr	    done
#endlocal

cmd_do_disp_bytes::
    push    hl
    ; TODO: NYI
    pop	    hl
    ret

cmd_do_disp_words::
    push    hl
    ; TODO: NYI
    pop	    hl
    ret

cmd_do_call::
    push    hl
    ; TODO: NYI
    pop	    hl
    ret

cmd_do_reset::
    push    hl
    M_sio_putc 'R'
    call    delay_1ms
    di
    rst	    0x00	; reset

#local
cmd_do_input::
    push    hl
    push    bc
    M_sio_puts prompt_str
    call    sio_gethex8
    ld	    a, h
    or	    a		; fast test a==0
    jr	    nz, done
    ; I/O address is in l
    ld	    c, l
    M_sio_puts cmd_equals_str
    in	    l, (c)
    call    sio_puthex8
done:
    M_sio_puts crlf
    pop	    bc
    pop	    hl
    ret

prompt_str:
    .asciz  "I$"
#endlocal

#local
cmd_do_output::
    push    hl
    push    bc
    M_sio_puts prompt_str
    call    sio_gethex8
    ld	    a, h
    or	    a		; fast test a==0
    jr	    nz, done
    ; I/O address is in l -- stash it in c
    ld	    c, l
    M_sio_puts cmd_equals_str
    call    sio_gethex8
    ld	    a, h
    or	    a		; fast test a==0
    jr	    nz, done
    ; output value is in l
    out	    (c), l
    M_sio_puts cmd_ok_str
done:
    M_sio_puts crlf
    pop	    bc
    pop	    hl
    ret

prompt_str:
    .asciz  "O$"
#endlocal

cmd_do_cr::
    push    hl
    M_sio_puts crlf
    pop	    hl
    ret

cmd_equals_str::
    .asciz  "=$"
cmd_ok_str::
    .text   CR, LF, "OK", NUL

; Library routines
; ----------------

; Call jp_hl to make a call to the address in hl. What actually happens is the call to jp_hl loads
; the return address on the stack, then control transfers to jp_hl, which jumps to the address
; in hl, thus giving the effect of "call hl", which isn't a Z80 instruction.
jp_hl::
    jp	    hl

; Call jp_bc to make a call to the address in bc. What actually happens is the call to jp_bc loads
; the return address on the stack, then control transfers to jp_bc, which jumps to the address
; in bc, thus giving the effect of "call bc", which isn't a Z80 instruction.
jp_bc::
    push    bc
    ret

; uint8_t toupper(uint8_t ch)
; - map character "ch" to upper-case, if it is a lower-case letter
#local
toupper::
    ld	    a, l
    cp	    'a'
    ret	    c
    cp	    'z'+1
    ret	    nc
    and	    ~0x20
    ld	    l, a
    ret
#endlocal

; Z_flag isxdigit(uint8_t ch)
; - set Z flag iff "ch" is a digit 0-9 or A-F
#local
isxdigit::
    ld	    a, l
    cp	    '0'
    jr	    c, no
    cp	    '9'+1
    jr	    c, yes
    cp	    'A'
    jr	    c, no
    cp	    'F'+1
    jr	    c, yes
    ; otherwise, no
no:
    cp	    '0'		; reset Z flag (a != '0', so Z is reset)
    ret
yes:
    xor	    a		; set Z flag
    ret
#endlocal

; uint8_t hex2bin(uint8_t ch)
; - converts the single hex digit "ch" (must be 0-9 or A-F) into a binary value between 0-15
#local
hex2bin::
    ld	    a, l
    cp	    'A'
    jr	    nc, hex
    sub	    '0'
    ld	    l, a
    ret
hex:
    sub	    'A'-10
    ld	    l, a
    ret
#endlocal

; uint8_t bin2hex(uint8_t val)
; - converts the lower 4 bits of the 8-bit value "val" to hexadecimal (0-9,A-F)
#local
bin2hex::
    ld	    a, l
    and	    0xF
    cp	    0xA
    jr	    c, decimal
    add	    'A'-10
    ld	    l, a
    ret
decimal:
    add	    '0'
    ld	    l, a
    ret
#endlocal

; uint8_t sio_getc()
; - wait synchronously until a byte is available from port A, and return it
#local
sio_getc::
waitRX:
    ; wait for an input character
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_RCA, a
    jr	    z, waitRX
    ; read input character
    in	    a, (PORT_SIOADAT)
    ld	    l, a
    call    seg_writehex
    ret
#endlocal

; int16_t sio_gethex8()
; - read a two-char 8-bit hex value from port A
; - echoes chars as entered, erases as backspaced
; - BS erases last entered char
; - ESC aborts entry at any point
; - CR accepts entry
; - returns unsigned 8-bit value entered, or -1 if aborted
#local
sio_gethex8::
    push    bc
getFirst:
    call    sio_getc
    ld	    a, l
    cp	    ESC
    jr	    z, abort
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getFirst
    call    sio_putc	; echo digit
    ld	    b, l	; store high digit in b
getSecond:
    call    sio_getc
    ld	    a, l
    cp	    ESC
    jr	    z, abort
    cp	    BS
    jr	    nz, notBS1
    call    sio_putc	; echo BS
    jr	    getFirst
notBS1:
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getSecond
    call    sio_putc	; echo digit
    ld	    c, l	; store low digit in c
getThird:
    call    sio_getc
    ld	    a, l
    cp	    ESC
    jr	    z, abort
    cp	    CR
    jr	    z, convert
    cp	    BS
    jr	    nz, getThird
    ; handle backspace
    call    sio_putc	; echo BS
    jr	    getSecond
convert:
    ld	    l, b
    call    hex2bin
    ld	    b, l
    ld	    l, c
    call    hex2bin
    ; compute a = (b << 4) | l
    ld	    a, b
    add	    a
    add	    a
    add	    a
    add	    a
    or	    l
    ld	    l, a
    ld	    h, 0
    pop	    bc
    ret
abort:
    ld	    hl, -1
    pop	    bc
    ret	    
#endlocal

; void sio_putc(uint8_t ch)
; - write the specified character "ch" to port A
#local
sio_putc::
waitTX:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_TBE, a
    jr	    z, waitTX
    ; write output character
    ld	    a, l
    out	    (PORT_SIOADAT), a	; send byte out serial port
    ret
#endlocal

; void sio_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to port A
#local
sio_puts::
    push    hl
    push    bc
nextByte:
    ld	    a, (hl)
    inc	    hl
    or	    a		; fast test a==0
    jr	    z, done
    ld	    b, a
waitTX:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_TBE, a
    jr	    z, waitTX
    ; write output character
    ld	    a, b
    out	    (PORT_SIOADAT), a	; send byte out serial port
    jr	    nextByte
done:
    pop	    bc
    pop	    hl
    ret
#endlocal

; void sio_puthex8(uint8_t val)
; - writes the specified 8-bit value "val" as a pair of hex digits to port A
sio_puthex8::
    push    hl
    ld	    h, l
    srl	    l
    srl	    l
    srl	    l
    srl	    l
    call    bin2hex
    call    sio_putc
    ld	    l, h
    call    bin2hex
    call    sio_putc
    pop	    hl
    ret

; void seg_writehex(uint8_t val)
; - write the two hex digits of "val" to the 7-segment displays
seg_writehex::
    push    hl
    call    seg1_writehex
    ld	    a, l
    rlca
    rlca
    rlca
    rlca
    ld	    l, a
    call    seg0_writehex
    pop	    hl
    ret

; void seg0_writehex(uint8_t val)
; - write hex digit in lower nybble of "val" to 7-segment display
seg0_writehex::
    push    hl
    push    bc
    ld	    bc, hex2seg_table
    ld	    a, l
    and	    0xF	    ; mask off upper nybble of l
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = hex2seg_table + (val & 0xF)
    ld	    a, (Seg0_data)
    and	    SEG_DP
    or	    (hl)    ; a = (*Seg0_data & SEG_DP) | hex2seg_table[val & 0xF]
    call    seg0_write
    pop	    bc
    pop	    hl
    ret

; void seg1_writehex(uint8_t val)
; - write hex digit in lower nybble of "val" to 7-segment display
seg1_writehex::
    push    hl
    push    bc
    ld	    bc, hex2seg_table
    ld	    a, l
    and	    0xF	    ; mask off upper nybble of l
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = hex2seg_table + (val & 0xF)
    ld	    a, (Seg1_data)
    and	    SEG_DP
    or	    (hl)    ; a = (*Seg1_data & SEG_DP) | hex2seg_table[val & 0xF]
    call    seg1_write
    pop	    bc
    pop	    hl
    ret

hex2seg_table::
    ; 0
    .byte SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F
    ; 1
    .byte SEG_B | SEG_C
    ; 2
    .byte SEG_A | SEG_B | SEG_G | SEG_E | SEG_D
    ; 3
    .byte SEG_A | SEG_B | SEG_G | SEG_C | SEG_D
    ; 4
    .byte SEG_F | SEG_G | SEG_B | SEG_C
    ; 5
    .byte SEG_A | SEG_F | SEG_G | SEG_C | SEG_D
    ; 6
    .byte SEG_A | SEG_F | SEG_G | SEG_C | SEG_D | SEG_E
    ; 7
    .byte SEG_A | SEG_B | SEG_C
    ; 8
    .byte SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G
    ; 9
    .byte SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G
    ; A
    .byte SEG_A | SEG_B | SEG_C | SEG_E | SEG_F | SEG_G
    ; b
    .byte SEG_F | SEG_G | SEG_C | SEG_D | SEG_E
    ; C
    .byte SEG_A | SEG_D | SEG_E | SEG_F
    ; d
    .byte SEG_B | SEG_C | SEG_D | SEG_E | SEG_G
    ; E
    .byte SEG_A | SEG_D | SEG_E | SEG_F | SEG_G
    ; F
    .byte SEG_A | SEG_E | SEG_F | SEG_G

; void seg0_toggle(uint8_t bits)
; - toggle specified bits of first 7-segment display register
seg0_toggle::
    ld	    a, (Seg0_data)
    xor	    l
    call    seg0_write
    ret

; void seg1_toggle(uint8_t bits)
; - toggle specified bits of second 7-segment display register
seg1_toggle::
    ld	    a, (Seg1_data)
    xor	    l
    call    seg1_write
    ret

; Remaining 48KB and 64KB segments to fill up ROM image
#code FILLER1, 0, 0xC000
#code FILLER2, 0, 0x10000
