#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

uint8_t fcb_open(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #15
	jp	___fcb_call
    __endasm;
}
