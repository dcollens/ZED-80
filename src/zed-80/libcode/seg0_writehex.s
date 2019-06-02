; void seg0_writehex(uint8_t val)
; - write hex digit in lower nybble of "val" to 7-segment display
; - pass "val" in A
seg0_writehex::
    push    hl
    push    bc
    ld	    bc, hex2seg_table
    and	    0xF	    ; mask off upper nybble of val
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = hex2seg_table + (val & 0xF)
    ld	    a, (Seg0_data)
    and	    SEG_DP
    or	    (hl)    ; a = (*Seg0_data & SEG_DP) | hex2seg_table[val & 0xF]
    call    seg0_write
    pop	    bc
    pop	    hl
    ret
