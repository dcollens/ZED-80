; void sdc_dummy_clocks()
; - send 80 clock cycles with CS inactive (high), and data=1
; - CS is set inactive (high) on return
#local
sdc_dummy_clocks::
    push    bc
    push    hl
    ld	    hl, ~SYS_SDMASK << 8 | SYS_SDCS ; clear SYS_SDMASK bits, set SYS_SDCS bit
    M_sysreg_atomic_update	    ; set CS high (inactive), clocks idle
    pop	    hl
    ld	    b, 10		    ; 10 bytes = 80 bits
writeByte:
    ld	    a, 0xFF		    ; want 8 bits of MOSI high
    call    sdc_xchg		    ; write byte to SD card
    djnz    writeByte
    pop	    bc
    ret
#endlocal
