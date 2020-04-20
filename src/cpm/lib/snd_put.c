#include "sound.h"
#include "sysreg.h"
#include "ioports.h"

void _snd_put(uint16_t value_buscycle) __z88dk_fastcall {
    value_buscycle;  // unreferenced, H = value, L = buscycle

    __asm
	// First, set up 'value' on the PIO port B output bus.
	ld	a, h
	out	(PORT_PIOBDAT), a
	ld	h, #~(SYSREG_BDIR | SYSREG_BC1)	; clear sound bus control bits
	call	_sysreg_update			; set requested bus bits
	ld	l, #0
	call	_sysreg_update			; clear all sound bus bits
    __endasm;
}
