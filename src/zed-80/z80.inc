; Macros and definitions related to the Z80 and its instruction set

M_deref_hl	macro
    ; hl = (hl)
    ; destroys a
    ld	    a, (hl)
    inc	    hl
    ld	    h, (hl)
    ld	    l, a
    endm
