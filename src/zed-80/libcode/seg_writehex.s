; void seg_writehex(uint8_t val)
; - write the two hex digits of "val" to the 7-segment displays
seg_writehex::
    push    hl
    ld	    a, l
    call    seg1_writehex
    ld	    a, l
    rlca
    rlca
    rlca
    rlca
    call    seg0_writehex
    pop	    hl
    ret
