#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

void fcb_set_dma_address(void *iobuf) __naked {
    iobuf;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #26
	jp	___fcb_call
    __endasm;
}
