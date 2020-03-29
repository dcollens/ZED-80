#include <stdint.h>
#include <stdio.h>

static int cpm_putchar(int ch) __naked {
    ch;	    // unreferenced, passed on stack
    __asm
	ld	hl, #2
	add	hl, sp
	ld	e, (hl)
	push	de
	ld	c, #2
	call	#0x0005
	pop	hl
	ld	h, #0
	ret
    __endasm;
}

int putchar(int ch) {
    if (ch == '\n') {
	cpm_putchar('\r');
    }
    return cpm_putchar(ch);
}
