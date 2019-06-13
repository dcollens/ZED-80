; The Z84C20 is the Z80's PIO peripheral. See um0081.pdf for documentation.

PORT_PIOBASE	equ 0x30		; base port address for PIO chip
PORT_PIOADAT	equ PORT_PIOBASE	; port address for PIO port A, data register
PORT_PIOBDAT	equ PORT_PIOBASE + 1    ; port address for PIO port B, data register
PORT_PIOACTL	equ PORT_PIOBASE + 2    ; port address for PIO port A, control register
PORT_PIOBCTL	equ PORT_PIOBASE + 3    ; port address for PIO port B, control register

; PIO Control Register commands
PIOC_IVEC	equ 0x00	; OR in the high 7 bits of the interrupt vector
PIOC_MODE	equ 0x0F	; OR in the desired PIOMODE_xxx setting
PIOC_ICTL	equ 0x07	; OR in the desired PIOICTL_xxx settings

; PIOC_MODE values
PIOMODE_OUTPUT	equ 0x00
PIOMODE_INPUT	equ 0x40
PIOMODE_BIDIREC	equ 0x80
PIOMODE_CONTROL	equ 0xC0	; next control byte written must be the IO direction byte
				; 1 = input, 0 = output

; PIOC_ICTL values
PIOICTL_INTENA	equ 0x80	; enable interrupts
PIOICTL_INTDIS	equ 0x00	; disable interrupts
PIOICTL_AND	equ 0x40	; AND inputs together for port monitoring interrupt
PIOICTL_OR	equ 0x00	; OR inputs together for port monitoring interrupt
PIOICTL_HIGH	equ 0x20	; interrupt on high (1) inputs
PIOICTL_LOW	equ 0x00	; interrupt on low (0) inputs
PIOICTL_MASKNXT equ 0x10	; next control byte written must be the input interrupt mask
				; 1 = input masked, 0 = input enabled

M_pio_reset	macro
    ; destroys A
    ld	    a, PIOC_MODE | PIOMODE_INPUT
    out	    (PORT_PIOACTL), a
    out	    (PORT_PIOBCTL), a
    ld	    a, PIOC_ICTL | PIOICTL_INTDIS
    out	    (PORT_PIOACTL), a
    out	    (PORT_PIOBCTL), a
    endm

; Set the mode for PIO port B. 'mode' is one of the PIOMODE_xxx constants.
M_pio_set_portB_mode	macro mode
    ; destroys A
    ld	    a, PIOC_MODE | &mode
    out	    (PORT_PIOBCTL), a
    endm
