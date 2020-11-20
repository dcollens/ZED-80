#include "fcb.h"

extern uint8_t __fcb_call(FCB *fcb);

uint8_t fcb_search_next(void) __naked {
    // We don't have a pointer on the stack, so fcb_call will load DE with our return address, but
    // that's okay since the Search Next call doesn't use it.
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #18
	jp	___fcb_call
    __endasm;
}

