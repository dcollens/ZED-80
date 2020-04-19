#ifndef _IOPORTS_H_INCLUDED
#define _IOPORTS_H_INCLUDED

// PIO ports
#define PORT_PIOBASE	0x30
#define PORT_PIOADAT	PORT_PIOBASE
#define PORT_PIOBDAT	(PORT_PIOBASE + 1)
#define PORT_PIOACTL	(PORT_PIOBASE + 2)
#define PORT_PIOBCTL	(PORT_PIOBASE + 3)

// System control register
#define PORT_SYSREG	0x70

#endif
