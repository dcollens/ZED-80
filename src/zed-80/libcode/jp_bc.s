; Call jp_bc to make a call to the address in bc. What actually happens is the call to jp_bc loads
; the return address on the stack, then control transfers to jp_bc, which jumps to the address
; in bc, thus giving the effect of "call bc", which isn't a Z80 instruction.
jp_bc::
    push    bc
    ret
