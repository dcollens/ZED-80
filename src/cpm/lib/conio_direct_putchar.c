#include "conio.h"

// CP/M direct console I/O (function 6). Uncooked, no echo, ignores scroll pause/resume state.
void conio_direct_putchar(uint8_t ch) __z88dk_fastcall __naked {
    ch;	    // unreferenced; passed in L
    __asm
	ld	c, #6
	ld	e, l
	jp	0x0005	    ; tail-call optimization
    __endasm;
}
