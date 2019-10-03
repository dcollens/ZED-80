; void lcd_clear()
; - erase screen, move text cursor to (0,0)
lcd_clear::
    push    de
    push    hl
    ld	    de, 0
    ld	    hl, 0
    call    lcd_set_fgcolor	    ; set FG color to black
    call    lcd_line_start_xy	    ; set start to 0,0
    ld	    de, LCD_WIDTH-1
    ld	    hl, LCD_HEIGHT-1
    call    lcd_line_end_xy	    ; set end to maxX,maxY
    ; draw filled rectangle to clear screen
    M_lcdwrite LCDREG_DCR1, LCDDCR1_DRWRCT | LCDDCR1_FILL | LCDDCR1_RUN
    call    lcd_wait_idle
    pop	    hl
    pop	    de
    ret
