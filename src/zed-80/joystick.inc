PORT_JOY0	equ 0x00	    ; port address for first joystick (read-only)
PORT_JOY1	equ 0x10	    ; port address for second joystick (read-only)

; Bit masks for the values in the joystick status register.
; These bits are active-low (normally high).
JOY_UP		equ 0x01
JOY_DOWN	equ 0x02
JOY_LEFT	equ 0x04
JOY_RIGHT	equ 0x08
JOY_FIRE	equ 0x10
JOY1_SDWP	equ 0x20	    ; SD-card write protect (only on PORT_JOY1)
JOY1_SDCD	equ 0x40	    ; SD-card card detect (active low) (only on PORT_JOY1)
JOY_RESERVED	equ 0x80

; The bit numbers (useful for bit, set, and res instructions).
JOY_IDX_UP	equ 0
JOY_IDX_DOWN	equ 1
JOY_IDX_LEFT	equ 2
JOY_IDX_RIGHT	equ 3
JOY_IDX_FIRE	equ 4
JOY_IDX_SDWP	equ 5
JOY_IDX_SDCD	equ 6
