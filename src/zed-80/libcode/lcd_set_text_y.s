; void lcd_set_text_y(uint16_t y)
lcd_set_text_y::
    M_lcdwrite LCDREG_F_CURY0, l
    M_lcdwrite LCDREG_F_CURY1, h
    ret
