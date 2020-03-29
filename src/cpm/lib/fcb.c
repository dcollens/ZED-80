#include "fcb.h"

static uint8_t fcb_call(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #2
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	.byte	0x0E
    fcb_call_op::
	.byte	0x00
	call	#0x0005
	ld	l, a
	ret
    __endasm;
}

uint8_t fcb_open(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #15
	jp	_fcb_call
    __endasm;
}

uint8_t fcb_read_seq(FCB *fcb) __naked {
    fcb;    // unreferenced, passed on stack
    __asm
	ld	hl, #fcb_call_op
	ld	(hl), #20
	jp	_fcb_call
    __endasm;
}

/*
extern uint8_t fcb_close(FCB *fcb);
extern uint8_t fcb_delete(FCB *fcb);
extern uint8_t fcb_write_seq(FCB *fcb);
extern uint8_t fcb_create(FCB *fcb);
extern uint8_t fcb_rename(FCB *fcb);
extern uint8_t fcb_read_rand(FCB *fcb);
extern uint8_t fcb_write_rand(FCB *fcb);
extern void fcb_file_size(FCB *fcb);
extern void fcb_set_random_record(FCB *fcb);
*/
