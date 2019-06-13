; void lcd_set_text_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_set_text_xy::
    ld	    a, LCDREG_F_CURX0
    jp	    lcd_out32
