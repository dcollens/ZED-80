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
#include "ascii.inc"

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
    ; run the test program
    call    lcd_test
    ret

; void lcd_test()
; - exercise the LCD panel
#local
lcd_test::
    push    hl
    call    lcd_init
    ld	    l, 250
loop:
    call    lcd_bl_on
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    lcd_bl_off
    call    delay_ms
    call    delay_ms
    call    delay_ms
    call    delay_ms
    jr	    loop
    pop	    hl
    ret
#endlocal

; void lcd_init()
; - set up the LCD panel by programming the RA8876 registers
#local
lcd_init::
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
    M_out   (PORT_LCDDAT), 0x00
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
    and	    0x04
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
    M_lcdwrite LCDREG_MACR, 0x00
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
    M_lcdwrite LCDREG_HDWFTR, 0
    M_lcdwrite LCDREG_VDHR0, 0x57
    M_lcdwrite LCDREG_VDHR1, 0x02
    ;	LCD_Horizontal_Non_Display(160);		   //30
    M_lcdwrite LCDREG_HNDR, 19
    M_lcdwrite LCDREG_HNDFTR, 0
    ;	LCD_HSYNC_Start_Position(160);
    M_lcdwrite LCDREG_HSTR, 19
    ;	LCD_HSYNC_Pulse_Width(70);
    M_lcdwrite LCDREG_HPWR, 7
    ;	LCD_Vertical_Non_Display(23);		   //16
    M_lcdwrite LCDREG_VNDR0, 22
    M_lcdwrite LCDREG_VNDR1, 0
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
    M_lcdwrite LCDREG_MISA0, 0
    M_lcdwrite LCDREG_MISA1, 0
    M_lcdwrite LCDREG_MISA2, 0
    M_lcdwrite LCDREG_MISA3, 0
    ;	Main_Image_Width(1024);							
    M_lcdwrite LCDREG_MIW0, 0
    M_lcdwrite LCDREG_MIW1, 4
    ;	Main_Window_Start_XY(0,0);	
    ; The default is (0,0), so we don't really need to do this.
    M_lcdwrite LCDREG_MWULX0, 0
    M_lcdwrite LCDREG_MWULX1, 0
    M_lcdwrite LCDREG_MWULY0, 0
    M_lcdwrite LCDREG_MWULY1, 0
    ;	Canvas_Image_Start_address(0);
    ; The default is start address 0, so we don't really need to do this.
    M_lcdwrite LCDREG_CVSSA0, 0
    M_lcdwrite LCDREG_CVSSA1, 0
    M_lcdwrite LCDREG_CVSSA2, 0
    M_lcdwrite LCDREG_CVSSA3, 0
    ;	Canvas_image_width(1024);
    M_lcdwrite LCDREG_CVS_IMWTH0, 0
    M_lcdwrite LCDREG_CVS_IMWTH1, 4
    ;	Active_Window_XY(0,0);
    ; The default is (0,0), so we don't really need to do this.
    M_lcdwrite LCDREG_AWUL_X0, 0
    M_lcdwrite LCDREG_AWUL_X1, 0
    M_lcdwrite LCDREG_AWUL_Y0, 0
    M_lcdwrite LCDREG_AWUL_Y1, 0
    ;	Active_Window_WH(1024,600);
    M_lcdwrite LCDREG_AW_WTH0, 0
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
    pop	    hl
    ret
#endlocal

; void lcd_bl_on()
; - turn on LCD backlight
lcd_bl_on::
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS | SIOWR5_DTR
    out	    (PORT_SIOACTL), a
    ret

; void lcd_bl_off()
; - turn off LCD backlight
lcd_bl_off::
    ld	    a, SIOWR0_CMD_NOP | SIOWR0_PTR_R5
    out	    (PORT_SIOACTL), a
    ld	    a, SIOWR5_RTS | SIOWR5_TXENA | SIOWR5_TX_8_BITS
    out	    (PORT_SIOACTL), a
    ret

; void lcd_set_fgcolor(uint8_t r, uint8_t g, uint8_t b)
; - R,G,B uses upper 5,6,5 bits of precision only (i.e. 16bpp color)
lcd_set_fgcolor::
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
