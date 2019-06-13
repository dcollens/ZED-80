; void lcd_out32(uint8_t reg, uint16_t v1, uint16_t v2)
; - "reg" in A
; - "v1" in DE
; - "v2" in HL
; - writes v1, v2 to the four consecutive 8-bit LCD registers starting at reg
lcd_out32::
    push    bc
    ld	    c, PORT_LCDDAT
    out	    (PORT_LCDCMD), a
    out	    (c), e
    inc	    a
    out	    (PORT_LCDCMD), a
    out	    (c), d
    inc	    a
    out	    (PORT_LCDCMD), a
    out	    (c), l
    inc	    a
    out	    (PORT_LCDCMD), a
    out	    (c), h
    pop	    bc
    ret
