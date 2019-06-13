; void lcd_bte_wh(uint16_t width, uint16_t height)
; - "width" in DE, "height" in HL
; - set BTE rectangle size
lcd_bte_wh::
    ld	    a, LCDREG_BTE_WTH0
    jp	    lcd_out32
