#include "fcb.h"

// TODO: This would be more efficient as a __z88dk_fastcall method, and use "ex de,hl" to set up
uint8_t __fcb_call(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #2
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	; This is the opcode for "ld c, #0", which we patch with the desired syscall number
	.byte	0x0E
    fcb_call_op::
	.byte	0x00
	call	#0x0005
	ld	l, a
	ret
    __endasm;
}
