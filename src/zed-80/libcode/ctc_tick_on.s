; void ctc_tick_on()
; - could set this all up in ctc_init(), and then just enable interupts for channel 3 here
ctc_tick_on::
    ; channel 2 is used as a timer to divide down the system clock for channel 3
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_AUTO | CTC_RISING | CTC_SCALE16 | CTC_MODETMR
    out	    (PORT_CTC2), a
    ld	    a, 250	    ; 10MHz prescale by 16, divide by 250 is 2.5kHz
    out	    (PORT_CTC2), a
    ; channel 3 is used as a counter on the 2.5kHz signal from channel 2
    ld	    a, CTC_CONTROL | CTC_RESET | CTC_TIMENXT | CTC_RISING | CTC_MODECTR | CTC_INTENA
    out	    (PORT_CTC3), a
    ld	    a, 250	    ; 2.5kHz divided by 250 is 10Hz
    out	    (PORT_CTC3), a
    ret
