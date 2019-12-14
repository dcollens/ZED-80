; void sdc_lba_adjust(uint32_t in_lba, uint8_t *out_lba)
; - 'in_lba' passed in BCDE, 'out_lba' passed in HL
; - result returned in *out_lba, big-endian (!)
; - SDC_flags is checked, and:
;   if SDF_BLOCK is set, *out_lba = in_lba
;   if SDF_BLOCK is unset, *out_lba = lba * 512
; - destroys: A, BC, DE, HL
#local
sdc_lba_adjust::
    ld	    a, (SDC_flags)
    and	    SDF_BLOCK		    ; test SDC_flags & SDF_BLOCK?
    jr	    nz, store		    ; if SDC_flags & SDF_BLOCK != 0, store
    push    hl			    ; save out_lba
    ex	    de, hl		    ; HL = DE
    add	    hl, hl		    ; HL <<= 1, top bit shifted into C flag
    ld	    a, c		    ; A = C
    adc	    a			    ; A = (C << 1) + carry_in
    ld	    b, a
    ld	    c, h
    ld	    d, l
    ld	    e, 0		    ; BCDE = AHL0
    pop	    hl			    ; restore out_lba
store:				    ; copy lba from BCDE into *out_lba
    ld	    (hl), b		    ; out_lba[0] = B
    inc	    hl
    ld	    (hl), c		    ; out_lba[1] = C
    inc	    hl
    ld	    (hl), d		    ; out_lba[2] = D
    inc	    hl
    ld	    (hl), e		    ; out_lba[3] = E
    ret
#endlocal
