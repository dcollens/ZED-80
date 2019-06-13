; void lcd_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to LCD
#local
lcd_puts::
    push    hl
    push    bc
    M_out   (PORT_LCDCMD), LCDREG_MRWDP
next_byte:
    ld	    a, (hl)		; A = output_char
    or	    a			; test output_char == 0?
    jr	    z, done		; if output_char == NUL, we're done
    inc	    hl			; advance buffer
    ld	    b, a
wait_fifo_room:
    in	    a, (PORT_LCDCMD)	; A = LCD_status
    and	    LCDSTAT_WRFULL	; test (LCD_status & LCDSTAT_WRFULL) == 0?
    jr	    nz, wait_fifo_room
    ld	    a, b		; write output character to LCD panel
    out	    (PORT_LCDDAT), a	; ...
    jr	    next_byte
done:
    call    lcd_wait_idle
    pop	    bc
    pop	    hl
    ret
#endlocal
