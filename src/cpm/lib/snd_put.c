#include "sound.h"
#include "sysreg.h"
#include "ioports.h"

void snd_put(uint8_t buscycle, uint8_t value) {
    value;  // unreferenced, passed on stack

    // First, set up 'value' on the PIO port B output bus.
    __asm
	ld	hl, #3
	add	hl, sp
	ld	a, (hl)
	out	(PORT_PIOBDAT), a
    __endasm;

    // Assert the requested sound chip bus signals.
    sysreg_write(CBIOS_Sysreg | buscycle);
    // Clear the sound chip bus signals.
    sysreg_write(CBIOS_Sysreg & ~(SYSREG_BDIR | SYSREG_BC1));
}
