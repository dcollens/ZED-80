;--------------------------------------------------------------------------
;  heap.s - heap for a Z80 running CP/M (see also crt0.s)
;--------------------------------------------------------------------------
	.module	heap
	; Reserve this much space for the stack.
	STACK_SIZE = 256

        ; Stubs that hook the heap in
        .globl  ___sdcc_heap_init
	.globl	___sdcc_heap_free

        .area   _GSINIT
        call    ___sdcc_heap_init
	; Patch __sdcc_heap_free to use heap space up to the bottom of the stack area.
	ld	bc, #STACK_SIZE
	ld	hl, (0x0006)	    ; pointer to FBASE (see crt0.s)
	and	a		    ; reset carry flag
	sbc	hl, bc		    ; HL := FBASE - STACK_SIZE
	ex	de, hl		    ; DE := end of heap
	ld	hl, (___sdcc_heap_free)	; HL := __sdcc_heap_free
	ld	(hl), e		    ; __sdcc_heap_free->next = DE (i.e. end of heap)
	inc	hl
	ld	(hl), d

        .area   _HEAP
___sdcc_heap::
        ; 16 bytes of heap, as a minimum. We actually patch __sdcc_heap_free to use the entire
	; region up to the bottom of the stack. See the _GSINIT section above.
        .ds     15

        .area   _HEAP_END
___sdcc_heap_end::
        .ds     1
