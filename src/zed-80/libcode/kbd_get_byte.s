; uint8_t kbd_get_byte()
; - read and return the next input byte from the PS/2 keyboard port
; - polls until a byte is available
#local
kbd_get_byte::
poll:
    call    kbd_poll		; poll for input byte
    jr	    z, poll
    in	    a, (PORT_KBD)	; read keyboard latch
    cpl				; invert signal (shift register is fed from ~KDAT)
    ld	    l, a		; return value in L
    jp	    pio_srclr		; clear shift register to prepare for next byte
#endlocal
