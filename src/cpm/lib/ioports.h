#ifndef _IOPORTS_H_INCLUDED
#define _IOPORTS_H_INCLUDED

// 7-segment display ports
#define PORT_SEG0	0x00
#define PORT_SEG1	0x10

// SIO ports
#define PORT_SIOBASE	0x20
#define PORT_SIOADAT	PORT_SIOBASE
#define PORT_SIOBDAT	(PORT_SIOBASE + 1)
#define PORT_SIOACTL	(PORT_SIOBASE + 2)
#define PORT_SIOBCTL	(PORT_SIOBASE + 3)

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

// LCD ports
#define PORT_LCDBASE	0x50		    // base port address for RA8876 chip
#define PORT_LCDCMD	PORT_LCDBASE	    // port address for RA8876 command/status register
#define PORT_LCDDAT	(PORT_LCDBASE + 1)  // port address for RA8876 data register

// System control register
#define PORT_SYSREG	0x70

#endif
