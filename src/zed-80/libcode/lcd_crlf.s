; void lcd_crlf()
; - advance to first column of next line
; - if this would place us off the bottom of the window, then scroll the window contents up first
lcd_crlf::
    call    lcd_cr
    jp	    lcd_lf
