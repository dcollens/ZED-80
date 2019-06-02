; void seg0_toggle(uint8_t bits)
; - toggle specified bits of first 7-segment display register
seg0_toggle::
    ld	    a, (Seg0_data)
    xor	    l
    call    seg0_write
    ret
