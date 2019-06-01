; void seg0_write(uint8_t bits)
; - parameter passed in A
; - write raw bits to first 7-segment display register
seg0_write::
    ld	    (Seg0_data), a
    out	    (PORT_SEG0), a
    ret
