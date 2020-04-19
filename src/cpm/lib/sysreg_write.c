#include "sysreg.h"
#include "ioports.h"

// We initialize this variable to what we expect in the register upon launch from CP/M.
// TODO: This is bogus because the CBIOS has its own Sysreg global, and we should really point at
// it instead. 
uint8_t Sysreg = SYSREG_MMUEN | SYSREG_SDCS | SYSREG_SDICLR;

void sysreg_write(uint8_t bits) __z88dk_fastcall {
    bits;	// unreferenced, passed in L
    __asm
	ld	a, l
	out	(PORT_SYSREG), a
	ld	(_Sysreg), a
    __endasm;
}
