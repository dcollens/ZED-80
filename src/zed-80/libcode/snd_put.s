; void snd_put(uint8_t bus_cycle, uint8_t data)
; - assumes audio chip bus control bits are both 0 (i.e. SNDBUS_IDLE) upon entry
; - write 'data' to the audio chip using 'bus_cycle' (either SNDBUS_ADDR to set address register,
;   or SNDBUS_WRITE to write to the currently-addressed register)
; - pass 'bus_cycle' in L, and 'data' in H
snd_put::
    M_pio_set_portB_mode PIOMODE_OUTPUT
    ld	    a, h		; A = data
    out	    (PORT_PIOBDAT), a	; write 'data' to PIO port B
    ld	    a, (Sysreg)		    ; read current value of SYSREG
    or	    l			    ; set requested audio chip 'bus_cycle' bits
    out	    (PORT_SYSREG), a	    ; write bus bits
    and	    ~(SYS_BDIR | SYS_BC1)   ; turn off audio chip bus control bits
    jp	    sysreg_write	    ; write bus bits and return
