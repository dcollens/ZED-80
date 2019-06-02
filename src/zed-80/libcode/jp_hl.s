; Call jp_hl to make a call to the address in hl. What actually happens is the call to jp_hl loads
; the return address on the stack, then control transfers to jp_hl, which jumps to the address
; in hl, thus giving the effect of "call hl", which isn't a Z80 instruction.
jp_hl::
    jp	    hl
