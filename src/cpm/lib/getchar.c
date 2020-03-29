#include <stdio.h>

int getchar(void) __naked {
    __asm
	ld	c, #1
	call	#0x0005
	ld	h, #0
	ld	l, a
	ret
    __endasm;
}
