#include "sysreg.h"
#include "ioports.h"

void sysreg_write(uint8_t bits) __z88dk_fastcall {
    bits;	// unreferenced, passed in L
    __asm
	ld	a, l
	out	(PORT_SYSREG), a
	ld	(CBIOS_SYSREG_ADDR), a
    __endasm;
}
