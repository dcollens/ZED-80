; uint8_t sdc_command(uint8_t data[6])
; - 'data' pointer in HL
; - send specified 6-byte command to SD card
; - returns response byte in A
#local
sdc_command::
    push    bc
    push    hl
    call    sdc_cs_high		    ; set CS inactive
    call    sdc_cs_low		    ; set CS active
    ld	    bc, 6		    ; 6 command bytes
    call    sdc_putbytes	    ; write command bytes (destroys BC, HL)
    ld	    bc, 1000		    ; poll SD card response for 1000 cycles
    call    sdc_poll		    ; poll for completion
    pop	    hl
    pop	    bc
    ret
#endlocal
