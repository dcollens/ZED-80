#include "sysreg.h"
#include "ioports.h"

void sysreg_update(uint16_t and_or) __z88dk_fastcall {
    and_or;	// unreferenced, H = and, L = or
    __asm
	ld	a, (CBIOS_SYSREG_ADDR)
	and	h
	or	l
	out	(PORT_SYSREG), a
	ld	(CBIOS_SYSREG_ADDR), a
    __endasm;
}
