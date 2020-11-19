#include "conio.h"

// CP/M console status (function 11). Returns 0xFF if character is ready, or 0x00 if none.
uint8_t conio_poll(void) __naked {
    __asm
	ld	c, #11
	call	#0x0005
	ld	l, a
	ret
    __endasm;
}
