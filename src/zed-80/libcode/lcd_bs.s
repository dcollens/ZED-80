; void lcd_bs()
; - move text position back one column
; - erase character under new position
#local
lcd_bs::
    push    de
    push    hl
    call    lcd_get_text_x	; HL = text_x
    ld	    de, LCD_TXT_WIDTH	; DE = LCD_TXT_WIDTH
    or	    a			; clear carry flag
    sbc	    hl, de		; HL = text_x - LCD_TXT_WIDTH
    jr	    c, done		; if text_x < LCD_TXT_WIDTH, give up (TODO: should wrap up 1 row)
    call    lcd_set_text_x	; move cursor back one column
    ex	    de, hl		; DE = saved text position
    ld	    l, ' '
    call    lcd_putc		; overwrite erased character position with a blank space
    ex	    de, hl		; HL = saved text position
    call    lcd_set_text_x	; move cursor back one column (after erasing old character)
done:
    pop	    hl
    pop	    de
    ret
#endlocal
