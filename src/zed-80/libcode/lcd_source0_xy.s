; void lcd_source0_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_source0_xy::
    ld	    a, LCDREG_S0_X0
    jp	    lcd_out32
