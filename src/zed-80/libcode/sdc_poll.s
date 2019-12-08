; uint8_t sdc_poll(uint16_t maxCount)
; - 'maxCount' in BC (0 means 65536)
; - writes up to maxCount 0xFF bytes out to the SD card
; - returns the first non-0xFF byte the card sends back, or else 0xFF
; - return card response byte in A
; - BC is decremented by the number of 0xFF's that were returned by the card
#local
sdc_poll::
loop:
    ld	    a, 0xFF		    ; write 0xFF to SD card until we get a response
    call    sdc_xchg
    cp	    0xFF		    ; test response byte == 0xFF?
    ret	    nz			    ; return if response != 0xFF
    dec	    bc			    ; --maxCount
    ld	    a, b
    or	    c
    jr	    nz, loop		    ; loop if maxCount != 0
    ld	    a, 0xFF		    ; return 0xFF
    ret
#endlocal
