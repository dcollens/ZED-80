#include "lcd.h"

void lcd_set_fgcolor(lcd_color_t color) __naked {
    color;

    __asm
	ld	iy, #2
	add	iy, sp
	ld	b, #LCDREG_FGCR
	ld	c, (iy)
	call	lcd_write
	ld	b, #LCDREG_FGCG
	ld	c, 1(iy)
	call	lcd_write
	ld	b, #LCDREG_FGCB
	ld	c, 2(iy)
	jp	lcd_write	; tail call optimization
    __endasm;
}
