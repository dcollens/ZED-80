; void sdc_cs_low()
; - set SD card CS low (active)
; - clock out 0xFF's until we get a 0xFF response from the card
#local
sdc_cs_low::
    ld	    a, (Sysreg)
    and	    ~SYS_SDCS
    call    sysreg_write
loop:
    ld	    a, 0xFF
    call    sdc_xchg
    inc	    a			    ; test response byte == 0xFF?
    jr	    nz, loop		    ; continue while response != 0xFF
    ret
#endlocal
