; void lcd_putc(uint8_t ch)
; - write the single character in "ch" to LCD
#local
lcd_putc::
    ld	    a, l		; A := ch
    cp	    CR			; Carriage return?
    jr	    nz, notCR
    jp	    lcd_cr
notCR:
    cp	    LF			; Line feed?
    jr	    nz, notLF
    jp	    lcd_lf
notLF:
    cp	    BS			; Backspace?
    jr	    nz, notBS
    jp	    lcd_bs
notBS:
    M_out   (PORT_LCDCMD), LCDREG_MRWDP
wait_fifo_room:
    ; wait until memory FIFO is non-full
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_WRFULL
    jr	    nz, wait_fifo_room
    ; write output character
    ld	    a, l
    out	    (PORT_LCDDAT), a	; send byte to LCD panel
    jp	    lcd_wait_idle
#endlocal
