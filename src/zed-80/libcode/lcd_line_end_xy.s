; void lcd_line_end_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_line_end_xy::
    ld	    a, LCDREG_DLHER0
    jp	    lcd_out32
