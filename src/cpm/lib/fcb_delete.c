#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

uint8_t fcb_delete(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #19
	jp	___fcb_call
    __endasm;
}
