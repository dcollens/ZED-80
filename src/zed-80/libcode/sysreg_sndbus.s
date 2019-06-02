; void sysreg_sndbus(uint8_t bits)
; - set only bits SYS_BDIR and SYS_BC1 to specified values (from 'bits') in SYSREG
sysreg_sndbus::
    ld	    a, (Sysreg)		    ; read current value of SYSREG
    and	    ~(SYS_BDIR | SYS_BC1)   ; turn off bus control bits
    or	    l			    ; set any specified bits
    jp	    sysreg_write
