; void lcd_set_fgcolor(uint8_t r, uint8_t g, uint8_t b)
; - sets foreground drawing color to (r,g,b)
; - "r" in D, "g" in E, "b" in H
; - R,G,B uses upper 5,6,5 bits of precision only (i.e. 16bpp color)
lcd_set_fgcolor::
    M_lcdwrite LCDREG_FGCR, d
    M_lcdwrite LCDREG_FGCG, e
    M_lcdwrite LCDREG_FGCB, h
    ret
