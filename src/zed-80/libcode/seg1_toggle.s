; void seg1_toggle(uint8_t bits)
; - toggle specified bits of second 7-segment display register
seg1_toggle::
    ld	    a, (Seg1_data)
    xor	    l
    call    seg1_write
    ret
