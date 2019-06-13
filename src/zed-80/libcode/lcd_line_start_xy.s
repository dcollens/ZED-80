; void lcd_line_start_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_line_start_xy::
    ld	    a, LCDREG_DLHSR0
    jp	    lcd_out32
