; The MMU consists of four 16KB page frames in the Z80's address space.
; Each page frame has its own 4-bit-wide register, which defines which physical
; page is mapped into that frame. There are 16 physical pages, each 16KB in size,
; for a total of 256KB of physical address space.
; The physical memory map is:
; 0x00000-0x7FFFF: Flash RAM
; 0x80000-0xFFFFF: RAM

PORT_MMUBASE	equ 0x60		; base port address for MMU register
PORT_MMUPG0	equ PORT_MMUBASE	; port address for MMU page 0 register
PORT_MMUPG1	equ PORT_MMUBASE + 1	; port address for MMU page 1 register
PORT_MMUPG2	equ PORT_MMUBASE + 2	; port address for MMU page 2 register
PORT_MMUPG3	equ PORT_MMUBASE + 3	; port address for MMU page 3 register

MMU_ROM_BASE	equ 0			; ROM starts at physical page 0
MMU_RAM_BASE	equ 8			; RAM starts at physical page 8
