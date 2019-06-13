; void lcd_text_init()
; - set LCD text mode
lcd_text_init::
    push    de
    push    hl
    M_lcdwrite0 LCDREG_CCR0
    M_lcdwrite0 LCDREG_CCR1
    M_lcdwrite0 LCDREG_FLDR	    ; vertical gap between lines, in pixels
    M_lcdwrite0 LCDREG_F2FSSR	    ; horizontal gap between characters, in pixels
    M_lcdwrite LCDREG_GTCCR, 0x03   ; enable text cursor, turn on blink
    M_lcdwrite LCDREG_BTCR, 14	    ; text cursor blink period: 15 frames
    M_lcdwrite LCDREG_CURHS, LCD_TXT_WIDTH-1 ; cursor width equal to text width
    M_lcdwrite LCDREG_CURVS, LCD_TXT_HEIGHT-1 ; cursor height equal to text height
    ld	    de, 0xFFFF
    ld	    hl, 0xFFFF
    call    lcd_set_fgcolor	    ; set FG color to white
    call    lcd_wait_idle	    ; must be idle before switching to text mode
    M_lcdwrite LCDREG_ICR, 0x04	    ; set text mode
    ld	    de, 0                   ; move text cursor to (0,0)
    ld      hl, 0		    ; ...
    call    lcd_set_text_xy	    ; ...
    pop	    hl
    pop	    de
    ret
