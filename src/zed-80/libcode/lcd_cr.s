; void lcd_cr()
; - return to first column of current line
lcd_cr::
    push    hl
    ld	    hl, 0
    call    lcd_set_text_x	; move X cursor to left-hand edge
    pop	    hl
    ret
