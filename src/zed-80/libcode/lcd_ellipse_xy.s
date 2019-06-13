; void lcd_ellipse_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_ellipse_xy::
    ld	    a, LCDREG_DEHR0
    jp	    lcd_out32
