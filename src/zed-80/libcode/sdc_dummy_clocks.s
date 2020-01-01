; void sdc_dummy_clocks()
; - send 80 clock cycles with CS inactive (high), and data=1
; - CS is set inactive (high) on return
#local
sdc_dummy_clocks::
    push    bc
    ld	    a, (Sysreg)
    and	    ~SYS_SDMASK
    or	    SYS_SDCS
    call    sysreg_write	    ; set CS high (inactive), clocks idle
    ld	    b, 10		    ; 10 bytes = 80 bits
writeByte:
    ld	    a, 0xFF		    ; want 8 bits of MOSI high
    call    sdc_xchg		    ; write byte to SD card
    djnz    writeByte
    pop	    bc
    ret
#endlocal
