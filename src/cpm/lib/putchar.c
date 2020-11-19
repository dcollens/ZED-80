#include <stdint.h>
#include <stdio.h>

static void cpm_putchar(uint8_t ch) __z88dk_fastcall __naked {
    ch;	    // unreferenced, passed in L
    __asm
	ld	e, l
	ld	c, #2
	jp	0x0005
    __endasm;
}

int putchar(int ch) {
    if (ch == '\n') {
	cpm_putchar('\r');
    }
    cpm_putchar(ch);
    return ch;
}
