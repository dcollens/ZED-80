#include "conio.h"

// CP/M console input (function 1). This is a cooked-mode, blocking read, with echo.
uint8_t conio_getchar(void) __naked {
    __asm
	ld	c, #1
	call	#0x0005
	ld	l, a
	ret
    __endasm;
}
