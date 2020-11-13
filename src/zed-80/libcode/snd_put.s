; void snd_put(uint8_t bus_cycle, uint8_t data)
; - NOTE: caller is responsible for disabling interrupts to protect SYSREG manipulations
; - assumes audio chip bus control bits are both 0 (i.e. SNDBUS_IDLE) upon entry
; - write 'data' to the audio chip using 'bus_cycle' (either SNDBUS_ADDR to set address register,
;   or SNDBUS_WRITE to write to the currently-addressed register)
; - pass 'bus_cycle' in L, and 'data' in H
; - destroys: HL
snd_put::
    ld	    a, h		    ; A = data
    out	    (PORT_PIOBDAT), a	    ; write 'data' to PIO port B
    ld	    a, (Sysreg)		    ; A = Sysreg
    and	    a, ~(SYS_BDIR | SYS_BC1) ; clear bus control bits
    or	    l			    ; set requested audo chip 'bus_cycle' bits
    out	    (PORT_SYSREG), a
    and	    a, ~(SYS_BDIR | SYS_BC1) ; clear bus control bits
    jp	    sysreg_write	    ; update Sysreg variable and write to PORT_SYSREG
