#include "conio.h"

// ZED-80 specific CP/M CBIOS extension. Set raw or cooked mode. In raw mode, all console input
// bytes are raw key codes, with high bit set to indicate press/release status. In cooked mode,
// all console input bytes are the logical characters typed by the user (e.g. "a" or "B").
void conio_set_input_mode(uint8_t mode) __z88dk_fastcall __naked {
    mode;   // unreferenced; passed in L
    __asm
	ex	de, hl			; E = mode
	ld	hl, (#0x0001)		; address of CBIOS WBOOT entry point
	ld	bc, #0x36		; offset to CBIOS SETRAWMODE entry point
	add	hl, bc			; HL = address of CBIOS SETRAWMODE entry point
	ld	c, e			; C = mode
	jp	(hl)			; tail-call optimization
    __endasm;
}
