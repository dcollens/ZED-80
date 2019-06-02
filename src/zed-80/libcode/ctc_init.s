; void ctc_init()
ctc_init::
    ; load CTC Interrupt Vector Register
    ld	    a, lo(IVT)	    ; CTC interrupt vectors are the first 4 in the IVT
    out	    (PORT_CTCIVEC), a
    ; channel 0 is the baud rate generator for serial 0
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC0), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x16 gives 38400 baud)
    out	    (PORT_CTC0), a
    ; channel 1 is the baud rate generator for serial 1
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR
    out	    (PORT_CTC1), a
    ld	    a, 3	    ; 1.8432MHz divided by 3 is 614.4kHz (SIO at x16 gives 38400 baud)
    out	    (PORT_CTC1), a
    call    ctc_tick_on
    ret
