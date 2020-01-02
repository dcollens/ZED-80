static char const * const hello = "Hello world!\r\n$";
static void cpm_puts(char const *str) __z88dk_fastcall;

void main() {
    cpm_puts(hello);
}

static void cpm_puts(char const *str) __z88dk_fastcall {
    str;    // unreferenced, passed in HL
    __asm
	push	bc
	push	de
	push	hl
	ld	c, #0x09
	ex	de, hl
	call	#0x0005
	pop	hl
	pop	de
	pop	bc
    __endasm;
}
