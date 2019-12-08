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
    ld	    a, (SDC_flags)
    and	    SDF_BLOCK		    ; test SDC_flags & SDF_BLOCK?
    jr	    nz, begin		    ; if SDC_flags & SDF_BLOCK != 0, begin
    ex	    de, hl		    ; HL = DE
    add	    hl, hl		    ; HL <<= 1, top bit shifted into C flag
    ld	    a, c		    ; A = C
    adc	    a			    ; A = (C << 1) + carry_in
    ld	    b, a
    ld	    c, h
    ld	    d, l
    ld	    e, 0		    ; BCDE = AHL0
begin:
    ld	    hl, (cmd17_data+1)
    ld	    (hl), b
    inc	    hl
    ld	    (hl), c
    inc	    hl
    ld	    (hl), d
    inc	    hl
    ld	    (hl), e		    ; copy address from BCDE into command buffer
    ld	    hl, cmd17_data
    call    sdc_command		    ; send CMD17
    or	    a			    ; test response == 0?
    jr	    nz, done		    ; if response != 0, return failure
    ld	    bc, 10000
    call    sdc_poll		    ; poll for data token, up to 100ms
    cp	    0xFE		    ; test token == 0xFE?
    jr	    nz, done		    ; if token != 0xFE, return failure
    ld	    bc, 512
    call    sdc_getbytes	    ; read 512 bytes into SDC_buffer
    ld	    a, 0xFF
    call    sdc_xchg		    ; discard CRC, byte 1
    ld	    a, 0xFF
    call    sdc_xchg		    ; discard CRC, byte 2
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
