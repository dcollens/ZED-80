; void lcd_ellipse_radii(uint16_t rx, uint16_t ry)
; - "rx" in DE, "ry" in HL
lcd_ellipse_radii::
    ld	    a, LCDREG_ELL_A0
    jp	    lcd_out32
