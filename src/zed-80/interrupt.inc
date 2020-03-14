ISR_STACK_SIZE	    equ 32  ; size of stack for interrupt handlers

M_intr_init	macro
    ; set up interrupts, destroys A
    ld	    a, hi(IVT)
    ld	    i, a		; I gets high byte of IVT address
    im	    2			; select interrupt mode 2
    ei
    endm
