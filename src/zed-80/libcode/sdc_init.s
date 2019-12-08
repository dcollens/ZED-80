; void sdc_init()
; - initialize SD card driver
sdc_init::
    ld	    a, (Sysreg)
    and	    ~SYS_SDMASK
    or	    SYS_SDCS
    call    sysreg_write	    ; set CS high (inactive), clocks idle
    xor	    a
    ld	    (SDC_flags), a	    ; clear the SD card bit flags
    ret
