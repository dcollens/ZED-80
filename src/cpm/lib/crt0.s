;--------------------------------------------------------------------------
;  crt0.s - crt0 for a Z80 running CP/M
;
; See http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch5.htm
;--------------------------------------------------------------------------

	.module crt0
	.globl	_main
	.globl	_exit
	.globl	___cmdline_init
	.globl	___Argv
	.globl	___Argc
	.globl	l__INITIALIZER
	.globl	s__INITIALIZED
	.globl	s__INITIALIZER

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
	; The heap ranges upwards from _HEAP (__sdcc_heap) up to the bottom of the stack. The
	; stack size is determined in heap.s

	;; Initialise global variables
	call	gsinit
	;; Parse the CP/M command line
	call	___cmdline_init
	ld	hl, (___Argv)
	push	hl
	ld	hl, (___Argc)
	push	hl
	call	_main
	jp	_exit

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
