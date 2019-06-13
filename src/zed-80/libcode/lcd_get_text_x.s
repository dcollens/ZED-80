; uint16_t lcd_get_text_x()
; - returns current text X position, in pixels
lcd_get_text_x::
    M_out   (PORT_LCDCMD), LCDREG_F_CURX0
    in	    a, (PORT_LCDDAT)
    ld	    l, a
    M_out   (PORT_LCDCMD), LCDREG_F_CURX1
    in	    a, (PORT_LCDDAT)
    ld	    h, a
    ret
