; void sdc_wait_ready()
; - clock out 0xFF's until we get a 0xFF response from the card
; - destroys: A
#local
sdc_wait_ready::
loop:
    ld	    a, 0xFF
    call    sdc_xchg
    inc	    a			    ; test response byte == 0xFF?
    jr	    nz, loop		    ; continue while response != 0xFF
    ret
#endlocal
