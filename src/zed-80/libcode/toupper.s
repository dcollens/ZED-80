; uint8_t toupper(uint8_t ch)
; - map character "ch" to upper-case, if it is a lower-case letter
; - "ch" passed in A
; - result in A
toupper::
    cp	    'a'		; test A < 'a'?
    ret	    c		; if A < 'a', return A
    cp	    'z'+1	; test A > 'z'?
    ret	    nc		; if A > 'z', return A
    and	    ~0x20	; turn off 0x20 bit to map A to upper-case
    ret			; return A
