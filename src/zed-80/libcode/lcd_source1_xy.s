; void lcd_source1_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_source1_xy::
    ld	    a, LCDREG_S1_X0
    jp	    lcd_out32
