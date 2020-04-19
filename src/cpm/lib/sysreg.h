#ifndef _SYSREG_H_INCLUDED
#define _SYSREG_H_INCLUDED

#include <stdint.h>

// SYSREG bits
#define SYSREG_MMUEN	    0x01		// MMU enable
#define SYSREG_SDCLK	    0x02		// SD card input register & card clock
#define SYSREG_SDCS	    0x04		// SD card chip select (active low)
#define SYSREG_SDICLR	    0x08		// SD card input register clear (active low)
#define SYSREG_SDOCLK	    0x10		// SD card output register clock
#define SYSREG_BDIR	    0x20		// Audio chip BDIR line (bus direction)
#define SYSREG_BC1	    0x40		// Audio chip BC1 line (bus control 1)
#define SYSREG_RESERVED	    0x80		// Reserved for future use

// This global variable holds the value most recently written to SYSREG via sysreg_write().
extern uint8_t Sysreg;

// Write the specified bits to the system control register (SYSREG) and also to the Sysreg global.
extern void sysreg_write(uint8_t bits) __z88dk_fastcall;

#endif
