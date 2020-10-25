#ifndef _IOPORTS_H_INCLUDED
#define _IOPORTS_H_INCLUDED

// 7-segment display ports
#define PORT_SEG0	0x00
#define PORT_SEG1	0x10

// PIO ports
#define PORT_PIOBASE	0x30
#define PORT_PIOADAT	PORT_PIOBASE
#define PORT_PIOBDAT	(PORT_PIOBASE + 1)
#define PORT_PIOACTL	(PORT_PIOBASE + 2)
#define PORT_PIOBCTL	(PORT_PIOBASE + 3)

// CTC ports
#define PORT_CTCBASE	0x40
#define PORT_CTCIVEC	PORT_CTCBASE
#define PORT_CTC0	PORT_CTCBASE
#define PORT_CTC1	(PORT_CTCBASE + 1)
#define PORT_CTC2	(PORT_CTCBASE + 2)
#define PORT_CTC3	(PORT_CTCBASE + 3)

// System control register
#define PORT_SYSREG	0x70

#endif
