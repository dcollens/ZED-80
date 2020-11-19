#include "conio.h"

// CP/M console output (function 2). Respects pause/resume keystrokes from the user.
void conio_putchar(uint8_t ch) __z88dk_fastcall __naked {
    ch;	    // unreferenced, passed in L
    __asm
	ld	e, l
	ld	c, #2
	jp	0x0005	    ; tail-call optimization
    __endasm;
}
