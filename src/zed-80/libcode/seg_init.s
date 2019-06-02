; void seg_init()
seg_init::
    xor	    a
    call    seg0_write
    call    seg1_write
    ret
