#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

uint8_t fcb_write_seq(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #21
	jp	___fcb_call
    __endasm;
}
