; void kbd_poll()
; - check whether a byte from the PS/2 keyboard protocol is waiting for us
; - clear Z flag if a byte is waiting, and set Z flag if no byte available
kbd_poll::
    in	    a, (PORT_PIOADAT)	; read PIO port A
    and	    0x20		; if SRSTRT is low, then no byte yet
    ret
