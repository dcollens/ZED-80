#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

void fcb_file_size(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #35
	jp	___fcb_call
    __endasm;
}
