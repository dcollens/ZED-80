	.module lcd_write

PORT_LCDCMD .equ 0x50
PORT_LCDDAT .equ 0x51
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl lcd_write
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
; void lcd_write(uint8_t regnum, uint8_t val)
; Writes 'val' to LCD register 'regnum'
; B = regnum, C = val
; Destroys: A
lcd_write::
	ld	a, b
	out	(PORT_LCDCMD), a
	ld	a, c
	out	(PORT_LCDDAT), a
	ret
