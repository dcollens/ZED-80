#ifndef _SOUND_H_INCLUDED
#define _SOUND_H_INCLUDED

#include <stdint.h>

#include "sysreg.h"

// Sound chip bus states.
#define SNDBUS_IDLE	    0
#define SNDBUS_READ	    SYSREG_BC1
#define SNDBUS_WRITE	    SYSREG_BDIR
#define SNDBUS_ADDR	    (SYSREG_BDIR | SYSREG_BC1)

// Initialize sound subsystem.
// For now, this just sets PIO port B to output mode.
extern void snd_init(void);

// Write to address register or write data to sound chip.
// Assumes audio chip bus control bits are both 0 (i.e. SNDBUS_IDLE) upon entry
// Write 'value' to the audio chip using 'buscycle' (either SNDBUS_ADDR to set address register,
// or SNDBUS_WRITE to write to the currently-addressed register)
extern void snd_put(uint8_t buscycle, uint8_t value);

// Write 'value' to sound chip register 'regnum' 
extern void snd_write(uint8_t regnum, uint8_t value);

// Write 16 bytes from 'ptr' to the 16 registers of the YM2149F.
extern void snd_write16(uint8_t const *ptr);

#endif
