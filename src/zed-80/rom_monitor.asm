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
    push    de
    ld	    de, &str
    call    sioA_puts
    pop	    de
    endm

M_sio_putc  macro ch
    ld	    l, &ch
    call    sioA_putc
    endm

; We set up the MMU so the Z80's memory map is as follows:
; PG0: 0x0000-0x3FFF ROM physical page 0 (ROM page 0)
; PG1: 0x4000-0x7FFF RAM physical page 8 (RAM page 0)
; PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)
; PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)

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
    M_sio_reset
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
    call    sio_init
    ; print startup banner
    M_sio_puts startup_msg
#if defined(EMULATOR)
    call    0x4000
#else
    call    cmd_loop
#endif
    jr	    $		    ; loop forever

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
    ld	    a, l
    call    toupper
    ; switch on input byte, and dispatch to appropriate subroutine
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
    call    sioA_putc
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
    in	    a, (c)
    call    sioA_puthex8
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

; uint8_t sio_getc()
; - wait synchronously until a byte is available from port A, and return it
#local
sio_getc::
waitRX:
    ; wait for an input character
    in	    a, (PORT_SIOACTL)
    and	    SIORR0_RCA
    jr	    z, waitRX
    ; read input character
    in	    a, (PORT_SIOADAT)
    ld	    l, a	    ; return value goes in L
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
    ld	    l, a
    call    sioA_putc	; echo digit
    ld	    b, l	; store high digit in b
getSecond:
    call    sio_getc
    ld	    a, l
    cp	    ESC
    jr	    z, abort
    cp	    BS
    jr	    nz, notBS1
    call    sioA_putc	; echo BS
    jr	    getFirst
notBS1:
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getSecond
    ld	    l, a
    call    sioA_putc	; echo digit
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
    call    sioA_putc	; echo BS
    jr	    getSecond
convert:
    ld	    a, c
    call    hex2bin
    ld	    c, a
    ld	    a, b
    call    hex2bin
    add	    a
    add	    a
    add	    a
    add	    a
    or	    c
    ld	    l, a
    ld	    h, 0
    pop	    bc
    ret
abort:
    ld	    hl, -1
    pop	    bc
    ret	    
#endlocal

#include library "libcode"

; Remaining 48KB and 64KB segments to fill up ROM image
#code FILLER1, 0, 0xC000
#code FILLER2, 0, 0x10000

; We map our RAM area high so that our data fields don't clobber low memory where we're
; likely to be loading programs.
#data RAM, 0xFC00, 0x400
; define static variables here
#include library "libdata"
