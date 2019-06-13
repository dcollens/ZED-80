; void lcd_triangle_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
; - this sets the third point for a triangle (first two are the "line start" and "line end" points)
lcd_triangle_xy::
    ld	    a, LCDREG_DTPH0
    jp	    lcd_out32
