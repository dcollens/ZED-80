; void lcd_bl_off()
; - turn off LCD backlight
lcd_bl_off::
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    out	    (PORT_SIOACTL), a
    ret
