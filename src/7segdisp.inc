PORT_SEG0	equ 0x00	    ; port address for first 7-segment display element
PORT_SEG1	equ 0x10	    ; port address for second 7-segment display element

; 7-segment display map
;      A
;  +-------+
;  |       |
; F|       |B
;  |   G   |
;  +-------+
;  |       |
; E|       |C
;  |   D   |
;  +-------+  .DP
SEG_A		equ 0x01	; segment A
SEG_B		equ 0x02	; segment B
SEG_C		equ 0x04	; segment C
SEG_D		equ 0x08	; segment D
SEG_E		equ 0x10	; segment E
SEG_F		equ 0x20	; segment F
SEG_G		equ 0x40	; segment G
SEG_DP		equ 0x80	; decimal point
