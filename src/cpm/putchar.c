#include <stdint.h>
#include <stdio.h>

extern void foo(int);

int putchar(int ch) __naked {
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
