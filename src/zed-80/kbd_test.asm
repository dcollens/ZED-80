; Calling convention used in this program
; ---------------------------------------
;
; Unless otherwise noted, the first parameter, and the return value are stored as follows:
; 8 bits: L
; 16 bits: HL
; 32 bits: DEHL
;
; Additional parameters are passed on the stack, left-to-right.
; Parameters and return values larger than 32 bits are passed on the stack (return value
; space set up by caller as a hidden first argument).
; Callee saves/restores any modified registers.
; Caller pops arguments after call returns.
; AF registers are scratch (caller preserves, if needed).

; same as 'rom', except that the default fill byte for 'defs' etc. is 0x00
#target bin

#include "z80.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "keyboard.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"
#include "lcd.inc"
#include "interrupt.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

; Careful, don't put anything before "init", as this is the entry point to our code.
init::
    di
    ld	    sp, USER_STACK_TOP	; first pushed value will reside below SP
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero
    call    seg_init
    call    ctc_init		; this sets the CTC IVEC register to lo(IVT_CTC)
    call    kbdi_init		; initialize the keyboard driver for interrupt-driven mode
    call    lcd_init		; initialize LCD subsystem
    call    lcd_text_init	; initialize the text console
    ; set up interrupts
    ld	    a, hi(IVT)
    ld	    i, a		; I gets high byte of IVT address
    im	    2			; select interrupt mode 2
    ei
    ; run the test program
    call    kbd_test
    jr	    $			; loop forever

; void kbd_test()
#local
kbd_test::
    push    hl
loop:
    call    kbdi_getc		; get keyboard character into L
    call    lcd_putc		; write character to LCD
    jr	    loop
    pop	    hl
    ret
#endlocal

; CTC channel 3 ISR
; - do not modify IX or IY, or call any routine that does, as they aren't saved/restored!
ISR_ctc3::
    ; switch to interrupt stack
    ld	    (Interrupted_SP), sp
    ld	    sp, INTERRUPT_STACK_TOP
    ; save registers
    ex	    af, af'
    exx
    ; actual ISR body
    ld	    l, SEG_DP
    call    seg1_toggle
    ; restore registers
    exx
    ex	    af, af'
    ; restore user stack
    ld	    sp, (Interrupted_SP)
    ; re-enable interrupts and return
    ei
    reti

; Interrupt Vector Table: must be word-aligned, since peripheral IV registers force bit 0 = 0
;
; Note, it also must not cross a 256-byte boundary, since the upper byte of the IVT is stored
; in the CPU's I register and is global to all interrupt sources. We use 16-byte alignment to
; ensure there is no crossing.
    .align  16
IVT::
; CTC's IVT has 4 slots, and we put it first since it needs to be 8-byte aligned.
IVT_CTC::
    .word   ISR_nop	    ; CTC channel 0
    .word   ISR_nop	    ; CTC channel 1
    .word   ISR_nop	    ; CTC channel 2
    .word   ISR_ctc3	    ; CTC channel 3
; PIO has separate IV registers for ports A and B, and we only use A
IVT_PIOA::
    .word   ISR_pioA	    ; PIO port A

#include library "libcode"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here
#include library "libdata"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; user stack segment immediately follows data
; - we don't put the user stack in the data segment because we don't want it to be zeroed out
;   at startup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data STACK,DATA_end

USER_STACK_SIZE	    equ 128 ; size of stack for user code

User_stack:: defs USER_STACK_SIZE ; stack for main user code
USER_STACK_TOP	    equ $
