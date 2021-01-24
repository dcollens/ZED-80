#include "lcd.h"

void lcd_cursor_off(void) __naked {
    __asm
	ld  bc, #((LCDREG_GTCCR << 8) | 0x00)
	jp  lcd_write	    ; tail call optimization
    __endasm;
}