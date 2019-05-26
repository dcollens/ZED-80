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
#include "lcd.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "keyboard.inc"
#include "ascii.inc"

FORTH_RSTACK_SIZE   equ   256
FORTH_PSTACK_SIZE   equ   256
FORTH_CODE_SIZE     equ   2048

DCR0_DRAWLINE	equ LCDDCR0_DRWLIN | LCDDCR0_RUN
DCR0_DRAWTRI	equ LCDDCR0_DRWTRI | LCDDCR0_RUN
DCR0_FILLTRI	equ LCDDCR0_DRWTRI | LCDDCR0_FILL | LCDDCR0_RUN

DCR1_DRAWRECT	equ LCDDCR1_DRWRCT | LCDDCR1_RUN
DCR1_FILLRECT	equ LCDDCR1_DRWRCT | LCDDCR1_FILL | LCDDCR1_RUN
DCR1_DRAWELL	equ LCDDCR1_DRWELL | LCDDCR1_RUN
DCR1_FILLELL	equ LCDDCR1_DRWELL | LCDDCR1_FILL | LCDDCR1_RUN
DCR1_DRAWRR	equ LCDDCR1_DRWRR | LCDDCR1_RUN
DCR1_FILLRR	equ LCDDCR1_DRWRR | LCDDCR1_FILL | LCDDCR1_RUN

; Add a call to the function to the code pointed to by HL.
M_forth_add_code macro func
    ld      (hl), lo(&func)
    inc     hl
    ld      (hl), hi(&func)
    inc     hl
    endm

M_lcd_rand_line	macro
    call    lcd_rand_line_coords
    M_lcdwrite LCDREG_DCR0, DCR0_DRAWLINE
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_lcd_rand_triangle macro
    call    lcd_rand_triangle_coords
    M_lcdwrite LCDREG_DCR0, DCR0_DRAWTRI
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_lcd_rand_triangle_fill macro
    call    lcd_rand_triangle_coords
    M_lcdwrite LCDREG_DCR0, DCR0_FILLTRI
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_lcd_rand_rect macro
    call    lcd_rand_line_coords
    M_lcdwrite LCDREG_DCR1, DCR1_DRAWRECT
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_lcd_rand_rect_fill macro
    call    lcd_rand_line_coords
    M_lcdwrite LCDREG_DCR1, DCR1_FILLRECT
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_lcd_rand_ellipse macro
    call    lcd_rand_ellipse_coords
    M_lcdwrite LCDREG_DCR1, DCR1_DRAWELL
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_lcd_rand_ellipse_fill macro
    call    lcd_rand_ellipse_coords
    M_lcdwrite LCDREG_DCR1, DCR1_FILLELL
    call    lcd_wait_idle	    ; wait for graphics operation to complete
    endm

M_sio_puts  macro str
    ; Destroys A
    push    hl
    ld	    hl, &str
    call    sio_puts
    pop	    hl
    endm

M_sio_putc  macro ch
    ; Destroys A
    push    hl
    ld	    l, &ch
    call    sio_putc
    pop	    hl
    endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

init::
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero
    call    seg_init
    call    rand_init
    call    kbd_init
    call    lcd_init		    ; initialize LCD subsystem
    call    lcd_test_text
;    ld	    b, 250
;    call    delay_ms
;    call    delay_ms
;    call    delay_ms
;    call    delay_ms
;    call    lcd_test_drawing
    ret

hello_message::
    .text   "ZED-80 Personal Computer", NUL
copyright_message::
    .text   0xA9, "1976 HeadCode", NUL
prompt::
    .text   "> ", NUL

; void lcd_test_drawing()
; - exercise the LCD panel drawing primitives
#local
lcd_test_drawing::
loop:
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_line
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_triangle
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_triangle_fill
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_rect
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_rect_fill
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_ellipse
    call    lcd_rand_fgcolor	    ; randomize FG color
    M_lcd_rand_ellipse_fill
    jr	    loop
    ret
#endlocal

; void lcd_test_text()
; - exercise the LCD panel text primitives
#local
lcd_test_text::
    push    de
    push    hl
    M_lcdwrite0 LCDREG_CCR0
    M_lcdwrite0 LCDREG_CCR1
    M_lcdwrite0 LCDREG_FLDR	    ; vertical gap between lines, in pixels
    M_lcdwrite0 LCDREG_F2FSSR	    ; horizontal gap between characters, in pixels
    M_lcdwrite LCDREG_GTCCR, 0x03   ; enable text cursor, turn on blink
    M_lcdwrite LCDREG_BTCR, 14	    ; text cursor blink period: 15 frames
    M_lcdwrite LCDREG_CURHS, LCD_TXT_WIDTH-1 ; cursor width equal to text width
    M_lcdwrite LCDREG_CURVS, LCD_TXT_HEIGHT-1 ; cursor height equal to text height
    ld	    de, 0xFFFF
    ld	    hl, 0xFFFF
    call    lcd_set_fgcolor	    ; set FG color to white
    call    lcd_wait_idle	    ; must be idle before switching to text mode
    M_lcdwrite LCDREG_ICR, 0x04	    ; set text mode
    ld	    de, 0                   ; move text cursor to (0,0)
    ld      hl, 0		    ; ...
    call    lcd_set_text_xy	    ; ...
    ld	    hl, hello_message
    call    lcd_puts
    call    lcd_crlf
    ld	    hl, copyright_message
    call    lcd_puts
    call    lcd_crlf
    call    forth_init
loop:
    ld      de, 0xFFFF
    ld      h, 0x00
    call    lcd_set_fgcolor
    call    forth_dump_pstack
    ld	    hl, prompt
    call    lcd_puts
    ld      de, 0xFFFF
    ld      h, 0xFF
    call    lcd_set_fgcolor
    call    lcd_gets                ; get a line of code
    call    forth_parse_line
    jr      loop
    pop	    hl
    pop	    de
    ret
#endlocal

; void forth_init()
; - initializes the Forth interpreter/compiler.
; - Notes:
;   - We're using Direct Threaded Code (DTC).
;   - Machine register allocation:
;       - BC: TOS (top of stack)
;       - DE: IP (instruction to decode next)
;       - HL: W (working register)
;       - IX: RSP (return stack pointer)
;       - SP: PSP (parameter stack pointer)
forth_init::
    push    hl

    ; Set up parameter stack. Note that it must always have at least
    ; one item because the first thing we do is pop it off and stick
    ; it into BC.
    ld      hl, Forth_pstack+FORTH_PSTACK_SIZE
    dec     hl
    ld      (hl), 0x12
    dec     hl
    ld      (hl), 0x34
    dec     hl
    ld      (hl), 0x67
    dec     hl
    ld      (hl), 0x89
    ld      (Forth_psp), hl

    ; Set the head of the dictionary linked list.
    call    forth_init_dict

    ; Start in immediate mode.
    xor     a
    ld      (Forth_compiling), a

    ; Program is infinite loop to interpret words.
    ld      hl, Forth_code
    M_forth_add_code forth_interpret
    M_forth_add_code forth_native_branch
    M_forth_add_code -4

    ; Set up HERE pointer.
    ld      (Forth_here), hl

    pop     hl
    ret

; void forth_dump_pstack()
; - dump the parameter stack contents to the console.
#local
forth_dump_pstack::
    push    hl
    push    bc
    push    de

    ; Start at the bottom of the stack.
    ld      hl, Forth_pstack+FORTH_PSTACK_SIZE
    ld      bc, (Forth_psp)

loop:
    ; See if we're done.
    or      a           ; Clear carry.
    sbc     hl, bc
    add     hl, bc
    jr      z, done

    dec     hl
    dec     hl

    ; Print (HL).
    ld      de, hl      ; Save/restore HL.
    ld      a, (hl)     ; Dereference HL.
    inc     hl
    ld      h, (hl)
    ld      l, a
    call    lcd_puthex16
    ld      hl, de

    ; Write space.
    ld      de, hl      ; Save/restore L.
    ld      l, ' '
    call    lcd_putc
    ld      hl, de

    jr      loop

done:
    pop     de
    pop     bc
    pop     hl
    ret
#endlocal

; void forth_parse_line()
; - parse the gets input buffer line.
#local
forth_parse_line::
    push    hl
    push    bc
    push    de
    push    ix
    push    iy

    ; We use the Z80 stack for parameters, so save our SP so we can restore it
    ; and return to our caller even if the Forth program left junk on the
    ; parameter stack.
    ld      hl, 0
    add     hl, sp
    ld      (Forth_orig_sp), hl

    ; Take over the Z80 stack for our parameter stack.
    ld      hl, (Forth_psp)
    ld      sp, hl
    pop     bc

    ; Reset input pointer to start of buffer.
    ld      hl, Gets_buffer
    ld      (Forth_input), hl

    ; Set up return stack.
    ld      ix, Forth_rstack+FORTH_RSTACK_SIZE

    ; Set up IP.
    ld      de, Forth_code

    ; Start the program.
    jp      forth_next

    ; Restore the SP from Forth_orig_sp before jumping here:
forth_parse_line_terminate::
    ; Save our own stack pointer.
    push    bc
    ld      hl, 0
    add     hl, sp
    ld      (Forth_psp), hl

    ; Restore the original stack pointer.
    ld      hl, (Forth_orig_sp)
    ld      sp, hl

    pop     iy
    pop     ix
    pop     de
    pop     bc
    pop     hl
    ret
#endlocal

; void forth_next()
; - code for the Forth "next" routine, which executes the instruction at IP.
#local
forth_next::
    ; W = (IP++)
    ld      a, (de)             ; Low byte of (IP)
    ld      l, a
    inc     de
    ld      a, (de)             ; High byte of (IP)
    ld      h, a
    inc     de
    ; JP (IP)
    jp      (hl)
#endlocal

; void forth_terminate()
; - terminates the interpreter
#local
forth_terminate::
    jp      forth_parse_line_terminate
#endlocal

; Format of the Forth dictionary:
;
; Link (2): Pointer to previous entry in dictionary, or NULL.
; Flags (1): Set of flags about the entry. See F_IMMED.
; Name (len(name)+1): Nul-terminated name of entry.
; Code (...): Code for the routine.

F_IMMED equ 0x01

; Macro for defining words in assembly language.
FORTH_LINK = 0
M_forth_native macro name, flags, label
FORTH_THIS_ADDR = $
    .dw     FORTH_LINK
    .db     &flags
FORTH_LINK = FORTH_THIS_ADDR
    .asciz  &name
forth_native_&label::
    endm

; Macro for defining words as a sequence of Forth native calls.
; Be sure to finish with forth_native_exit.
M_forth_word macro name, flags, label
    M_forth_native &name, &flags, &label
    call    forth_native_enter
    endm

; - code for entering a Forth word.
    M_forth_native "enter", 0, enter
    ; Push IP onto return address stack.
    dec     ix
    ld      (ix+0), d
    dec     ix
    ld      (ix+0), e

    ; IP = W+2. We were called here from the code field, so the stack
    ; contains the address of the next IP.
    pop     de
    jp      forth_next

; - code for exiting a Forth word.
    M_forth_native "exit", 0, exit
    ; Pop IP from return address stack.
    ld      e, (ix+0)
    inc     ix
    ld      d, (ix+0)
    inc     ix
    jp      forth_next

; - duplicates the word at the top of the parameter stack.
    M_forth_native "dup", 0, dup
    push    bc
    jp      forth_next

; - adds the top two entries in the parameter stack.
    M_forth_native "+", 0, add
    pop     hl
    add     hl, bc
    ld      bc, hl
    jp      forth_next

; - prints the number on the top of the stack.
    M_forth_native ".", 0, dot
    ld      hl, bc
    pop     bc
    call    lcd_puthex16
    call    lcd_crlf
    jp      forth_next

; - pushes the next word onto the parameter stack.
    M_forth_native "lit", 0, lit
    push    bc
    ld      hl, de
    ld      bc, (hl)
    inc     de
    inc     de
    jp      forth_next

; - adds the word at the top of the stack to our code.
    M_forth_native ",", 0, comma
    ld      hl, bc
    call    forth_comma
    pop     bc
    jp      forth_next

; - adds the word in HL to our code.
forth_comma:
    push    bc
    ld      bc, hl
    ld      hl, (Forth_here)
    ld      (hl), bc
    inc     hl
    inc     hl
    ld      (Forth_here), hl
    pop     bc
    ret

; Go into immediate (non-compiling) mode.
    M_forth_native "[", F_IMMED, lbrac
    xor     a
    ld      (Forth_compiling), a
    jp      forth_next

; Go into compiling mode.
    M_forth_native "]", 0, rbrac
    ld      a, 1
    ld      (Forth_compiling), a
    jp      forth_next

; - put the address of the code of the word that's next in
; - the stream onto the stack. This version only works
; - in compiled mode. There's another version that uses
; - word, find, and cfa, but I think it only works in
; - immediate mode, and I don't need it then. See below.
; - Note that this version has identical code to the "lit"
; - word, so we could just use that instead?
    M_forth_native "'", 0, tick
    push    bc
    ld      hl, de
    ld      bc, (hl)
    inc     de
    inc     de
    jp      forth_next

; Immediate mode version:
;;    call    forth_word
;;    call    forth_find
;;    call    forth_cfa
;;    push    bc
;;    ld      bc, hl
;;    jp      forth_next

; - lists code memory.
    M_forth_native "code", 0, code
#local
    push    bc
    ld      hl, Forth_code      ; Start.
    ld      bc, (Forth_here)    ; End.

loop:
    ; See if we're done.
    or      a           ; Clear carry.
    sbc     hl, bc
    add     hl, bc
    jr      z, done

    ; Dereference HL.
    ld      a, (hl)
    push    hl
    ld      l, a

    ; Print.
    call    lcd_puthex8
    ld      l, ' '
    call    lcd_putc

    ; Next word.
    pop     hl
    inc     hl
    jr      loop

done:
    call    lcd_crlf
    pop     bc
    jp      forth_next
#endlocal

; - lists all words in the dictionary.
    M_forth_native "words", 0, words
#local
    ; Start at head of linked list.
    ld      hl, (Forth_dict)

loop:
    ; See if HL is null.
    ld      a, l
    or      a
    jr      nz, not_null
    ld      a, h
    or      a
    jr      z, is_null

not_null:
    ; Save node pointer for later.
    push    hl

    ; Skip link and flags.
    inc     hl
    inc     hl
    inc     hl

    ; Print name.
    call    lcd_puts

    ; Print space.
    ld      l, ' '
    call    lcd_putc

    ; Restore node pointer.
    pop     hl

    ; Dereference to get next node.
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a

    jr      loop

is_null:
    call    lcd_crlf
    jp      forth_next
#endlocal

; - creates a new entry in the dictionary.
; - the top of the stack has the name.
    M_forth_native "create", 0, create
#local
    ld      hl, (Forth_here)

    ; Set up next-word pointer.
    push    de
    ld      de, (Forth_dict)
    ld      (hl), de
    pop     de
    ; Write our new linked list head.
    ld      (Forth_dict), hl
    ; Skip link pointer.
    inc     hl
    inc     hl

    ; Write flags. Default to zero.
    ld      (hl), 0
    inc     hl

    ; Copy name from BC (top of stack).
loop:
    ld      a, (bc)
    ld      (hl), a
    inc     hl
    inc     bc
    or      a
    jr      nz, loop

    ; Add a "call" instruction. We'll fill in the address later from Forth itself.
    ld      (hl), opcode(call NN)
    inc     hl

    ; Write back our new "here".
    ld      (Forth_here), hl
    pop     bc
    jp      forth_next
#endlocal

; - skips the header of a dictionary entry.
    M_forth_native ">cfa", 0, cfa
    ld      hl, bc
    call    forth_cfa
    ld      bc, hl
    jp      forth_next

; - skips the header of a dictionary entry.
#local
forth_cfa::
    ; HL is pointing to the start of the dictionary entry.
    ; Skip the link pointer and flags.
    inc     hl
    inc     hl
    inc     hl

    ; Skip the nul-terminated string.
loop:
    ld      a, (hl)
    inc     hl
    or      a
    jr      nz, loop

    ret
#endlocal


; - gets the next word from the input stream and puts its address
; - on the parameter stack.
    M_forth_native "word", 0, word
    push    bc
    call    forth_word
    ld      bc, hl
    jp      forth_next

; - gets the next word from the input stream and returns its address in HL.
; - The pointer will point to a NUL byte if we're at the end of the buffer.
#local
forth_word::
    ld      hl, (Forth_input)

    ; Skip whitespace.
whitespace_loop:
    ld      a, (hl)
    cp      ' '
    jr      nz, end_of_whitespace
    inc     hl
    jr      whitespace_loop

end_of_whitespace:
    ; We're at the start of the word, record that.
    push    hl

    ; Skip word.
word_loop:
    ld      a, (hl)
    cp      ' '
    jr      z, end_of_word
    cp      NUL
    jr      z, end_of_string
    inc     hl
    jr      word_loop

end_of_word:
    ; NUL-terminate word.
    ld      (hl), NUL

    ; Skip new NUL.
    inc     hl

end_of_string:
    ; Record new position.
    ld      (Forth_input), hl

    ; Skip back to start of word.
    pop     hl
    ret
#endlocal

; - skips over the number of bytes specified at the IP.
    M_forth_native "branch", 0, branch
    push    bc
forth_native_branch_tail::
    ld      hl, de
    ld      bc, (hl)
    add     hl, bc
    ld      de, hl
    pop     bc
    jp      forth_next

; - skips over the number of bytes specified at the IP if TOS is zero.
    M_forth_native "0branch", 0, 0branch
#local
    ; Check top of stack (BC).
    ld      a, b
    or      a
    jr      nz, no_skip
    ld      a, c
    or      a
    jp      z, forth_native_branch_tail

no_skip:
    ; Still need to skip the count itself.
    inc     de
    inc     de
    pop     bc
    jp      forth_next
#endlocal

; - finds the string at the top of the stack in the dictionary.
; - returns a pointer to the dictionary entry or NULL if not found.
    M_forth_native "find", 0, find
    ld      hl, bc
    call    forth_find
    ld      bc, hl
    jp      forth_next

; - toggles the immediate flag of the most recently defined word.
    M_forth_native "immediate", F_IMMED, immediate
    ; Get most recent word.
    ld      hl, (Forth_dict)
    ; Skip link.
    inc     hl
    inc     hl
    ; Toggle immediate flag.
    ld      a, (hl)
    xor     F_IMMED
    ld      (hl), a
    jp      forth_next

; - starts a definition of a new word.
    M_forth_word ":", 0, colon
    .dw     forth_native_word
    .dw     forth_native_create
    .dw     forth_native_lit
    .dw     forth_native_enter
    .dw     forth_native_comma
    .dw     forth_native_rbrac
    .dw     forth_native_exit

; - end a definition of a new word.
    M_forth_word ";", F_IMMED, semicolon
    .dw     forth_native_lit
    .dw     forth_native_exit
    .dw     forth_native_comma
    .dw     forth_native_lbrac
    .dw     forth_native_exit

; - draws a line. args are x1, y1, x2, y2, pushed in that order.
    M_forth_native "line", 0, line
    ld      hl, bc                  ; y2
    ld      bc, de                  ; save DE
    pop     de                      ; x2
    call    lcd_line_end_xy
    pop     hl                      ; y1
    pop     de                      ; x1
    call    lcd_line_start_xy
    M_lcdwrite LCDREG_DCR0, DCR0_DRAWLINE
    call    lcd_wait_idle           ; wait for graphics operation to complete
    ld      de, bc                  ; restore DE
    pop     bc
    jp      forth_next

; - finds the string pointed to by HL in the dictionary.
; - returns a pointer to the dictionary entry or NULL if not found.
#local
forth_find::
    push    bc
    ld      bc, hl

    ; Start at head of linked list.
    ld      hl, (Forth_dict)

loop:
    ; See if HL is null.
    ld      a, l
    or      a
    jp      nz, not_null
    ld      a, h
    or      a
    jp      z, done

not_null:
    ; Point to name of routine.
    inc     hl
    inc     hl
    inc     hl

    ; BC and HL are both now pointing to strings. Compare them.
    ; The result is in the zero flag.
    call    forth_strequ

    ; Point back to link pointer. These don't modify the zero flag.
    dec     hl
    dec     hl
    dec     hl

    ; forth_strequ puts the result in the zero flag, where set means equal.
    jp      z, done

    ; Jump to next entry in linked list.
    ld      a, (hl)
    inc     hl
    ld      h, (hl)
    ld      l, a

    jp      loop

done:
    pop     bc
    ret
#endlocal

; - grabs the next word and processes it (runs it or compiles it).
#local
forth_interpret::
    ; Parse the next space-delimited word.
    call    forth_word

    ; See if we're at the end of the input buffer.
    ld      a, (hl)
    or      a
    jp      z, forth_terminate

    ; Save name for later (number parsing and error display).
    push    hl

    ; Find it in the dictionary.
    call    forth_find

    ; See if it was found.
    ld      a, l
    or      a
    jr      nz, found
    ld      a, h
    or      a
    jr      nz, found

    ; Not found, parse as number and push it.
    pop     hl
    call    parse_hex16
    ; XXX detect that parsing failed, and print error message below.

    ; It's a number. Check if we're in immediate mode.
    ld      a, (Forth_compiling)
    or      a
    jr      z, not_found_immediate

    ; Compile IMM.
    push    hl
    ld      hl, forth_native_lit
    call    forth_comma

    ; Compile number.
    pop     hl
    call    forth_comma
    jp      forth_next

not_found_immediate:
    ; Push parsed value.
    push    bc
    ld      bc, hl
    jp      forth_next

    ; Not found, display error message.
    ld      hl, word_not_found_error_message
    call    lcd_puts
    pop     hl
    call    lcd_puts
    call    lcd_crlf
    jp      forth_terminate

found:
    ; Throw away saved name, we don't need it if it was found.
    inc     sp
    inc     sp

    ; Check if we're in immediate mode.
    ld      a, (Forth_compiling)
    or      a
    jr      z, found_immediate

    ; Check immediate flag of word.
    push    hl
    inc     hl
    inc     hl
    ld      a, (hl)
    pop     hl
    and     F_IMMED
    jr      nz, found_immediate

    ; We're compiling it.
    call    forth_cfa
    call    forth_comma
    jp      forth_next

found_immediate:
    ; Move to code for word and execute it.
    call    forth_cfa
    jp      (hl)

word_not_found_error_message:
    .text   "Word not found: ", NUL
#endlocal

; void forth_strequ()
; - compares nul-terminated strings in HL and BC.
; - puts the result in the zero flag (set = equal, cleared = not equal).
#local
forth_strequ::
    push    hl
    push    bc

loop:
    ; Compare the characters.
    ld      a, (bc)
    cp      (hl)
    jr      nz, done

    ; They're equal, see if we're done.
    or      a
    jr      z, done

    inc     hl
    inc     bc
    jr      loop

done:
    pop     bc
    pop     hl
    ret
#endlocal

; void forth_init_dict()
; - initialize the Forth dictionary, erasing all dynamically-created words.
; - This routine needs to be placed after all uses of the macro M_forth_native.
forth_init_dict::
    push    hl
    ; Initialize dictionary linked list pointer.
    ld      hl, Forth_dict
    ld      (hl), lo(FORTH_LINK)
    inc     hl
    ld      (hl), hi(FORTH_LINK)
    pop     hl
    ret

; uint16_t parse_hex16(char *s)
; - parses a 16-bit hex value from "s".
#local
parse_hex16::
    push    de

    ; Parse high byte.
    ld      de, hl
    call    parse_hex8

    ; Parse low byte.
    ex      de, hl
    inc     hl
    inc     hl
    call    parse_hex8

    ; Combine bytes.
    ld      h, e

    pop     de
    ret
#endlocal

; uint8_t parse_hex8(char *s)
; - parses an 8-bit hex value from "s".
#local
parse_hex8::
    push    de
    push    bc

    ; Parse first nybble.
    ld      bc, hl
    ld      l, (hl)
    call    hex2bin

    ; Shift left into high nybble.
    ld      e, l
    sla     e
    sla     e
    sla     e
    sla     e

    ; Parse second nybble.
    ld      hl, bc
    inc     hl
    ld      l, (hl)
    call    hex2bin

    ; Combine nybbles.
    ld      a, e
    or      l
    ld      l, a

    pop     bc
    pop     de
    ret
#endlocal

; void lcd_putdec16(uint16_t value)
; - writes a 16-bit decimal value to the LCD
#local
lcd_putdec16::
    push    bc
    push    hl
    ld      bc, -10000
    call    handle_digit
    ld      bc, -1000
    call    handle_digit
    ld      bc, -100
    call    handle_digit
    ld      c, -10
    call    handle_digit
    ld      c, -1
    call    handle_digit
    pop     hl
    pop     bc
    ret

handle_digit:
    ld      a, '0'-1
increment_digit:
    inc     a
    add     hl, bc
    jr      c, increment_digit
    sbc     hl, bc
    push    hl
    ld      l, a
    call    lcd_putc
    pop     hl
    ret
#endlocal

; void lcd_gets()
; - reads a line of text from keyboard, not including newline, into Gets_buffer.
; - leaves the buffer nul-terminated.
#local
lcd_gets::
    push    bc
    push    de
    push    hl
    ld      de, Gets_buffer	    ; DE = input_buffer
    ld	    b, 0		    ; B = byte_count

loop:
    call    kbd_getc		    ; get next cooked character
    ld      a, l		    ; A = input_char
    cp      KEY_ENTER		    ; test input_char == KEY_ENTER?
    jr      z, done		    ; if equal, return
    cp	    KEY_BS		    ; test input_char == KEY_BS?
    jr	    nz, tryStore	    ; if not BS, try to store it

    ; Backspace processing
    ld	    a, b
    and	    a			    ; test byte_count == 0?
    jr	    z, loop		    ; if byte_count == 0, ignore BS, and get next char
    call    lcd_bs		    ; move text position back and erase character
    dec	    de			    ; rewind input_buffer
    dec	    b			    ; decrement byte_count
    jr	    loop		    ; get next character
    
tryStore:
    ld	    a, b
    cp	    Gets_buffer_sz-1	    ; test byte_count < Gets_buffer_sz-1?
    jr	    nc, loop		    ; if byte_count >= Gets_buffer_sz-1, reject further input
    ld      a, l
    ld      (de), a		    ; store input_char in buffer
    call    lcd_putc		    ; display input_char
    inc     de			    ; advance input_buffer
    inc	    b			    ; increment byte_count
    jr	    loop

done:
    xor	    a
    ld      (de), a		    ; store terminating NUL
    call    lcd_crlf		    ; advance display pointer to next line
    pop     hl
    pop     de
    pop	    bc
    ret
#endlocal

; void lcd_init()
; - set up the LCD panel by programming the RA8876 registers
#local
lcd_init::
    push    de
    push    hl
    in	    a, (PORT_LCDCMD)	    ; read status byte
    ld	    l, a
    call    seg_writehex
    ; RA8876_initial()
    ;	RA8876_SW_Reset();
    M_out   (PORT_LCDCMD), LCDREG_SRR
    in	    a, (PORT_LCDDAT)
    or	    0x01
    out	    (PORT_LCDDAT), a
wait_reset:
    in	    a, (PORT_LCDDAT)
    and	    0x01
    jr	    nz, wait_reset
    ;	RA8876_PLL_Initial(); 
    M_lcdwrite LCDREG_PPLLC1, 2
    M_lcdwrite LCDREG_MPLLC1, 2
    M_lcdwrite LCDREG_SPLLC1, 2
    M_lcdwrite LCDREG_PPLLC2, 7
    M_lcdwrite LCDREG_MPLLC2, 19
    M_lcdwrite LCDREG_SPLLC2, 19
    M_out   (PORT_LCDCMD), LCDREG_CCR
    M_out0  (PORT_LCDDAT)
    call    delay_1ms
    M_out   (PORT_LCDDAT), 0x80
    call    delay_1ms
    ;	RA8876_SDRAM_initail();
    M_lcdwrite LCDREG_SDRAR, 0x29
    M_lcdwrite LCDREG_SDRMD, 0x03
    M_lcdwrite LCDREG_SDR_REF_ITVL0, 0x0B
    M_lcdwrite LCDREG_SDR_REF_ITVL1, 0x03
    M_lcdwrite LCDREG_SDRCR, 0x01
wait_sdram:
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_RAMRDY
    jr	    z, wait_sdram
    call delay_1ms
    ;	TFT_24bit();
    ;	Host_Bus_8bit();
    M_out   (PORT_LCDCMD), LCDREG_CCR
    in	    a, (PORT_LCDDAT)
    and	    ~0x19
    out	    (PORT_LCDDAT), a
    ;	RGB_8b_16bpp();
    ;	MemWrite_Left_Right_Top_Down();
    M_lcdwrite0 LCDREG_MACR
    ;	Graphic_Mode();
    ;	Memory_Select_SDRAM();   
    M_out   (PORT_LCDCMD), LCDREG_ICR
    in	    a, (PORT_LCDDAT)
    and	    ~0x07
    out	    (PORT_LCDDAT), a
    ;	HSCAN_L_to_R();
    ;	VSCAN_T_to_B();
    ;	PDATA_Set_RGB();
    ;	PCLK_Falling();
    M_out   (PORT_LCDCMD), LCDREG_DPCR
    in	    a, (PORT_LCDDAT)
    and	    ~0x1F
    or	    0x80
    out	    (PORT_LCDDAT), a
    ;	DE_High_Active();
    ;	HSYNC_High_Active();
    ;	VSYNC_High_Active(); 
    M_out   (PORT_LCDCMD), LCDREG_PCSR
    in	    a, (PORT_LCDDAT)
    and	    ~0x20
    or	    0xC0
    out	    (PORT_LCDDAT), a
    ;	LCD_HorizontalWidth_VerticalHeight(1024,600);
    M_lcdwrite LCDREG_HDWR, 127
    M_lcdwrite0 LCDREG_HDWFTR
    M_lcdwrite LCDREG_VDHR0, 0x57
    M_lcdwrite LCDREG_VDHR1, 0x02
    ;	LCD_Horizontal_Non_Display(160);		   //30
    M_lcdwrite LCDREG_HNDR, 19
    M_lcdwrite0 LCDREG_HNDFTR
    ;	LCD_HSYNC_Start_Position(160);
    M_lcdwrite LCDREG_HSTR, 19
    ;	LCD_HSYNC_Pulse_Width(70);
    M_lcdwrite LCDREG_HPWR, 7
    ;	LCD_Vertical_Non_Display(23);		   //16
    M_lcdwrite LCDREG_VNDR0, 22
    M_lcdwrite0 LCDREG_VNDR1
    ;	LCD_VSYNC_Start_Position(12);
    M_lcdwrite LCDREG_VSTR, 11
    ;	LCD_VSYNC_Pulse_Width(10);
    M_lcdwrite LCDREG_VPWR, 9
    ;	Select_Main_Window_16bpp();
    ; This is the default, so we don't really need to do this.
    M_out   (PORT_LCDCMD), LCDREG_MPWCTR
    in	    a, (PORT_LCDDAT)
    and	    ~0x08
    or	    0x04
    out	    (PORT_LCDDAT), a
    ;	Main_Image_Start_Address(0);				
    ; The default is start address 0, so we don't really need to do this.
    M_lcdwrite0 LCDREG_MISA0
    M_lcdwrite0 LCDREG_MISA1
    M_lcdwrite0 LCDREG_MISA2
    M_lcdwrite0 LCDREG_MISA3
    ;	Main_Image_Width(1024);							
    M_lcdwrite0 LCDREG_MIW0
    M_lcdwrite LCDREG_MIW1, 4
    ;	Main_Window_Start_XY(0,0);	
    ; The default is (0,0), so we don't really need to do this.
    M_lcdwrite0 LCDREG_MWULX0
    M_lcdwrite0 LCDREG_MWULX1
    M_lcdwrite0 LCDREG_MWULY0
    M_lcdwrite0 LCDREG_MWULY1
    ;	Canvas_Image_Start_address(0);
    ; The default is start address 0, so we don't really need to do this.
    M_lcdwrite0 LCDREG_CVSSA0
    M_lcdwrite0 LCDREG_CVSSA1
    M_lcdwrite0 LCDREG_CVSSA2
    M_lcdwrite0 LCDREG_CVSSA3
    ;	Canvas_image_width(1024);
    M_lcdwrite0 LCDREG_CVS_IMWTH0
    M_lcdwrite LCDREG_CVS_IMWTH1, 4
    ;	Active_Window_XY(0,0);
    ; The default is (0,0), so we don't really need to do this.
    M_lcdwrite0 LCDREG_AWUL_X0
    M_lcdwrite0 LCDREG_AWUL_X1
    M_lcdwrite0 LCDREG_AWUL_Y0
    M_lcdwrite0 LCDREG_AWUL_Y1
    ;	Active_Window_WH(1024,600);
    M_lcdwrite0 LCDREG_AW_WTH0
    M_lcdwrite LCDREG_AW_WTH1, 4
    M_lcdwrite LCDREG_AW_HT0, 88
    M_lcdwrite LCDREG_AW_HT1, 2
    ;	Memory_XY_Mode();
    ;	Memory_16bpp_Mode();
    M_lcdwrite LCDREG_AW_COLOR, 0x01
    ;	Select_Main_Window_16bpp();
    ; Unaccountably, the sample code calls this again, even though it was done earlier, and is
    ; the default, so we skip it.
    ; Display_ON();
    M_out   (PORT_LCDCMD), LCDREG_DPCR
    in	    a, (PORT_LCDDAT)
    or	    0x40
    out	    (PORT_LCDDAT), a
    ; delay_ms(20);
    ld	    l, 20
    call    delay_ms
    ; Clear the screen
    ld	    de, 0
    ld	    hl, 0
    call    lcd_set_fgcolor	    ; set FG color to black
    call    lcd_line_start_xy	    ; set start to 0,0
    ld	    de, LCD_WIDTH-1
    ld	    hl, LCD_HEIGHT-1
    call    lcd_line_end_xy	    ; set end to maxX,maxY
    M_lcdwrite LCDREG_DCR1, DCR1_FILLRECT ; draw filled rectangle to clear screen
    call    lcd_wait_idle
    call    lcd_bl_on		    ; turn on backlight
    pop	    hl
    pop	    de
    ret
#endlocal

; void lcd_bl_on()
; - turn on LCD backlight
lcd_bl_on::
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS
    out	    (PORT_SIOACTL), a
    ret

; void lcd_bl_off()
; - turn off LCD backlight
lcd_bl_off::
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    out	    (PORT_SIOACTL), a
    ret

; void lcd_set_fgcolor(uint8_t r, uint8_t g, uint8_t b)
; - sets foreground drawing color to (r,g,b)
; - "r" in D, "g" in E, "b" in H
; - R,G,B uses upper 5,6,5 bits of precision only (i.e. 16bpp color)
lcd_set_fgcolor::
    M_lcdwrite LCDREG_FGCR, d
    M_lcdwrite LCDREG_FGCG, e
    M_lcdwrite LCDREG_FGCB, h
    ret

; void lcd_rand_fgcolor()
; - randomizes foreground drawing color
lcd_rand_fgcolor::
    push    hl
    call    rand16
    M_lcdwrite LCDREG_FGCR, h
    M_lcdwrite LCDREG_FGCG, l
    call    rand16
    M_lcdwrite LCDREG_FGCB, h
    pop	    hl
    ret

; void lcd_line_start_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_line_start_xy::
    M_lcdwrite LCDREG_DLHSR0, e
    M_lcdwrite LCDREG_DLHSR1, d
    M_lcdwrite LCDREG_DLVSR0, l
    M_lcdwrite LCDREG_DLVSR1, h
    ret

; void lcd_line_end_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_line_end_xy::
    M_lcdwrite LCDREG_DLHER0, e
    M_lcdwrite LCDREG_DLHER1, d
    M_lcdwrite LCDREG_DLVER0, l
    M_lcdwrite LCDREG_DLVER1, h
    ret

; void lcd_triangle_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
; - this sets the third point for a triangle (first two are the "line start" and "line end" points)
lcd_triangle_xy::
    M_lcdwrite LCDREG_DTPH0, e
    M_lcdwrite LCDREG_DTPH1, d
    M_lcdwrite LCDREG_DTPV0, l
    M_lcdwrite LCDREG_DTPV1, h
    ret

; void lcd_set_text_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_set_text_xy::
    M_lcdwrite LCDREG_F_CURX0, e
    M_lcdwrite LCDREG_F_CURX1, d
    M_lcdwrite LCDREG_F_CURY0, l
    M_lcdwrite LCDREG_F_CURY1, h
    ret

; void lcd_set_text_x(uint16_t x)
lcd_set_text_x::
    M_lcdwrite LCDREG_F_CURX0, l
    M_lcdwrite LCDREG_F_CURX1, h
    ret

; void lcd_set_text_y(uint16_t y)
;lcd_set_text_y::
;    M_lcdwrite LCDREG_F_CURY0, l
;    M_lcdwrite LCDREG_F_CURY1, h
;    ret

; uint16_t lcd_get_text_x()
; - returns current text X position, in pixels
lcd_get_text_x::
    M_out   (PORT_LCDCMD), LCDREG_F_CURX0
    in	    a, (PORT_LCDDAT)
    ld	    l, a
    M_out   (PORT_LCDCMD), LCDREG_F_CURX1
    in	    a, (PORT_LCDDAT)
    ld	    h, a
    ret

; uint16_t lcd_get_text_y()
; - returns current text Y position, in pixels
lcd_get_text_y::
    M_out   (PORT_LCDCMD), LCDREG_F_CURY0
    in	    a, (PORT_LCDDAT)
    ld	    l, a
    M_out   (PORT_LCDCMD), LCDREG_F_CURY1
    in	    a, (PORT_LCDDAT)
    ld	    h, a
    ret

; void lcd_crlf()
; - advance to first column of next line
lcd_crlf::
    push    de
    push    hl
    call    lcd_get_text_y
    ld	    de, LCD_TXT_HEIGHT
    add	    hl, de
    ld	    de, 0
    call    lcd_set_text_xy
    pop	    hl
    pop	    de
    ret

; void lcd_bs()
; - move text position back one column
; - erase character under new position
#local
lcd_bs::
    push    de
    push    hl
    call    lcd_get_text_x	; HL = text_x
    ld	    de, LCD_TXT_WIDTH	; DE = LCD_TXT_WIDTH
    or	    a			; clear carry flag
    sbc	    hl, de		; HL = text_x - LCD_TXT_WIDTH
    jr	    c, done		; if text_x < LCD_TXT_WIDTH, give up (TODO: should wrap up 1 row)
    call    lcd_set_text_x	; move cursor back one column
    ex	    de, hl		; DE = saved text position
    ld	    l, ' '
    call    lcd_putc		; overwrite erased character position with a blank space
    ex	    de, hl		; HL = saved text position
    call    lcd_set_text_x	; move cursor back one column (after erasing old character)
done:
    pop	    hl
    pop	    de
    ret
#endlocal

; void lcd_ellipse_xy(uint16_t x, uint16_t y)
; - "x" in DE, "y" in HL
lcd_ellipse_xy::
    M_lcdwrite LCDREG_DEHR0, e
    M_lcdwrite LCDREG_DEHR1, d
    M_lcdwrite LCDREG_DEVR0, l
    M_lcdwrite LCDREG_DEVR1, h
    ret

; void lcd_ellipse_radii(uint16_t rx, uint16_t ry)
; - "rx" in DE, "ry" in HL
lcd_ellipse_radii::
    M_lcdwrite LCDREG_ELL_A0, e
    M_lcdwrite LCDREG_ELL_A1, d
    M_lcdwrite LCDREG_ELL_B0, l
    M_lcdwrite LCDREG_ELL_B1, h
    ret

; void lcd_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to LCD
#local
lcd_puts::
    push    hl
    push    bc
    M_out   (PORT_LCDCMD), LCDREG_MRWDP
next_byte:
    ld	    a, (hl)
    inc	    hl
    or	    a		; fast test a==0
    jr	    z, done
    ld	    b, a
wait_fifo_room:
    ; wait until memory FIFO is non-full
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_WRFULL
    jr	    nz, wait_fifo_room
    ; write output character
    ld	    a, b
    out	    (PORT_LCDDAT), a	; send byte to LCD panel
    jr	    next_byte
done:
    call    lcd_wait_idle
    pop	    bc
    pop	    hl
    ret
#endlocal

; void lcd_putc(uint8_t ch)
; - write the single character in "ch" to LCD
#local
lcd_putc::
    M_out   (PORT_LCDCMD), LCDREG_MRWDP
wait_fifo_room:
    ; wait until memory FIFO is non-full
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_WRFULL
    jr	    nz, wait_fifo_room
    ; write output character
    ld	    a, l
    out	    (PORT_LCDDAT), a	; send byte to LCD panel
    ; call lcd_wait_idle
; FALLING THROUGH!!!

; void lcd_wait_idle()
; - waits until geometry engine, BTE, text/graphic write complete
lcd_wait_idle::
    in	    a, (PORT_LCDCMD)
    and	    LCDSTAT_BUSY
    jr	    nz, lcd_wait_idle
    ret
#endlocal

; void lcd_puthex8(uint8_t value)
; - write an 8-bit hex value to the LCD
lcd_puthex8::
    push    hl
    ld	    h, l
    srl	    l
    srl	    l
    srl	    l
    srl	    l
    call    bin2hex
    call    lcd_putc
    ld	    l, h
    call    bin2hex
    call    lcd_putc
    pop	    hl
    ret

; void lcd_puthex16(uint16_t value)
; - write a 16-bit hex value to the LCD
lcd_puthex16::
    push    hl
    ld      l, h
    call    lcd_puthex8
    pop     hl
    jr	    lcd_puthex8

; void lcd_rand_line_coords()
; - set up random coordinates for line start & line end
#local
lcd_rand_line_coords::
    push    bc
    push    de
    push    hl
do_line_coords:
    ld	    bc, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    bc, LCD_HEIGHT
    call    rand16_modn
    call    lcd_line_start_xy	    ; random start X,Y
    ld	    bc, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    bc, LCD_HEIGHT
    call    rand16_modn
    call    lcd_line_end_xy	    ; random end X,Y
    pop	    hl
    pop	    de
    pop	    bc
    ret

; void lcd_rand_triangle_coords()
; - set up random coordinates for the three triangle vertices
lcd_rand_triangle_coords::
    push    bc
    push    de
    push    hl
    ld	    bc, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    bc, LCD_HEIGHT
    call    rand16_modn
    call    lcd_triangle_xy	    ; random triangle 3rd vertex X,Y
    jr	    do_line_coords	    ; random triangle 1st & 2nd vertices
#endlocal

; void lcd_rand_ellipse_coords()
; - set up random coordinates and size for ellipse/circle
lcd_rand_ellipse_coords::
    push    bc
    push    de
    push    hl
    ld	    bc, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    bc, LCD_HEIGHT
    call    rand16_modn
    call    lcd_ellipse_xy	    ; random center X,Y
    ld	    bc, LCD_WIDTH/2
    call    rand16_modn
    ex	    de, hl
    ld	    bc, LCD_HEIGHT/2
    call    rand16_modn
    call    lcd_ellipse_radii	    ; random radii
    pop	    hl
    pop	    de
    pop	    bc
    ret

; void bzero(uint8_t *ptr, uint16_t len)
; NOTE: ptr in HL, len in BC
; - zero "len" bytes starting at address "ptr"
#local
bzero::
    push    de
    ld	    a, b
    or	    c
    jr	    z, done		; len is 0
    ld	    (hl), 0		; zero first byte of DATA seg
    dec	    bc
    ld	    a, b
    or	    c
    jr	    z, done		; len is 1
    ld	    e, l
    ld	    d, h
    inc	    de			; de = hl + 1
    ldir			; zero last len-1 bytes
done:
    pop	    de
    ret
#endlocal

rand_init::
    push    hl
    ld	    hl, 0x2019
    ld	    (Rand16_seed1), hl
    ld	    hl, 0xA05F
    ld	    (Rand16_seed2), hl
    pop	    hl
    ret

; uint16_t rand16()
; Inputs:
;   (Rand16_seed1) contains a 16-bit seed value
;   (Rand16_seed2) contains a NON-ZERO 16-bit seed value
; Outputs:
;   HL is the result
;   BC, DE is preserved
; Destroys:
;   AF
; cycle: 4,294,901,760 (almost 4.3 billion)
; 160cc
; 26 bytes
rand16:
    push bc
    ld hl,(Rand16_seed1)
    ld b,h
    ld c,l
    add hl,hl
    add hl,hl
    inc l
    add hl,bc
    ld (Rand16_seed1),hl
    ld hl,(Rand16_seed2)
    add hl,hl
    sbc a,a
    and %00101101
    xor l
    ld l,a
    ld (Rand16_seed2),hl
    add hl,bc
    pop bc
    ret

; uint16_t rand16_modn(uint16_t n)
; - pass "n" in BC
; - returns a 16-bit pseudo-random number on the interval [0, n) in HL
rand16_modn::
    push    de
    ld	    d, b
    ld	    e, c	; DE = BC
    call    rand16	; HL = rand16()
    ld	    a, h
    ld	    c, l	; AC = HL
    call    div_ac_de	; (AC, HL) = divmod16(AC, DE)
    pop	    de		; we don't want the quotient, only the remainder in HL
    ret

; (uint16_t, uint16_t) divmod16(uint16_t n, uint16_t d)
; - divides "n" by "d", returning n / d and n % d
; - pass "n" in DE, "d" in BC
; - returns quotient (n/d) in DE, remainder (n%d) in HL
#local
divmod16_me::
    ld	    a, 16	; max 16 iterations
    ld	    hl, 0
    jr	    start
loop:
    add	    hl, bc	; HL += "d"
loop2:
    dec	    a		; decrement loop counter
    ret	    z		; return if done
start:
    sla	    e
    rl	    d		; shift DE left 1, high bit to carry flag
    adc	    hl, hl	; HL = (HL << 1) + carry, with carry flag receiving shifted-out bit
    sbc	    hl, bc	; HL = HL - "d" - carry
    jr	    nc, loop	; jump if carry == 0
    inc	    e		; set low bit of DE
    jr	    loop2
#endlocal

#local
divmod16_z80heaven::
     ld a,16        ;7
     ld hl,0        ;10
     jp $+5         ;10
DivLoop:
       add hl,bc    ;--
       dec a        ;64
       ret z        ;86

       sla e        ;128
       rl d         ;128
       adc hl,hl    ;240
       sbc hl,bc    ;240
       jr nc,DivLoop ;23|21
       inc e        ;--
       jp DivLoop+1
#endlocal

; The following routine divides AC by DE and places the quotient in AC and the remainder in HL.
#local
div_ac_de::
    ld	    hl, 0
    ld	    b, 16

loop:
    sll	    c
    rla
    adc	    hl, hl
    sbc	    hl, de
    jr	    nc, $+4
    add	    hl, de
    dec	    c
    
    djnz    loop
    
    ret
#endlocal

; void kbd_init()
#local
kbd_init::
    push    hl
    push    bc
    xor	    a
    ld	    (Kbd_modifiers), a	; clear keyboard modifiers
    ld	    bc, 0x0400 | PORT_PIOACTL ; configure PIO port A
    ld	    hl, pioA_cfg
    otir
    call    pio_srclr		; clear shift register at startup
    pop	    bc
    pop	    hl
    ret
pioA_cfg:
    .byte PIOC_MODE | PIOMODE_CONTROL
    .byte 0xF7	    ; A3 is an output (~SRCLR), everything else is an input
    .byte PIOC_ICTL | PIOICTL_INTDIS | PIOICTL_OR | PIOICTL_HIGH | PIOICTL_MASKNXT
    .byte 0xDF	    ; interrupt on A5 only (SRSTRT)
#endlocal

; uint8_t kbd_get_byte()
; - read and return the next input byte from the PS/2 keyboard port
; - blocks until a byte is available
#local
kbd_get_byte::
poll:
    in	    a, (PORT_PIOADAT)	; read PIO port A
    and	    0x20		; if SRSTRT is low, keep polling
    jr	    z, poll
    in	    a, (PORT_KBD)	; read keyboard latch
    cpl				; invert signal (shift register is fed from ~KDAT)
    ld	    l, a
    ; clear shift register to prepare for next byte
; FALLING THROUGH!!!

; void pio_srclr()
; - clear shift register by toggling ~SRCLR line, leaving it HIGH
pio_srclr::
    xor	    a
    out	    (PORT_PIOADAT), a
    ld	    a, 0x08	; bit 3
    out	    (PORT_PIOADAT), a
    ret
#endlocal

; uint8_t kbd_get_keycode()
; - reads one or more bytes from the PS/2 keyboard port, parses them and returns a KEY_xxx code
;   indicating which key was pressed/released
; - blocks until a valid key event is received
#local
kbd_get_keycode::
    push    bc
    push    de
    push    hl
start:
    ld	    c, KBD_SCNST_IDL	; C = scan_state (initially idle, i.e. 0)
nextByte:
    call    kbd_get_byte	; L = next scan code byte
    ld	    a, l		; test for key-up byte
    cp	    0xF0		; test A == 0xF0?
    jr	    nz, notKeyUp
    set	    KBD_SCNST_RLSBIT, c	; scan_state |= KBD_SCANST_RLS
    jr	    nextByte
notKeyUp:			; input_byte in A&L was not 0xF0
    cp	    0xE0		; test A == 0xE0?
    jr	    nz, notExtCode
    set	    KBD_SCNST_EXTBIT, c	; scan_state |= KBD_SCANST_EXT
    jr	    nextByte
notExtCode:			; input_byte in A&L was not 0xE0, nor 0xF0
    bit	    KBD_SCNST_EXTBIT, c	; test (scan_state & KBD_SCANST_EXT) == 0?
    jr	    nz, parseExt	; parse next byte as extended scan code if flag set
    ; parse input_byte in A&L using Kbd_scan_tbl
    cp	    Kbd_scan_tbl_sz	; test input_byte < Kbd_scan_tbl_sz?
    jr	    nc, start		; input_byte out of range: ignore this byte sequence and start over
    ld	    h, 0		; HL = input_byte
    ld	    de, Kbd_scan_tbl
    add	    hl, de		; HL = &Kbd_scan_tbl[input_byte]
found:
    ld	    a, (hl)		; A = keycode = Kbd_scan_tbl[input_byte]
    or	    a			; test keycode == KEY_NONE?
    jr	    z, start		; KEY_NONE: ignore this byte sequence and start over
    cp	    KMOD_MAX+1		; test keycode <= KMOD_MAX?
    jr	    nc, notModifier	; keycode > KMOD_MAX, so it's not a modifier key
    ld	    d, a		; D = keycode
    ld	    b, a		; B = keycode
    ld	    a, 1		; set up for: A = 1 << keycode
shift:
    sla	    a			; A <<= 1
    djnz    shift		; repeat B times
    ld	    hl, Kbd_modifiers	; HL = &Kbd_modifiers
    bit	    KBD_SCNST_RLSBIT, c	; test (scan_state & KBD_SCANST_RLS) == 0?
    jr	    nz, clearModifier	; release bit is set, so clear modifier bit
    or	    (hl)		; A |= Kbd_modifiers
    jr	    modifierDone
clearModifier:
    cpl				; A = ~A
    and	    (hl)		; A &= Kbd_modifiers
modifierDone:
    ld	    (hl), a		; Kbd_modifiers = A
    ld	    a, d		; A = keycode
notModifier:
    bit	    KBD_SCNST_RLSBIT, c	; test (scan_state & KBD_SCANST_RLS) == 0?
    jr	    z, return		; bit clear, return keycode
    or	    KEY_RELEASED	; keycode |= KEY_RELEASED
return:				; return keycode
    pop	    hl
    pop	    de
    pop	    bc
    ld	    l, a
    ret

parseExt:			; input_byte in A&L is to be parsed via Kbd_ext_tbl
    ld	    b, Kbd_ext_tbl_sz	; loop Kbd_ext_tbl_sz iterations
    ld	    hl, Kbd_ext_tbl	; HL = Kbd_ext_tbl
extLoop:
    cp	    (hl)		; test *HL == input_byte
    inc	    hl			; does not affect flags
    jr	    z, found		; if equal, continue search
    inc	    hl
    djnz    extLoop
    jr	    start		; not found, discard byte sequence and start over


; The data structure for scan code mappings is as follows:
; We use a table of 132 bytes, each corresponding to the first (or next) byte of a scan code.
; Each value in the table is one of:
;   1. A KEY_xxx value representing a recognized key. Scan code processing stops and the
;      associated key-up or key-down event is returned to the upper layer.
;   2. KEY_NONE, meaning that no scan code can begin with this prefix, which simply resets the
;      scan code parser state, ignoring any input bytes processed so far.
; Any scan code byte >= 132 (i.e. outside the table) maps to KEY_NONE.
;
; For input byte $F0, a flag is stored indicating that the resulting scan code will be for a
; key-up event, and the KEY_RELEASED flag is ORed onto the resulting scan code byte when parsing
; is complete.
;
; For input byte $E0, a second flag is stored indicating that the extended scan code table must
; be searched. (See below.)
;
Kbd_scan_tbl:
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE    ;00-07
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_TAB, KEY_TICK, KEY_NONE	    ;08-0F
    .byte KEY_NONE, KEY_LALT, KEY_LSHFT, KEY_NONE, KEY_LCTRL, KEY_Q, KEY_1, KEY_NONE	    ;10-17
    .byte KEY_NONE, KEY_NONE, KEY_Z, KEY_S, KEY_A, KEY_W, KEY_2, KEY_NONE		    ;18-1F
    .byte KEY_NONE, KEY_C, KEY_X, KEY_D, KEY_E, KEY_4, KEY_3, KEY_NONE			    ;20-27
    .byte KEY_NONE, KEY_SPACE, KEY_V, KEY_F, KEY_T, KEY_R, KEY_5, KEY_NONE		    ;28-2F
    .byte KEY_NONE, KEY_N, KEY_B, KEY_H, KEY_G, KEY_Y, KEY_6, KEY_NONE			    ;30-37
    .byte KEY_NONE, KEY_NONE, KEY_M, KEY_J, KEY_U, KEY_7, KEY_8, KEY_NONE		    ;38-3F
    .byte KEY_NONE, KEY_COMMA, KEY_K, KEY_I, KEY_O, KEY_0, KEY_9, KEY_NONE		    ;40-47
    .byte KEY_NONE, KEY_DOT, KEY_SLASH, KEY_L, KEY_SEMI, KEY_P, KEY_DASH, KEY_NONE	    ;48-4F
    .byte KEY_NONE, KEY_NONE, KEY_APOST, KEY_NONE, KEY_LSQB, KEY_EQUAL, KEY_NONE, KEY_NONE  ;50-57
    .byte KEY_NONE, KEY_RSHFT, KEY_ENTER, KEY_RSQB, KEY_NONE, KEY_BKSL, KEY_NONE, KEY_NONE  ;58-5F
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_BS, KEY_NONE	    ;60-67
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE    ;68-6F
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_ESC, KEY_NONE	    ;70-77
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE    ;78-7F
    .byte KEY_NONE, KEY_NONE, KEY_NONE, KEY_NONE					    ;80-83
Kbd_scan_tbl_sz	    equ $-Kbd_scan_tbl

; The extended scan code table has the following format:
;     struct {
;	  uint8_t scan_byte
;         uint8_t key_code
;     } entries[Kbd_ext_tbl_sz]
;
; Entries in this table are sorted by scan_byte, so they can be searched by binary search if
; desired (but the number of entries is expected to be 5 initially, suggesting a linear search is
; fine). Any input bytes with no entry in the extended scan code table behave as if an entry
; mapping them to KEY_NONE had been found (i.e. terminate processing and discard input).
;
Kbd_ext_tbl:
    .byte 0x11, KEY_RALT
    .byte 0x14, KEY_RCTRL
    .byte 0x6B, KEY_LEFT
    .byte 0x71, KEY_DEL
    .byte 0x72, KEY_DOWN
    .byte 0x74, KEY_RIGHT
    .byte 0x75, KEY_UP
Kbd_ext_tbl_sz	    equ ($-Kbd_ext_tbl) / 2

; You may be wondering how exotic scan codes like Print Screen or Pause will be handled by the
; above tables.
;
; Print Screen ($E0,$12,$E0,$7C) will be treated as two key down events that both map to KEY_NONE
; in the extended scan code table, thus it will be ignored. Likewise, its associated key-up
; sequence will be treated as two key-up sequences that are both ignored.
;
; Pause ($E1,$14,$77,$E1,$F0,$14,$F0,$77) will be treated as a KEY_NONE ($E1) followed by
; Left Control down ($14), NumberLock down ($77), KEY_NONE ($E1), Left Control up ($F0,$14),
; and NumberLock up ($F0, $77). These will all be ignored.

#endlocal

; uint8_t kbd_getc()
; - reads the next ISO8859-1 input character from the keyboard (i.e. "cooked" mode)
; - filters out all key-release and modifier keycodes
; - applies SHIFT modifier to input key
; - ignores CTRL/ALT modifiers (for now)
#local
kbd_getc::
loop:
    call    kbd_get_keycode	; read the next keycode into L
    bit	    KEY_RELEASED_BIT, l	; test (keycode & KEY_RELEASED_BIT) == 0?
    jr	    nz, loop		; if bit is set, ignore the release keycode
    ld	    a, l		; A = keycode
    cp	    KMOD_MAX+1		; test keycode <= KMOD_MAX?
    jr	    c, loop		; ignore modifier keys
    ld	    a, (Kbd_modifiers)	; A = modifiers
    and	    KMOD_SHIFT_MSK	; test (A & KMOD_SHIFT_MSK) != 0
    ret     z

    ; Handle SHIFT modifier.
    ld	    a, l		; A = keycode
    sub	    KEY_SHIFT_MIN	; A = keycode - KEY_SHIFT_MIN
    ret	    c			; return key unmodified if keycode < KEY_SHIFT_MIN

    ; Map key through table
    push    hl
    push    bc
    ld	    c, a
    ld	    b, 0
    ld	    hl, Key_shift_tbl	; HL = &Key_shift_tbl
    add	    hl, bc		; HL = &Key_shift_tbl[keycode - KEY_SHIFT_MIN]
    ld	    a, (hl)
    pop	    bc
    pop	    hl
    ld	    l, a
    ret

; Entries in this table map a keycode to the ISO8859-1 character that should be generated when
; the shift key is held down. The table has 89 entries, for keycodes $27-$7F inclusive
KEY_SHIFT_MIN	    equ 0x27
Key_shift_tbl:
    .byte '"()*+<_>?' ; $27-2F
    .byte ")!@#$%^&*(::<+>?" ; $30-3F
    .byte "@ABCDEFGHIJKLMNO" ; $40-4F
    .byte "PQRSTUVWXYZ{|}^_" ; $50-5F
    .byte "~ABCDEFGHIJKLMNO" ; $60-6F
    .byte "PQRSTUVWXYZ{|}~", $7F ; $70-7F
#endlocal

; uint8_t bin2hex(uint8_t val)
; - converts the lower 4 bits of the 8-bit value "val" to hexadecimal (0-9,A-F)
#local
bin2hex::
    ld	    a, l
    and	    0xF
    cp	    0xA
    jr	    c, decimal
    add	    'A'-10
    ld	    l, a
    ret
decimal:
    add	    '0'
    ld	    l, a
    ret
#endlocal

; uint8_t hex2bin(uint8_t val)
; - converts the hexadecimal character (0-9,A-F,a-f) to a 4-bit value.
; - assumes that the character is a valid hex digit, upper or lower case.
#local
hex2bin::
    ld	    a, l
    sub     a, '0'
    cp      10
    jr      c, done         ; If we borrowed, then it's less than 10 and we're done.

    ; Adjust for A-F.
    sub     a, 'A'-'0'-10

    ; Handle lower case (has 0x20 OR'ed in).
    and     0x0F

done:
    ld	    l, a
    ret
#endlocal

; void sio_putc(uint8_t ch)
; - write the specified character "ch" to port A
#local
sio_putc::
waitTX:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_TBE, a
    jr	    z, waitTX
    ; write output character
    ld	    a, l
    out	    (PORT_SIOADAT), a	; send byte out serial port
    ret
#endlocal

; void sio_puts(uint8_t *text)
; - write the NUL-terminated string at "text" to port A
#local
sio_puts::
    push    hl
    push    bc
nextByte:
    ld	    a, (hl)
    inc	    hl
    or	    a		; fast test a==0
    jr	    z, done
    ld	    b, a
waitTX:
    ; wait until transmitter is idle
    in	    a, (PORT_SIOACTL)
    bit	    SIORR0_IDX_TBE, a
    jr	    z, waitTX
    ; write output character
    ld	    a, b
    out	    (PORT_SIOADAT), a	; send byte out serial port
    jr	    nextByte
done:
    pop	    bc
    pop	    hl
    ret
#endlocal

; void sio_puthex8(uint8_t val)
; - writes the specified 8-bit value "val" as a pair of hex digits to port A
sio_puthex8::
    push    hl
    ld	    h, l
    srl	    l
    srl	    l
    srl	    l
    srl	    l
    call    bin2hex
    call    sio_putc
    ld	    l, h
    call    bin2hex
    call    sio_putc
    pop	    hl
    ret

; void sio_puthex16(uint16_t val)
; - writes the specified 16-bit value "val" as a quad of hex digits to port A
sio_puthex16::
    push    hl
    ld	    l, h
    call    sio_puthex8
    pop	    hl
    jr	    sio_puthex8

; void seg_init()
seg_init::
    xor	    a
    call    seg0_write
    call    seg1_write
    ret

; void seg_writehex(uint8_t val)
; - write the two hex digits of "val" to the 7-segment displays
seg_writehex::
    push    hl
    call    seg1_writehex
    ld	    a, l
    rlca
    rlca
    rlca
    rlca
    ld	    l, a
    call    seg0_writehex
    pop	    hl
    ret

#local
; void seg0_writehex(uint8_t val)
; - write hex digit in lower nybble of "val" to 7-segment display
seg0_writehex::
    push    hl
    push    bc
    ld	    bc, hex2seg_table
    ld	    a, l
    and	    0xF	    ; mask off upper nybble of l
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = hex2seg_table + (val & 0xF)
    ld	    a, (Seg0_data)
    and	    SEG_DP
    or	    (hl)    ; a = (*Seg0_data & SEG_DP) | hex2seg_table[val & 0xF]
    call    seg0_write
    pop	    bc
    pop	    hl
    ret

; void seg1_writehex(uint8_t val)
; - write hex digit in lower nybble of "val" to 7-segment display
seg1_writehex::
    push    hl
    push    bc
    ld	    bc, hex2seg_table
    ld	    a, l
    and	    0xF	    ; mask off upper nybble of l
    ld	    l, a
    ld	    h, 0
    add	    hl, bc  ; hl = hex2seg_table + (val & 0xF)
    ld	    a, (Seg1_data)
    and	    SEG_DP
    or	    (hl)    ; a = (*Seg1_data & SEG_DP) | hex2seg_table[val & 0xF]
    call    seg1_write
    pop	    bc
    pop	    hl
    ret

hex2seg_table:
    ; 0
    .byte SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F
    ; 1
    .byte SEG_B | SEG_C
    ; 2
    .byte SEG_A | SEG_B | SEG_G | SEG_E | SEG_D
    ; 3
    .byte SEG_A | SEG_B | SEG_G | SEG_C | SEG_D
    ; 4
    .byte SEG_F | SEG_G | SEG_B | SEG_C
    ; 5
    .byte SEG_A | SEG_F | SEG_G | SEG_C | SEG_D
    ; 6
    .byte SEG_A | SEG_F | SEG_G | SEG_C | SEG_D | SEG_E
    ; 7
    .byte SEG_A | SEG_B | SEG_C
    ; 8
    .byte SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G
    ; 9
    .byte SEG_A | SEG_B | SEG_C | SEG_D | SEG_F | SEG_G
    ; A
    .byte SEG_A | SEG_B | SEG_C | SEG_E | SEG_F | SEG_G
    ; b
    .byte SEG_F | SEG_G | SEG_C | SEG_D | SEG_E
    ; C
    .byte SEG_A | SEG_D | SEG_E | SEG_F
    ; d
    .byte SEG_B | SEG_C | SEG_D | SEG_E | SEG_G
    ; E
    .byte SEG_A | SEG_D | SEG_E | SEG_F | SEG_G
    ; F
    .byte SEG_A | SEG_E | SEG_F | SEG_G
#endlocal

; void seg0_write(uint8_t bits)
; - parameter passed in A
; - write raw bits to first 7-segment display register
seg0_write::
    ld	    (Seg0_data), a
    out	    (PORT_SEG0), a
    ret

; void seg1_write(uint8_t bits)
; - parameter passed in A
; - write raw bits to second 7-segment display register
seg1_write::
    ld	    (Seg1_data), a
    out	    (PORT_SEG1), a
    ret

; void delay_ms(uint8_t ms)
; - delay for at least the specified number of milliseconds
#local
delay_ms::
    inc	    l
    dec	    l
    ret	    z		; delay of 0 returns immediately
    push    bc
    ld	    b, l
loop:
    call    delay_1ms
    djnz    loop
    pop	    bc
    ret
#endlocal

; void delay_1ms()
; - delay for 1ms (technically, 0.9999ms)
#local
delay_1ms::
    push    bc		; 11 T-states
; To delay 1ms, we want to wait 10,000 T-states (@10MHz)
; The loop is (38*b + 13*(b-1) + 8) T-states long
; Rearranging: 51*b - 5
; Solve for b: b = (10000 + 5 / 51) = 196.17
    ld	    b, 195	; 7 T-states
loop:
    ld	    a, (ix+1)	; 19 T-states
    ld	    a, (ix+1)	; 19 T-states
    djnz    loop	; (b-1)*13+8 T-states
    pop	    bc		; 10 T-states
    nop			; 4 T-states
    ret			; 10 T-states
; We also assume the routine is CALLed, for 17 T-states.
; Total delay is therefore:
;   17 + 11 + 7 + 51*195 - 5 + 10 + 4 + 10 = 9,999
#endlocal

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here
Seg0_data:: defs 1	; current value of first 7-segment display byte
Seg1_data:: defs 1	; current value of second 7-segment display byte

Rand16_seed1:: defs 2	; seed value for rand16() routine
Rand16_seed2:: defs 2	; seed value for rand16() routine

Kbd_modifiers:: defs 1	; active modifier keys (1=pressed, 0=released), see KMOD_xxx_BIT

Gets_buffer:: defs 100  ; input buffer for lcd_gets() routine
Gets_buffer_sz	equ $-Gets_buffer

Forth_orig_sp:: defs 2  ; Save the calling program's SP.
Forth_dict:: defs 2     ; Pointer to dictionary linked list.
Forth_here:: defs 2     ; Pointer to next available space in Forth_code.
Forth_psp:: defs 2      ; Pointer into Forth_pstack.
Forth_input:: defs 2    ; Pointer to input buffer.
Forth_compiling:: defs 1 ; Whether compiling (vs. immediate mode). (Normally called STATE.)
Forth_code:: defs FORTH_CODE_SIZE
Forth_rstack:: defs FORTH_RSTACK_SIZE
Forth_pstack:: defs FORTH_PSTACK_SIZE
