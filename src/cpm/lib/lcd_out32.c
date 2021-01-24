#include "ioports.h"
#include "lcd.h"

void lcd_out32(uint8_t regbase, uint16_t v1, uint16_t v2) __naked {
    regbase;
    v1;
    v2;

    __asm
	ld	    iy, #2
	add	    iy, sp
	ld	    a, (iy)
	ld	    e, 1(iy)
	ld	    d, 2(iy)
	ld	    l, 3(iy)
	ld	    h, 4(iy)
	ld	    c, #PORT_LCDDAT
	out	    (PORT_LCDCMD), a
	out	    (c), e
	inc	    a
	out	    (PORT_LCDCMD), a
	out	    (c), d
	inc	    a
	out	    (PORT_LCDCMD), a
	out	    (c), l
	inc	    a
	out	    (PORT_LCDCMD), a
	out	    (c), h
	ret
    __endasm;
}
