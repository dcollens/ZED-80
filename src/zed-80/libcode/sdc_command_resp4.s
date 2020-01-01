; uint8_t sdc_command_resp4(uint8_t data[6])
; - 'data' pointer in HL
; - send specified 6-byte command to SD card
; - returns response byte in A
; - if command was successful, 4-byte response payload is in SDC_buffer
; - destroys: BC, HL
sdc_command_resp4::
    call    sdc_command		    ; destroys BC, HL
    cp	    0x02		    ; test response < 0x02?
    ret	    nc			    ; if response >= 0x02, return fail
    ld	    bc, 4
    push    af			    ; save response byte
    call    sdc_getbytes	    ; read 4 bytes from SD card into SDC_buffer
    pop	    af			    ; restore response byte
    ret
