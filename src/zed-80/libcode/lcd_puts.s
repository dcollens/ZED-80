; void lcd_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to LCD
; - pass "text" in DE
#local
lcd_puts::
    push    hl
    push    de
next_byte:
    ld	    a, (de)		; A = output_char
    or	    a			; test output_char == 0?
    jr	    z, done		; if output_char == NUL, we're done
    inc	    de			; advance buffer
    ld	    l, a
    call    lcd_putc		; write output_char to LCD
    jr	    next_byte
done:
    pop	    de
    pop	    hl
    ret
#endlocal
