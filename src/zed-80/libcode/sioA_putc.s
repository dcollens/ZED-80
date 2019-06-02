; void sioA_putc(uint8_t ch)
; - write the specified character "ch" to port A
#local
sioA_putc::
waitTX:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOACTL)
    and	    SIORR0_TBE
    jr	    z, waitTX
    ; write output character
    ld	    a, l
    out	    (PORT_SIOADAT), a	; send byte out serial port
    ret
#endlocal
