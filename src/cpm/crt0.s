;--------------------------------------------------------------------------
;  crt0.s - crt0 for a Z80 running CP/M
;
; See http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch5.htm
;--------------------------------------------------------------------------

	.module crt0
	.globl	_main

	.area	_HEADER (ABS)

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL

	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG
	.area   _BSS
	.area   _HEAP

	.area   _CODE
	; Set up the stack pointer to FBASE, which is the base address of the BDOS+CBIOS region
	; at the top of RAM. Address 0x0006 has the pointer to FBASE.
	ld	sp, (0x0006)

	;; Initialise global variables
	call	gsinit
	call	_main
	jp	_exit

;__clock::
;	ld	a,#2
;	rst	0x08
;	ret

_exit::
	rst	0x00

	.area   _GSINIT
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:

	.area   _GSFINAL
	ret
