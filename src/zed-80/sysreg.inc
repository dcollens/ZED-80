PORT_SYSREG	    equ 0x70		; port address for system control register (U23)

; These values are the bit masks.
SYS_MMUEN	    equ 0x01		; MMU enable
SYS_SDCLK	    equ 0x02		; SD card input register & card clock
SYS_SDCS	    equ 0x04		; SD card chip select (active low)
SYS_SDICLR	    equ 0x08		; SD card input register clear (active low)
SYS_SDOCLK	    equ 0x10		; SD card output register clock
SYS_BDIR	    equ 0x20		; Audio chip BDIR line (bus direction)
SYS_BC1		    equ 0x40		; Audio chip BC1 line (bus control 1)
SYS_RESERVED	    equ 0x80		; Reserved for future use

; These are the bit numbers (useful for bit, set, and res instructions).
SYS_IDX_MMUEN	    equ 0
SYS_IDX_SDCLK	    equ 1
SYS_IDX_SDCS	    equ 2
SYS_IDX_SDICLR	    equ 3
SYS_IDX_SDOCLK	    equ 4
SYS_IDX_BDIR	    equ 5
SYS_IDX_BC1	    equ 6
SYS_IDX_RESERVED    equ 7

; Some helpful multi-bit masks for the SD card driver:
; Mask of all SD-card-related bits in SYSREG. We ignore ICLR because it's not used.
SYS_SDMASK	    equ SYS_SDCLK | SYS_SDCS | SYS_SDOCLK
; Mask of SD-card clock bits in SYSREG
SYS_SDCLOCKS	    equ SYS_SDCLK | SYS_SDOCLK

; void sysreg_atomic_update(uint8_t and, uint8_t or)
; - DISABLES INTERRUPTS on entry, ENABLES INTERRUPTS on exit
; - sets SYSREG := (SYSREG & and) | or
; - updates both the SYSREG register, and the Sysreg global
; - pass 'and' in H; pass 'or' in L
; - NOTE: don't call from an ISR with interrupts disabled, as it will re-enable them!
; - see sysreg_update() for a version that assumes interrupts are already disabled
M_sysreg_atomic_update	macro
    di
    call    sysreg_update
    ei
    endm
