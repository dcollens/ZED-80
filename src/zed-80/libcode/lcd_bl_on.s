; void lcd_bl_on()
; - turn on LCD backlight
lcd_bl_on::
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS
    out	    (PORT_SIOACTL), a
    ret
