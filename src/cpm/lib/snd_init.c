#include "sound.h"
#include "ioports.h"

void snd_init(void) {
    // Set PIO port B to output mode.
    __asm
	ld	a, #0x0F
	out	(PORT_PIOBCTL), a
    __endasm;
}
