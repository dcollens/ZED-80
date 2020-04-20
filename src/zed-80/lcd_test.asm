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
#include "sysreg.inc"
#include "lcd.inc"
#include "7segdisp.inc"
#include "joystick.inc"
#include "z84c20.inc"
#include "z84c30.inc"
#include "z84c40.inc"
#include "ascii.inc"

DCR0_DRAWLINE	equ LCDDCR0_DRWLIN | LCDDCR0_RUN
DCR0_DRAWTRI	equ LCDDCR0_DRWTRI | LCDDCR0_RUN
DCR0_FILLTRI	equ LCDDCR0_DRWTRI | LCDDCR0_FILL | LCDDCR0_RUN

DCR1_DRAWRECT	equ LCDDCR1_DRWRCT | LCDDCR1_RUN
DCR1_FILLRECT	equ LCDDCR1_DRWRCT | LCDDCR1_FILL | LCDDCR1_RUN
DCR1_DRAWELL	equ LCDDCR1_DRWELL | LCDDCR1_RUN
DCR1_FILLELL	equ LCDDCR1_DRWELL | LCDDCR1_FILL | LCDDCR1_RUN
DCR1_DRAWRR	equ LCDDCR1_DRWRR | LCDDCR1_RUN
DCR1_FILLRR	equ LCDDCR1_DRWRR | LCDDCR1_FILL | LCDDCR1_RUN

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; our code will load immediately above the ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#code TEXT,0x4000

; Careful, don't put anything before "init", as this is the entry point to our code.
#local
init::
    ; zero the DATA segment
    ld	    hl, DATA
    ld	    bc, DATA_size
    call    bzero

    ; Set Sysreg to the value that we know the ROM monitor set it to.
    ld	    a, SYS_MMUEN | SYS_SDCS | SYS_SDICLR
    call    sysreg_write

    call    seg_init		    ; clear 7-segment display
    call    rand_init		    ; seed RNG
    call    lcd_init		    ; initialize LCD subsystem
    call    lcd_text_init	    ; initialize the text console
    ld	    de, hello_message	    ; print welcome banner
    call    lcd_puts
    ld	    de, copyright_message
    call    lcd_puts
    ld	    b, 250		    ; delay 1s
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    lcd_test_drawing	    ; drawing test
    ret

hello_message:
    .text   "ZED-80 Personal Computer", CR, LF, NUL
copyright_message:
    .text   0xA9, "1976 HeadCode", CR, LF, NUL
#endlocal

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

; void lcd_rand_line_coords()
; - set up random coordinates for line start & line end
#local
lcd_rand_line_coords::
    push    de
    push    hl
do_line_coords:
    ld	    hl, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    hl, LCD_HEIGHT
    call    rand16_modn
    call    lcd_line_start_xy	    ; random start X,Y
    ld	    hl, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    hl, LCD_HEIGHT
    call    rand16_modn
    call    lcd_line_end_xy	    ; random end X,Y
    pop	    hl
    pop	    de
    ret

; void lcd_rand_triangle_coords()
; - set up random coordinates for the three triangle vertices
lcd_rand_triangle_coords::
    push    de
    push    hl
    ld	    hl, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    hl, LCD_HEIGHT
    call    rand16_modn
    call    lcd_triangle_xy	    ; random triangle 3rd vertex X,Y
    jr	    do_line_coords	    ; random triangle 1st & 2nd vertices
#endlocal

; void lcd_rand_ellipse_coords()
; - set up random coordinates and size for ellipse/circle
lcd_rand_ellipse_coords::
    push    de
    push    hl
    ld	    hl, LCD_WIDTH
    call    rand16_modn
    ex	    de, hl
    ld	    hl, LCD_HEIGHT
    call    rand16_modn
    call    lcd_ellipse_xy	    ; random center X,Y
    ld	    hl, LCD_WIDTH/2
    call    rand16_modn
    ex	    de, hl
    ld	    hl, LCD_HEIGHT/2
    call    rand16_modn
    call    lcd_ellipse_radii	    ; random radii
    pop	    hl
    pop	    de
    ret

#include library "libcode"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data segment immediately follows code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#data DATA,TEXT_end
; define static variables here

#include library "libdata"
