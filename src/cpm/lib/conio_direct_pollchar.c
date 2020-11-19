#include "conio.h"

// CP/M direct console I/O (function 6). Uncooked, no echo, ignores scroll pause/resume state.
// Returns the next input char, if any, otherwise 0x00 to indicate none was ready (non-blocking).
uint8_t conio_direct_pollchar(void) __naked {
    __asm
	ld	c, #6
	ld	e, #0xFF
	call	#0x0005
	ld	l, a
	ret
    __endasm;
}
