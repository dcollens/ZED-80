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

; same as 'rom', except that the default fill byte for 'defs' etc. is 0x00
#target bin

#include "z80.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x2000

#local
init::
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero
    ; run the test program
    call    joy_test
    ret
#endlocal

; void bzero(uint8_t *ptr, uint16_t len)
; NOTE: ptr in HL, len in BC
; - zero "len" bytes starting at address "ptr"
#local
bzero::
    push    de
    ld	    a, b
    or	    c
    jr	    z, done		; len is 0
    ld	    (hl), 0		; zero first byte of DATA seg
    dec	    bc
    ld	    a, b
    or	    c
    jr	    z, done		; len is 1
    ld	    e, l
    ld	    d, h
    inc	    de			; de = hl + 1
    ldir			; zero last len-1 bytes
done:
    pop	    de
    ret
#endlocal

; void joy_test()
#local
joy_test::
    push    hl
forever:
    in	    a, (PORT_JOY0)	; read joystick 0
    ld	    l, a
    bit	    JOY_IDX_FIRE, l
;    jr	    z, done		; return when fire button pressed
    call    joy_map2seg
    call    seg0_write
;    in	    a, (PORT_JOY1)	; read joystick 1
;    ld	    l, a
;    call    joy_map2seg
;    call    seg1_write
    jr	    forever
done:
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

; void seg0_write(uint8_t bits)
; - write raw bits to first 7-segment display register
seg0_write::
    ld	    a, l
    ld	    (Seg0_data), a
    out	    (PORT_SEG0), a
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here
Seg0_data:: defs 1	; current value of first 7-segment display byte
Seg1_data:: defs 1	; current value of second 7-segment display byte
