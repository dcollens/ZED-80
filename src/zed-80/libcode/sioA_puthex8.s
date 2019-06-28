; void sioA_puthex8(uint8_t val)
; - 'val' in A
; - writes the specified 8-bit value "val" as a pair of hex digits to serial port A
; - destroys A
sioA_puthex8::
    push    hl
    ld	    h, a
    rrca
    rrca
    rrca
    rrca
    call    bin2hex
    ld	    l, a
    call    sioA_putc
    ld	    a, h
    call    bin2hex
    ld	    l, a
    call    sioA_putc
    pop	    hl
    ret
