; uint8_t sdc_read_sector(uint32_t lba)
; - 'lba' passed in BCDE
; - one 512-byte sector is read into SDC_buffer
; - returns status in A:
;     0: success
;     non-0: error
#local
sdc_read_sector::
    push    bc
    push    de
    push    hl
    ld	    hl, cmd17_data+1	    ; HL = buffer to write adjusted lba
    call    sdc_lba_adjust	    ; scale lba if needed & store to buffer
    ld	    hl, cmd17_data
    call    sdc_command		    ; send CMD17 (destroys BC, HL)
    or	    a			    ; test response == 0?
    jr	    nz, done		    ; if response != 0, return failure
    ld	    bc, 10000
    call    sdc_poll		    ; poll for data token, up to 100ms
    cp	    0xFE		    ; test token == 0xFE?
    jr	    nz, done		    ; if token != 0xFE, return failure
    ld	    bc, 512
    call    sdc_getbytes	    ; read 512 bytes into SDC_buffer
    ld	    b, 2		    ; skip 2 CRC bytes
xchgLoop:
    ld	    a, 0xFF
    call    sdc_xchg		    ; discard CRC byte
    djnz    xchgLoop
    xor	    a			    ; return 0 (success)
done:
    ld	    l, a		    ; save response byte in A
    call    sdc_cs_high		    ; deselect the card when done
    ld	    a, l		    ; restore response byte to A
    pop	    hl
    pop	    de
    pop	    bc
    ret

cmd17_data:
    .byte $51, $00,$00,$00,$00, $01	; dummy CRC, also note middle 4 bytes modified above!
#endlocal
