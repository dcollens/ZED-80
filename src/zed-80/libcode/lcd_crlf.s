; void lcd_crlf()
; - advance to first column of next line
; - if this would place us off the bottom of the window, then scroll the window contents up first
#local
lcd_crlf::
    push    de
    push    hl
    call    lcd_get_text_y	; HL = text_y
    ld	    de, LCD_HEIGHT - 2 * LCD_TXT_HEIGHT
    ex	    de, hl		; DE = text_y, HL = LCD_HEIGHT - 2*LCD_TXT_HEIGHT
    or	    a			; clear carry flag
    sbc	    hl, de		; test LCD_HEIGHT - 2 * LCD_TXT_HEIGHT < text_y
    jr	    nc, noScroll	; if text_y <= LCD_HEIGHT - 2 * LCD_TXT_HEIGHT, no need to scroll
    ; Scroll screen data upwards
    push    de			; push text_y (see below)
    ld	    de, 0
    ld	    hl, LCD_TXT_HEIGHT
    call    lcd_source0_xy	; set source to (0,LCD_TXT_HEIGHT)
    ld	    h, d		; DE already 0 from above, set HL = DE
    ld	    l, e
    call    lcd_dest_xy		; set destination to (0,0)
    ld	    de, LCD_WIDTH
    ld	    hl, LCD_HEIGHT - LCD_TXT_HEIGHT
    call    lcd_bte_wh		; set bte_width=LCD_WIDTH, bte_height=LCD_HEIGHT-LCD_TXT_HEIGHT
    M_lcdwrite LCDREG_BTE_CTRL1, 0xC2 ; memory copy with ROP = S0
    M_lcdwrite LCDREG_BTE_CTRL0, 0x10 ; BTE run
    call    lcd_wait_idle
    ; Clear fresh line area at (0, text_y) with size (LCD_WIDTH, LCD_TXT_HEIGHT)
    ld	    de, 0
    pop	    hl			; pop text_y into HL (see above)
    call    lcd_dest_xy		; set destination to (0,text_y)
    ld	    de, LCD_WIDTH
    ld	    hl, LCD_TXT_HEIGHT
    call    lcd_bte_wh		; set bte_width=LCD_WIDTH, bte_height=LCD_TXT_HEIGHT
    M_lcdwrite LCDREG_BTE_CTRL1, 0x02 ; memory copy with ROP = Blackness
    M_lcdwrite LCDREG_BTE_CTRL0, 0x10 ; BTE run
    call    lcd_wait_idle
    jr	    setX0		; set cursor X to 0, and return

noScroll:			; DE = text_y
    ld	    hl, LCD_TXT_HEIGHT
    add	    hl, de		; HL = text_y + LCD_TXT_HEIGHT
    call    lcd_set_text_y	; advance Y cursor by one text row
setX0:
    ld	    hl, 0
    call    lcd_set_text_x	; move X cursor to left-hand edge
    pop	    hl
    pop	    de
    ret
#endlocal
