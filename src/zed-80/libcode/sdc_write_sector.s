; uint8_t sdc_write_sector(uint32_t lba)
; - 'lba' passed in BCDE
; - one 512-byte sector is written from SDC_buffer
; - returns status in A:
;     0: success
;     non-0: error
; - NOTE: we check the SD slot's WP bit in PORT_JOY1, and fail if WP is set
#local
sdc_write_sector::
    push    bc
    push    de
    push    hl
    in	    a, (PORT_JOY1)
    and	    JOY1_SDWP		    ; test Write Protect (active high)
    jr	    nz, done		    ; 
    ld	    hl, cmd24_data+1	    ; HL = buffer to write adjusted lba
    call    sdc_lba_adjust	    ; scale lba if needed & store to buffer
    ld	    hl, cmd24_data
    call    sdc_command		    ; send CMD24 (destroys BC, HL)
    or	    a			    ; test response == 0?
    jr	    nz, done		    ; if response != 0, return failure
    call    sdc_wait_ready	    ; poll until we get an 0xFF back from card
    ld	    a, 0xFE
    call    sdc_xchg		    ; send data token
    ld	    hl, SDC_buffer
    ld	    bc, 512
    call    sdc_putbytes	    ; write 512 bytes from SDC_buffer
    ld	    b, 3		    ; repeat 3 times
xchgLoop:
    ld	    a, 0xFF
    call    sdc_xchg		    ; send 0xFF, receive byte
    djnz    xchgLoop		    ; 2 dummy CRC bytes, and read data response
    and	    0x1F		    ; A = data response & 0x1F
    sub	    0x05		    ; A -= 0x05 (i.e. "data accepted")
    ; now A is 0 if the data was accepted ok, and non-zero otherwise
done:
    ld	    l, a		    ; save response byte in A
    call    sdc_cs_high		    ; deselect the card when done
    ld	    a, l		    ; restore response byte to A
    pop	    hl
    pop	    de
    pop	    bc
    ret

cmd24_data:
    .byte $58, $00,$00,$00,$00, $01	; dummy CRC, also note middle 4 bytes modified above!
#endlocal
