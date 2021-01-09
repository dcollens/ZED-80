#ifndef _SIO_H_INCLUDED
#define _SIO_H_INCLUDED

// RR0 status bits (mostly normal operation)
#define SIORR0_RCA		0x01	    // RX character available
#define SIORR0_INTPND		0x02	    // interrupt pending (channel A only)
#define SIORR0_TBE		0x04	    // TX buffer empty
#define SIORR0_DCD		0x08	    // latched DCD input bit
#define SIORR0_SYNC		0x10	    // latched SYNC input bit (hunt in SDLC)
#define SIORR0_CTS		0x20	    // latched CTS input bit
#define SIORR0_TX_UNDR		0x40	    // TX underrun / end of message
#define SIORR0_BRK_ABRT		0x80	    // break/abort detected

#endif
