; void lcd_init()
; - set up the LCD panel by programming the RA8876 registers
#local
lcd_init::
    push    de
    push    hl
    ;in	    a, (PORT_LCDCMD)	    ; read status byte
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
    call    delay_1ms
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
    ; The default is start address 0, so we don't need to do this.
    ;M_lcdwrite0 LCDREG_MISA0
    ;M_lcdwrite0 LCDREG_MISA1
    ;M_lcdwrite0 LCDREG_MISA2
    ;M_lcdwrite0 LCDREG_MISA3
    ;	Main_Image_Width(1024);							
    M_lcdwrite LCDREG_MIW0, lo(LCD_WIDTH)
    M_lcdwrite LCDREG_MIW1, hi(LCD_WIDTH)
    ;	Main_Window_Start_XY(0,0);	
    ; The default is (0,0).
    M_lcdwrite0 LCDREG_MWULX0
    M_lcdwrite0 LCDREG_MWULX1
    M_lcdwrite0 LCDREG_MWULY0
    M_lcdwrite0 LCDREG_MWULY1
    ;	Canvas_Image_Start_address(0);
    ; The default is start address 0, so we don't need to do this.
    ;M_lcdwrite0 LCDREG_CVSSA0
    ;M_lcdwrite0 LCDREG_CVSSA1
    ;M_lcdwrite0 LCDREG_CVSSA2
    ;M_lcdwrite0 LCDREG_CVSSA3
    ;	Canvas_image_width(1024);
    M_lcdwrite LCDREG_CVS_IMWTH0, lo(LCD_WIDTH)
    M_lcdwrite LCDREG_CVS_IMWTH1, hi(LCD_WIDTH)
    ;	Active_Window_XY(0,0);
    ; The default is (0,0), so we don't really need to do this.
    M_lcdwrite0 LCDREG_AWUL_X0
    M_lcdwrite0 LCDREG_AWUL_X1
    M_lcdwrite0 LCDREG_AWUL_Y0
    M_lcdwrite0 LCDREG_AWUL_Y1
    ;	Active_Window_WH(1024,600);
    M_lcdwrite LCDREG_AW_WTH0, lo(LCD_WIDTH)
    M_lcdwrite LCDREG_AW_WTH1, hi(LCD_WIDTH)
    M_lcdwrite LCDREG_AW_HT0, lo(LCD_HEIGHT)
    M_lcdwrite LCDREG_AW_HT1, hi(LCD_HEIGHT)
    ; Set BTE Source 0 memory start address (default is 0)
    ;M_lcdwrite0 LCDREG_S0_STR0
    ;M_lcdwrite0 LCDREG_S0_STR1
    ;M_lcdwrite0 LCDREG_S0_STR2
    ;M_lcdwrite0 LCDREG_S0_STR3
    ; Set BTE Source 0 image width
    M_lcdwrite LCDREG_S0_WTH0, lo(LCD_WIDTH)
    M_lcdwrite LCDREG_S0_WTH1, hi(LCD_WIDTH)
    ; Set BTE Source 1 memory start address (default is 0)
    ;M_lcdwrite0 LCDREG_S1_STR0
    ;M_lcdwrite0 LCDREG_S1_STR1
    ;M_lcdwrite0 LCDREG_S1_STR2
    ;M_lcdwrite0 LCDREG_S1_STR3
    ; Set BTE Source 1 image width
    M_lcdwrite LCDREG_S1_WTH0, lo(LCD_WIDTH)
    M_lcdwrite LCDREG_S1_WTH1, hi(LCD_WIDTH)
    ; Set BTE Destination memory start address (default is 0)
    ;M_lcdwrite0 LCDREG_DT_STR0
    ;M_lcdwrite0 LCDREG_DT_STR1
    ;M_lcdwrite0 LCDREG_DT_STR2
    ;M_lcdwrite0 LCDREG_DT_STR3
    ; Set BTE Destination image width
    M_lcdwrite LCDREG_DT_WTH0, lo(LCD_WIDTH)
    M_lcdwrite LCDREG_DT_WTH1, hi(LCD_WIDTH)
    ; Set BTE Color depth to 16bpp
    M_lcdwrite LCDREG_BTE_COLR, 0x25	; S0, S1, and DT color depth 16bpp
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
    call    lcd_clear		    ; clear screen
    call    lcd_bl_on		    ; turn on backlight
    pop	    hl
    pop	    de
    ret
#endlocal
