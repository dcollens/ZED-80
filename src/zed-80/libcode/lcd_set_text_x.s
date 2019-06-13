; void lcd_set_text_x(uint16_t x)
lcd_set_text_x::
    M_lcdwrite LCDREG_F_CURX0, l
    M_lcdwrite LCDREG_F_CURX1, h
    ret
