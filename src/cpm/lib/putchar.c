#include <stdint.h>
#include <stdio.h>

static void cpm_putchar(int ch) __naked {
    ch;	    // unreferenced, passed on stack
    __asm
	ld	hl, #2
	add	hl, sp
	ld	e, (hl)
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
