; Calling convention used in this file
; ------------------------------------
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

#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"

; 128KB Static RAM - AS6C1008-55PCN
; The first 8KB is shadowed by the EPROM.
; The next 56KB is mapped from 0x2000-0xFFFF.
; The top 64KB is not addressable (A16 tied low).
#data RAM, 0x2000, 0xE000
; define static variables here
Seg0_data:: defs 1	; current value of first 7-segment display byte
Seg1_data:: defs 1	; current value of second 7-segment display byte

; 128KB Flash ROM - SST39SF010A
; The first 8KB is mapped from 0-0x1FFF.
#code ROM, 0, 0x2000

; reset vector
RST0::
    di
    ld	    sp, RAM_end-1
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

; void init()
init::
    ; set up interrupts
    ld	    a, hi(IVT)
    ld	    i, a	    ; I gets high byte of IVT address
    im	    2		    ; select interrupt mode 2
    ei
    ; clear 7-segment display
    ld	    l, 0
    call    seg0_write
    call    seg1_write
    call    ctc_test
;    call    figure8
;    call    countup
;    call    pio_test
    call    joy_test
    jr	    $		; loop forever

; void countup()
#local
countup::
    push    hl
    ld	    h, 0	; counter in h
; increment count every 500ms and toggle DP
forever:
    ld	    l, h
    call    seg_writehex    ; display counter
    ld	    l, SEG_DP
    call    seg0_toggle	    ; toggle DP
    ld	    l, 250
    call    delay_ms	    ; delay 250ms
    call    delay_ms	    ; delay 250ms
    inc	    h
    jr	    forever
    pop	    hl
    ret
#endlocal

; void figure8()
#local
figure8::
    push    hl
    push    bc
; step fig8 every 125ms; toggle DP every 1s
forever:
    ld	    b, 7
fig8_loop:
    ld	    l, b
    call    seg0_fig8
    ld	    l, 125
    call    delay_ms
    dec	    b
    jp	    p, fig8_loop
    ld	    l, SEG_DP
    call    seg0_toggle
    jr	    forever
    pop	    bc
    pop	    hl
    ret
#endlocal

; void pio_test()
#local
pio_test::
    push    hl
    push    bc
    ; configure PIO ports A and B
    ld	    bc, 0x0400 | PORT_PIOACTL
    ld	    hl, portA_cfg
    otir
    ld	    bc, 0x0300 | PORT_PIOBCTL
    ; HL already points to portB_cfg
    otir
    call    pio_srclr		; clear shift register at startup
forever:
    ld	    l, SEG_DP
    call    seg1_toggle
    in	    a, (PORT_PIOADAT)	; read PIO port A
    cpl				; invert SRPRTY and SRSTRT signals
    bit	    5, a		; if SRSTRT is high, keep polling
    jr	    nz, forever
    ; put SRPRTY onto segment 0's DP
    and	    0x10		; mask off other bits
    add	    a, a
    add	    a, a
    add	    a, a		; shift SRPRTY left 3 bits to bit 7 (SEG_DP)
    ld	    l, a
    call    seg0_write
    ; read port B, displaying hex value after inverting
    in	    a, (PORT_PIOBDAT)
    cpl
    ld	    l, a
    call    pio_srclr		; clear shift register to prepare for next byte
    call    seg_writehex
    jr	    forever
    pop	    bc
    pop	    hl
    ret
portA_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xF7	    ; A3 is an output (~SRCLR), everything else is an input
    .byte PIOC_ICTL | PIOICTL_INTDIS | PIOICTL_OR | PIOICTL_HIGH | PIOICTL_MASKNXT
    .byte 0xDF	    ; interrupt on A5 only (SRSTRT)
portB_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xFF	    ; everything is an input
    .byte PIOC_ICTL | PIOICTL_INTDIS | PIOICTL_OR | PIOICTL_HIGH
#endlocal

; void pio_srclr()
; - clear shift register by toggling ~SRCLR line, leaving it HIGH
#local
pio_srclr::
    xor	    a
    out	    (PORT_PIOADAT), a
    ld	    a, 0x08	; bit 3
    out	    (PORT_PIOADAT), a
    ret
#endlocal

; void ctc_test()
#local
ctc_test::
    ; load CTC Interrupt Vector Register
    ld	    a, lo(IVT)	    ; CTC interrupt vectors are the first 4 in the IVT
    out	    (PORT_CTCIVEC), a
    ; channel 0 is the baud rate generator for serial 0
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC0), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x64 gives 9600 baud)
    out	    (PORT_CTC0), a
    ; channel 1 is the baud rate generator for serial 1
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC1), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x64 gives 9600 baud)
    out	    (PORT_CTC1), a
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
#endlocal

; CTC channel 3 ISR
ISR_ctc3::
    ex	    af, af'
    exx
    ld	    l, SEG_DP
    call    seg1_toggle
    exx
    ex	    af, af'
    ei
    reti

; void joy_test()
#local
joy_test::
    push    hl
forever:
    in	    a, (PORT_JOY0)	; read joystick 0
    ld	    l, a
    call    joy_map2seg
    call    seg0_write
;    in	    a, (PORT_JOY1)	; read joystick 1
;    ld	    l, a
;    call    joy_map2seg
;    call    seg1_write
    jr	    forever
    pop	    hl
    ret
#endlocal

; uint8_t joy_map2seg(uint8_t joy)
; - map the joystick status bits in "joy" to a value suitable for writing to the 7-segment display
#local
joy_map2seg::
    xor	    a			; start with no bits on 7-segment display
    bit	    JOY_IDX_UP, l	; test for UP
    jr	    nz, done_up
    set	    SEG_IDX_A, a	; turn on top segment
done_up:
    bit	    JOY_IDX_DOWN, l	; test for DOWN
    jr	    nz, done_down
    set	    SEG_IDX_D, a	; turn on bottom segment
done_down:
    ; if neither UP nor DOWN are active, activate (clear) both to get both top & bottom side segments
    bit	    JOY_IDX_UP, l
    jr	    z, sides
    bit	    JOY_IDX_DOWN, l
    jr	    z, sides
    res	    JOY_IDX_UP, l
    res	    JOY_IDX_DOWN, l
sides:
    bit	    JOY_IDX_LEFT, l	; test for LEFT
    jr	    nz, done_left
    bit	    JOY_IDX_UP, l	; if UP, set top-left segment
    jr	    nz, no_top_left
    set	    SEG_IDX_F, a
no_top_left:
    bit	    JOY_IDX_DOWN, l	; if DOWN, set bottom-left segment
    jr	    nz, done_left
    set	    SEG_IDX_E, a
done_left:
    bit	    JOY_IDX_RIGHT, l	; test for RIGHT
    jr	    nz, done_right
    bit	    JOY_IDX_UP, l	; if UP, set top-right segment
    jr	    nz, no_top_right
    set	    SEG_IDX_B, a
no_top_right:
    bit	    JOY_IDX_DOWN, l	; if DOWN, set bottom-right segment
    jr	    nz, done_right
    set	    SEG_IDX_C, a
done_right:
    bit	    JOY_IDX_FIRE, l	; test for FIRE
    jr	    nz, done_fire
    set	    SEG_IDX_DP, a
done_fire:
    ld	    l, a		; return segment mask
    ret
#endlocal

; Library routines
; ----------------

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
    ld	    bc, HEX_table
    ld	    a, l
    and	    0xF	    ; mask off upper nybble of l
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = HEX_table + (val & 0xF)
    ld	    a, (Seg0_data)
    and	    SEG_DP
    or	    (hl)
    ld	    l, a    ; l = (*Seg0_data & SEG_DP) | HEX_table[val & 0xF]
    call    seg0_write
    pop	    bc
    pop	    hl
    ret

; void seg1_writehex(uint8_t val)
; - write hex digit in lower nybble of "val" to 7-segment display
seg1_writehex::
    push    hl
    push    bc
    ld	    bc, HEX_table
    ld	    a, l
    and	    0xF	    ; mask off upper nybble of l
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = HEX_table + (val & 0xF)
    ld	    a, (Seg1_data)
    and	    SEG_DP
    or	    (hl)
    ld	    l, a    ; l = (*Seg1_data & SEG_DP) | HEX_table[val & 0xF]
    call    seg1_write
    pop	    bc
    pop	    hl
    ret

HEX_table::
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

; void seg0_fig8(uint8_t step)
; - advance first 7-segment display to specified figure-8 step (0-7)
seg0_fig8::
    push    hl
    push    bc
    ld	    bc, FIG8_table
    ld	    h, 0
    add	    hl, bc	; hl = FIG8_table + step
    ld	    a, (Seg0_data)
    and	    SEG_DP
    or	    (hl)
    ld	    l, a	; l = (*Seg0_data & SEG_DP) | FIG8_table[step]
    call    seg0_write
    pop	    bc
    pop	    hl
    ret

FIG8_table::
    .byte SEG_A, SEG_B, SEG_G, SEG_E, SEG_D, SEG_C, SEG_G, SEG_F

; void seg0_toggle(uint8_t bits)
; - toggle specified bits of first 7-segment display register
seg0_toggle::
    push    hl
    ld	    a, (Seg0_data)
    xor	    l
    ld	    l, a
    call    seg0_write
    pop	    hl
    ret

; void seg1_toggle(uint8_t bits)
; - toggle specified bits of second 7-segment display register
seg1_toggle::
    push    hl
    ld	    a, (Seg1_data)
    xor	    l
    ld	    l, a
    call    seg1_write
    pop	    hl
    ret

; void seg0_write(uint8_t bits)
; - write raw bits to first 7-segment display register
seg0_write::
    ld	    a, l
    ld	    (Seg0_data), a
    out	    (PORT_SEG0), a
    ret

; void seg1_write(uint8_t bits)
; - write raw bits to second 7-segment display register
seg1_write::
    ld	    a, l
    ld	    (Seg1_data), a
    out	    (PORT_SEG1), a
    ret

; void delay_ms(uint8_t ms)
; - delay for at least the specified number of milliseconds
#local
delay_ms::
    inc	    l
    dec	    l
    ret	    z		; delay of 0 returns immediately
    push    bc
    ld	    b, l
loop:
    call    delay_1ms
    djnz    loop
    pop	    bc
    ret
#endlocal

; void delay_1ms()
; - delay for 1ms (technically, 0.9999ms)
#local
delay_1ms::
    push    bc		; 11 T-states
; To delay 1ms, we want to wait 10,000 T-states (@10MHz)
; The loop is (38*b + 13*(b-1) + 8) T-states long
; Rearranging: 51*b - 5
; Solve for b: b = (10000 + 5 / 51) = 196.17
    ld	    b, 195	; 7 T-states
loop:
    ex	    (sp), hl	; 19 T-states
    ex	    (sp), hl	; 19 T-states
    djnz    loop	; (b-1)*13+8 T-states
    pop	    bc		; 10 T-states
    nop			; 4 T-states
    ret			; 10 T-states
; We also assume the routine is CALLed, for 17 T-states.
; Total delay is therefore:
;   17 + 11 + 7 + 51*195 - 5 + 10 + 4 + 10 = 9,999
#endlocal

; Remaining 56KB and 64KB segments to fill up ROM image
#code FILLER1, 0, 0xE000
#code FILLER2, 0, 0x10000
