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
#include "lcd.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

#local
init::
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero
    call    seg_init
    ; run the test program
    call    lcd_test
    ret
#endlocal

#local
lcd_test::
    push    hl
    ld	    l, 250
loop:
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    out	    (PORT_SIOACTL), a
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    delay_ms
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS
    out	    (PORT_SIOACTL), a
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    delay_ms
    jr	    loop
    pop	    hl
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

; void seg_init()
seg_init::
    xor	    a
    call    seg0_write
    call    seg1_write
    ret

; void seg0_write(uint8_t bits)
; - parameter passed in A
; - write raw bits to first 7-segment display register
seg0_write::
    ld	    (Seg0_data), a
    out	    (PORT_SEG0), a
    ret

; void seg1_write(uint8_t bits)
; - parameter passed in A
; - write raw bits to second 7-segment display register
seg1_write::
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
    ld	    a, (ix+1)	; 19 T-states
    ld	    a, (ix+1)	; 19 T-states
    djnz    loop	; (b-1)*13+8 T-states
    pop	    bc		; 10 T-states
    nop			; 4 T-states
    ret			; 10 T-states
; We also assume the routine is CALLed, for 17 T-states.
; Total delay is therefore:
;   17 + 11 + 7 + 51*195 - 5 + 10 + 4 + 10 = 9,999
#endlocal

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here
Seg0_data:: defs 1	; current value of first 7-segment display byte
Seg1_data:: defs 1	; current value of second 7-segment display byte
