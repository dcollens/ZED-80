; void pio_srclr()
; - clear shift register by toggling ~SRCLR line, leaving it HIGH
pio_srclr::
    xor	    a
    out	    (PORT_PIOADAT), a
    ld	    a, 0x08	; bit 3
    out	    (PORT_PIOADAT), a
    ret
