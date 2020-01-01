; uint8_t sdc_command(uint8_t data[6])
; - 'data' pointer in HL
; - send specified 6-byte command to SD card
; - returns response byte in A
; - destroys: BC, HL
sdc_command::
    call    sdc_cs_high		    ; set CS inactive
    call    sdc_cs_low		    ; set CS active
    ld	    bc, 6		    ; 6 command bytes
    call    sdc_putbytes	    ; write command bytes (destroys BC, HL)
    ld	    bc, 1000		    ; poll SD card response for 1000 cycles
    jp	    sdc_poll		    ; poll for completion
