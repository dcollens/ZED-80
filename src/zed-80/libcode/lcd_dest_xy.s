; void lcd_dest_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_dest_xy::
    ld	    a, LCDREG_DT_X0
    jp	    lcd_out32
