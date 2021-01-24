#include "lcd.h"

void lcd_set_fgcolor(lcd_color_t color) __z88dk_fastcall __naked {
    color;  // unreferenced in DEHL

    __asm
	ld	b, #LCDREG_FGCR
	ld	c, l
	call	lcd_write
	ld	b, #LCDREG_FGCG
	ld	c, h
	call	lcd_write
	ld	b, #LCDREG_FGCB
	ld	c, e
	jp	lcd_write	; tail call optimization
    __endasm;
}
