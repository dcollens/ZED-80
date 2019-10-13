; uint8_t sioA_getc()
; - wait synchronously until a byte is available from port A, and return it
; - returns byte in A
#local
sioA_getc::
waitRX:
    ; wait for an input character
    in	    a, (PORT_SIOACTL)
    and	    SIORR0_RCA
    jr	    z, waitRX
    in	    a, (PORT_SIOADAT) ; read input character
    ret
#endlocal

