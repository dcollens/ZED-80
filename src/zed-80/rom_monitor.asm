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
#include "keyboard.inc"
#include "lcd.inc"

; some macros that we have to declare before use
M_puts	    macro str
    push    de
    ld	    de, &str
    call    mon_puts
    pop	    de
    endm

M_putc	    macro ch
    ld	    l, &ch
    call    mon_putc
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
    .text   CR, LF, "ZED-80 monitor v2 ", __date__
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
    ld	    sp, RAM_end-1	; set up a stack
    ; reset peripherals
    M_pio_reset
    M_sio_reset
    M_ctc_reset
    ; set up interrupts
    ld	    a, hi(IVT)
    ld	    i, a	    ; I gets high byte of IVT address
    im	    2		    ; select interrupt mode 2
    ei
    call    seg_init	    ; clear 7-segment display
    ; initialize peripherals
    call    ctc_init	    ; need to set up CTC to get SIO working (need baud rate gen)
    call    sio_init
    call    kbd_init	    ; Initialize keyboard
    call    lcd_init	    ; Initialize screen
    call    lcd_text_init   ; Initialize text mode
    call    sdc_init	    ; Initialize SD card
    M_puts  startup_msg	    ; print startup banner
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
    M_putc  '>'
nextByte:
    call    mon_getc
    ; map input byte to upper case
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
    call    jp_hl	; call HL
    jr	    prompt
    pop	    bc
    pop	    hl
    ret

cmd_chars:
    .byte SOH,'?','B','F','M','C','R','I','O',CR
num_cmds	equ $-cmd_chars
cmd_procs:
    .word cmd_do_packet
    .word cmd_do_help
    .word cmd_do_basic
    .word cmd_do_forth
    .word cmd_do_cpm
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
    call    sioA_getc	; get packet type
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
    call    mon_putc
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
    call    sioA_getc
    ld	    e, a
    call    sioA_getc
    ld	    d, a
    push    de
    pop	    ix
    ; place length in bc
    call    sioA_getc
    ld	    c, a
    call    sioA_getc
    ld	    b, a
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
    call    sioA_getc	    ; A = next byte
    ld	    (ix), a
    inc	    ix
    ; checksum data byte
    add	    d
    ld	    d, a
    jr	    writeLoop
writeDataDone:
    call    sioA_getc	    ; A = incoming checksum
    ld	    e, a
    call    sioA_getc	    ; expecting an EOT
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
    call    sioA_getc
    ld	    c, a
    call    sioA_getc
    ld	    b, a
    call    sioA_getc	    ; A = incoming checksum
    ld	    e, a
    call    sioA_getc	    ; expecting an EOT
    cp	    EOT
    jr	    nz, failure
    ; calculate checksum
    ld	    a, 'C'
    add	    c
    add	    b
    ; validate checksum
    cp	    e
    jr	    nz, failure
    M_putc  'A'
    ; AF is scratch & we already save/restore BC, DE, HL
    ; save/restore IX, IY too
    push    ix
    push    iy
    call    ctc_tick_off
    call    jp_bc	    ; call BC
    call    seg_init
    call    ctc_tick_on
    pop	    iy
    pop	    ix
    jr	    done
#endlocal

#local
cmd_do_help::
    M_puts  help_msg
    ret

help_msg:
    .text   CR, LF
    .text   "Basic", CR, LF
    .text   "Forth", CR, LF
    .text   "cp/M", CR, LF
    .text   CR, LF
    .text   "Call <AAAA>", CR, LF
    .text   "Input <PP>", CR, LF
    .text   "Output <PP>=<NN>", CR, LF
    .text   "Reset", CR, LF
    .text   "? help", CR, LF
    .text   NUL
#endlocal

#local
cmd_do_basic::
    M_putc  'B'
    ld	    l, BASIC_PHYS_PAGE	; map in the BASIC ROM page
    ld	    bc, BASIC_size	; copy BASIC_size bytes
    jr	    copyAndRun

cmd_do_forth::
    M_putc  'F'
    ld	    l, FORTH_PHYS_PAGE	; map in the Forth ROM page
    ld	    bc, FORTH_size	; copy FORTH_size bytes
    jr	    copyAndRun
    
; void copyAndRun(uint8_t physPage, uint16_t size)
; - copy "size" bytes from physical page "physPage" into RAM page 0, map it to address 0, and
;   run it with a "RST 0"
; - pass "physPage" in L, "size" in BC
copyAndRun:
    call    ctc_tick_off
    di
; We begin with this memory map:
;   PG0: 0x0000-0x3FFF ROM physical page 0 (ROM page 0)
;   PG1: 0x4000-0x7FFF RAM physical page 8 (RAM page 0)
;   PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)
;   PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)
; Our code is running from PG0, and our stack and data are in PG3.
; Map the specified ROM segment into PG2, and then copy it down to PG1.
    ld	    a, l		; A = physPage
    out	    (PORT_MMUPG2), a	; map frame 2 to specified ROM page
    ld	    hl, 0x8000		; copy from $8000
    ld	    de, 0x4000		; copy to $4000
    ldir			; do the copy ("size" already in BC)
; Copy a trampoline up to PG3, and then jump to it.
    ld	    hl, trampoline	; copy from trampoline
    ld	    de, 0xC000		; copy to $C000
    ld	    bc, trampoline_size	; copy trampoline_size bytes
    ldir			; do the copy
    jp	    0xC000		; jump to the relocated trampoline
; The trampoline establishes the following memory map:
;   PG0: 0x0000-0x3FFF RAM physical page 8 (RAM page 0)  <--- changed (from ROM page 0)
;   PG1: 0x4000-0x7FFF RAM physical page B (RAM page 3)  <--- changed (from RAM page 0)
;   PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)  <--- changed (from physPage)
;   PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)
; and then issues a "RST 0".

trampoline:
    ; The trampoline gets moved to PG3 before being run, so make sure it is position-independent.
    ld	    a, MMU_RAM_BASE
    out	    (PORT_MMUPG0), a
    ld	    a, MMU_RAM_BASE + 3
    out	    (PORT_MMUPG1), a
    ld	    a, MMU_RAM_BASE + 1
    out	    (PORT_MMUPG2), a
    rst	    0x00
trampoline_size	    equ $-trampoline
#endlocal

#local
cmd_do_cpm::
    M_putc  'M'
    M_puts  crlf
    call    ctc_tick_off
    di
; We begin with this memory map:
;   PG0: 0x0000-0x3FFF ROM physical page 0 (ROM page 0)
;   PG1: 0x4000-0x7FFF RAM physical page 8 (RAM page 0)
;   PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)
;   PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)
; Our code is running from PG0, and our stack and data are initially in PG3.
; Use PG1 for our stack so we don't clobber it during the copy to PG3.
    ld	    sp, 0x4100
; Map the CP/M ROM segment into PG2, and copy it up to PG3.
    ld	    a, CPM_PHYS_PAGE
    out	    (PORT_MMUPG2), a	; map frame 2 to CP/M ROM page
    ld	    hl, 0x8000		; copy from $8000
    ld	    de, CBIOS_BASE	; copy to CBIOS base address
    ld	    bc, CBIOS_LEN	; copy CBIOS_LEN bytes
    ldir			; do the copy
; Copy a trampoline up to PG1, and jump to it.
    ld	    hl, trampoline	; copy from trampoline
    ld	    de, 0x4200		; copy to $4200
    ld	    bc, trampoline_size	; copy trampoline_size bytes
    ldir			; do the copy
    jp	    0x4200		; jump to the relocated trampoline
; The trampoline establishes the following memory map:
;   PG0: 0x0000-0x3FFF RAM physical page B (RAM page 3)  <--- changed (from ROM page 0)
;   PG1: 0x4000-0x7FFF RAM physical page 8 (RAM page 0)
;   PG2: 0x8000-0xBFFF RAM physical page 9 (RAM page 1)  <--- changed (from CPM_PHYS_PAGE)
;   PG3: 0xC000-0xFFFF RAM physical page A (RAM page 2)
; and then issues a "jp CBIOS_BASE+3".

trampoline:
    ; The trampoline gets moved to PG1 before being run, so make sure it is position-independent.
    ld	    a, MMU_RAM_BASE + 3
    out	    (PORT_MMUPG0), a
    ld	    a, MMU_RAM_BASE + 1
    out	    (PORT_MMUPG2), a
    jp	    CBIOS_BASE+3	; the CBIOS "warm start" entry point
trampoline_size	    equ $-trampoline
#endlocal

#local
cmd_do_call::
    push    hl
    push    de
    push    bc
    M_puts  prompt_str
    call    mon_gethex16
    jr	    z, done
    ; call address is in HL
    ; AF is scratch & we already save/restore BC, DE, HL
    ; save/restore IX, IY too
    push    ix
    push    iy
    call    ctc_tick_off
    call    jp_hl	    ; call HL
    call    seg_init
    call    ctc_tick_on
    pop	    iy
    pop	    ix
    M_puts cmd_ok_str
done:
    M_puts crlf
    pop	    bc
    pop	    de
    pop	    hl
    ret

prompt_str:
    .asciz  "C$"
#endlocal

cmd_do_reset::
    push    hl
    M_putc  'R'
    call    delay_1ms
    di
    rst	    0x00	; reset

#local
cmd_do_input::
    push    hl
    push    bc
    M_puts  prompt_str
    call    mon_gethex8
    jr	    z, done
    ; I/O address is in l
    ld	    c, l
    M_puts  cmd_equals_str
    in	    a, (c)
    call    mon_puthex8
done:
    M_puts  crlf
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
    M_puts  prompt_str
    call    mon_gethex8
    jr	    z, done
    ; I/O address is in l -- stash it in c
    ld	    c, l
    M_puts  cmd_equals_str
    call    mon_gethex8
    jr	    z, done
    ; output value is in l
    out	    (c), l
    M_puts  cmd_ok_str
done:
    M_puts  crlf
    pop	    bc
    pop	    hl
    ret

prompt_str:
    .asciz  "O$"
#endlocal

cmd_do_cr::
    push    hl
    M_puts  crlf
    pop	    hl
    ret

cmd_equals_str::
    .asciz  "=$"
cmd_ok_str::
    .text   CR, LF, "OK", NUL

; int8_t mon_gethex8()
; - read a two-char 8-bit hex value from port A and/or keyboard
; - echoes chars as entered, erases as backspaced
; - BS erases last entered char
; - ESC aborts entry at any point
; - CR accepts entry
; - returns unsigned 8-bit value entered in L
; - Z flag is set if user aborted entry, cleared otherwise
#local
mon_gethex8::
    push    bc
getFirst:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getFirst
    ld	    l, a
    call    mon_putc	; echo digit
    ld	    b, l	; store high digit in B
getSecond:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    cp	    ASC_BS
    jr	    nz, notBS1
    ld	    l, a
    call    mon_putc	; echo BS
    jr	    getFirst
notBS1:
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getSecond
    ld	    l, a
    call    mon_putc	; echo digit
    ld	    c, l	; store low digit in C
getThird:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    cp	    CR
    jr	    z, convert
    cp	    ASC_BS
    jr	    nz, getThird
    ; handle backspace
    ld	    l, a
    call    mon_putc	; echo BS
    jr	    getSecond
convert:
    push    hl		; save H
    ld	    hl, bc
    call    hex2bin2
    ld	    a, l
    pop	    hl		; restore H
    ld	    l, a
    or	    b		; reset Z flag by ORing in the ASCII hex digit in B
abort:
    pop	    bc
    ret
#endlocal

; int16_t mon_gethex16()
; - read a four-char 16-bit hex value from port A and/or the keyboard
; - echoes chars as entered, erases as backspaced
; - BS erases last entered char
; - ESC aborts entry at any point
; - CR accepts entry
; - returns unsigned 16-bit value entered in HL
; - Z flag is set if user aborted entry, cleared otherwise
#local
mon_gethex16::
    push    bc
    push    de
getFirst:
    call    mon_getc
    cp	    ESC
    jp	    z, abort	; Z is set, return
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getFirst
    ld	    l, a
    call    mon_putc	; echo digit
    ld	    b, l	; store digit1 in B
getSecond:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    cp	    ASC_BS
    jr	    nz, notBS1
    ld	    l, a
    call    mon_putc	; echo BS
    jr	    getFirst
notBS1:
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getSecond
    ld	    l, a
    call    mon_putc	; echo digit
    ld	    c, l	; store digit2 in C
getThird:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    cp	    ASC_BS
    jr	    nz, notBS2
    ld	    l, a
    call    mon_putc	; echo BS
    jr	    getSecond
notBS2:
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getThird
    ld	    l, a
    call    mon_putc	; echo digit
    ld	    d, l	; store digit3 in D
getFourth:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    cp	    ASC_BS
    jr	    nz, notBS3
    ld	    l, a
    call    mon_putc	; echo BS
    jr	    getThird
notBS3:
    call    toupper
    call    isxdigit	; Z set iff is hex digit
    jr	    nz, getFourth
    ld	    l, a
    call    mon_putc	; echo digit
    ld	    e, l	; store digit4 in E
getFifth:
    call    mon_getc
    cp	    ESC
    jr	    z, abort	; Z is set, return
    cp	    CR
    jr	    z, convert
    cp	    ASC_BS
    jr	    nz, getFifth
    ; handle backspace
    ld	    l, a
    call    mon_putc	; echo BS
    jr	    getFourth
convert:
    ld	    hl, bc	; HL := digit1,digit2
    call    hex2bin2	; L := hex2bin2(digit1,digit2)
    ex	    de, hl	; HL := digit3,digit4 ; E := hex2bin2(digit1,digit2)
    call    hex2bin2	; L := hex2bin2(digit3,digit4)
    ld	    h, e	; H := hex2bin2(digit1,digit2)
    or	    b		; reset Z flag by ORing in the ASCII hex digit in B
abort:
    pop	    de
    pop	    bc
    ret
#endlocal

; uint16_t hex2bin2(uint8_t high, uint8_t low)
; - converts the two hex digits "high" and "low" (must be 0-9 or A-F) into an unsigned 8-bit value
; - pass "high" in H, and "low" in L
; - returns result in L
hex2bin2::
    push    hl		; preserve H
    ld	    a, h
    call    hex2bin
    ld	    h, a	; convert digit in H to nybble in H
    ld	    a, l
    call    hex2bin
    ld	    l, a	; convert digit in L to nybble in L
    ; compute A = (H << 4) | L
    ld	    a, h
    add	    a
    add	    a
    add	    a
    add	    a
    or	    l
    pop	    hl
    ld	    l, a
    ret

; uint8_t mon_getc()
; - wait synchronously until a byte is available from SIO port A or the keyboard, then return it
; - returns byte in A
#local
mon_getc::
awaitInput:
    in	    a, (PORT_SIOACTL)
    and	    SIORR0_RCA
    jp	    nz, sioA_getc   ; if SIO port A has a character, return it
    call    kbd_pollc	    ; check keyboard for character
    jr	    z, awaitInput   ; no character available: loop
    ld	    a, l
    ret
#endlocal

; void mon_putc(uint8_t ch)
; - write character "ch" to SIO port A and the LCD screen
; - pass "ch" in L
mon_putc::
    call    sioA_putc
    jp	    lcd_putc

; void mon_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to SIO port A and the LCD screen
; - pass "text" in DE
mon_puts::
    call    sioA_puts
    jp	    lcd_puts

; void mon_puthex8(uint8_t val)
; - 'val' in A
; - writes the specified 8-bit value "val" as a pair of hex digits to SIO port A & LCD screen
; - destroys A
mon_puthex8::
    push    hl
    ld	    h, a
    rrca
    rrca
    rrca
    rrca
    call    bin2hex
    ld	    l, a
    call    mon_putc
    ld	    a, h
    call    bin2hex
    ld	    l, a
    call    mon_putc
    pop	    hl
    ret

#include library "libcode"

; Code image for BASIC interpreter, to be copied down to RAM at page frame 0.
#code BASIC, 0, 0x4000
#insert "lcd_basic_low.bin"
BASIC_PHYS_PAGE	    equ MMU_ROM_BASE + 1

; Code image for Forth runtime, to be copied down to RAM at page frame 0.
#code FORTH, 0, 0x4000
#insert "forth_low.bin"
FORTH_PHYS_PAGE	    equ MMU_ROM_BASE + 2

; Code image for CP/M runtime, to be copied into RAM at page frame 3 (i.e. high).
#code CPM, 0, 0x4000
#insert "cbios.bin"
CBIOS_BASE	    equ	0xF600	; keep in sync with cbios.asm
CBIOS_LEN	    equ $-CPM

CPM_PHYS_PAGE	    equ MMU_ROM_BASE + 3

; Remaining 64KB segment to fill up ROM image
#code FILLER, 0, 0x10000

; We map our RAM area high so that our data fields don't clobber low memory where we're
; likely to be loading programs.
#data RAM, 0xFC00, 0x400
; define static variables here
#include library "libdata"
