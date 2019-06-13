; uint16_t lcd_get_text_y()
; - returns current text Y position, in pixels
lcd_get_text_y::
    M_out   (PORT_LCDCMD), LCDREG_F_CURY0
    in	    a, (PORT_LCDDAT)
    ld	    l, a
    M_out   (PORT_LCDCMD), LCDREG_F_CURY1
    in	    a, (PORT_LCDDAT)
    ld	    h, a
    ret
