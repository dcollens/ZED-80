#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

void fcb_set_random_record(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #36
	jp	___fcb_call
    __endasm;
}
