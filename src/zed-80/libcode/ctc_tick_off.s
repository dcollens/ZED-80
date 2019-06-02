; void ctc_tick_off()
ctc_tick_off::
    ld	    a, CTC_CONTROL | CTC_INTDIS
    out	    (PORT_CTC3), a
    ret
