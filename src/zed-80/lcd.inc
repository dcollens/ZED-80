PORT_LCDBASE	equ 0x50		; base port address for RA8876 chip
PORT_LCDCMD	equ PORT_LCDBASE	; port address for RA8876 command/status register
PORT_LCDDAT	equ PORT_LCDBASE + 1	; port address for RA8876 data register

; Panel geometry
LCD_WIDTH	equ 1024
LCD_HEIGHT	equ 600
; If these change, adjust the shifts in lcd_putc.s:
LCD_TXT_WIDTH	equ 8
LCD_TXT_HEIGHT	equ 16

; Status register values
LCDSTAT_INTR	equ 0x01		; Interrupt pin state (active high)
LCDSTAT_MODE	equ 0x02		; Operation mode status (normal=low)
LCDSTAT_RAMRDY	equ 0x04		; SDRAM ready for access (active high)
LCDSTAT_BUSY	equ 0x08		; Core task is busy (active high)
LCDSTAT_RDEMPTY	equ 0x10		; Host Memory Read FIFO empty (active high)
LCDSTAT_RDFULL	equ 0x20		; Host Memory Read FIFO full (active high)
LCDSTAT_WREMPTY	equ 0x40		; Host Memory Write FIFO empty (active high)
LCDSTAT_WRFULL	equ 0x80		; Host Memory Write FIFO full (active high)

; DCR0 (register $67) register values
LCDDCR0_DRWLIN	equ 0x00		; Draw line
LCDDCR0_DRWTRI	equ 0x02		; Draw triangle
LCDDCR0_FILL	equ 0x20		; Fill (0 = outline, 1 = fill)
LCDDCR0_RUN	equ 0x80		; Start drawing / drawing in progress

; DCR1 (register $76) register values
LCDDCR1_QUADBL	equ 0x00		; Ellipse curve, bottom-left quadrant
LCDDCR1_QUADTL	equ 0x01		; Ellipse curve, top-left quadrant
LCDDCR1_QUADTR	equ 0x02		; Ellipse curve, top-right quadrant
LCDDCR1_QUADBR	equ 0x03		; Ellipse curve, bottom-right quadrant
LCDDCR1_DRWELL	equ 0x00		; Draw circle/ellipse
LCDDCR1_DRWCUR	equ 0x10		; Draw circle/ellipse curve (one quadrant)
LCDDCR1_DRWRCT	equ 0x20		; Draw rectangle
LCDDCR1_DRWRR	equ 0x30		; Draw round-rectangle
LCDDCR1_FILL	equ 0x40		; Fill (0 = outline, 1 = fill)
LCDDCR1_RUN	equ 0x80		; Start drawing / drawing in progress

; Register numbers within the RA8876 chip
LCDREG_SRR	equ 0x00		; Software Reset Register
LCDREG_CCR	equ 0x01		; Chip Configuration Register
LCDREG_MACR	equ 0x02		; Memory Access Control Register
LCDREG_ICR	equ 0x03		; Input Control Register
LCDREG_MRWDP	equ 0x04		; Memory Data Read/Write Port
LCDREG_PPLLC1	equ 0x05		; SCLK PLL Control Register 1
LCDREG_PPLLC2	equ 0x06		; SCLK PLL Control Register 2
LCDREG_MPLLC1	equ 0x07		; MCLK PLL Control Register 1
LCDREG_MPLLC2	equ 0x08		; MCLK PLL Control Register 2
LCDREG_SPLLC1	equ 0x09		; CCLK PLL Control Register 1
LCDREG_SPLLC2	equ 0x0A		; CCLK PLL Control Register 2
LCDREG_INTEN	equ 0x0B		; Interrupt Enable Register
LCDREG_INTF	equ 0x0C		; Interrupt Event Flag Register
LCDREG_MINTFR	equ 0x0D		; Mask Interrupt Flag Register
LCDREG_PUENR	equ 0x0E		; Pull-up Enable Register
LCDREG_PSFSR	equ 0x0F		; PDAT for PIO/Key Function Select Register
LCDREG_MPWCTR	equ 0x10		; Main/PIP Window Control Register
LCDREG_PIPCDEP	equ 0x11		; PIP Window Color Depth Setting
LCDREG_DPCR	equ 0x12		; Display Configuration Register
LCDREG_PCSR	equ 0x13		; Panel scan Clock & Data Setting Register
LCDREG_HDWR	equ 0x14		; Horizontal Display Width Register
LCDREG_HDWFTR	equ 0x15		; Horizontal Display Width Fine Tune Register
LCDREG_HNDR	equ 0x16		; Horizontal Non-Display Period Register
LCDREG_HNDFTR	equ 0x17		; Horizontal Non-Display Period Fine Tune Register
LCDREG_HSTR	equ 0x18		; HSYNC Start Position Register
LCDREG_HPWR	equ 0x19		; HSYNC Pulse Width Register
LCDREG_VDHR0	equ 0x1A		; Vertical Display Height Register 0
LCDREG_VDHR1	equ 0x1B		; Vertical Display Height Register 1
LCDREG_VNDR0	equ 0x1C		; Vertical Non-Display Period Register 0
LCDREG_VNDR1	equ 0x1D		; Vertical Non-Display Period Register 1
LCDREG_VSTR	equ 0x1E		; VSYNC Start Position Register
LCDREG_VPWR	equ 0x1F		; VSYNC Pulse Width Register
LCDREG_MISA0	equ 0x20		; Main Image Start Address 0
LCDREG_MISA1	equ 0x21		; Main Image Start Address 1
LCDREG_MISA2	equ 0x22		; Main Image Start Address 2
LCDREG_MISA3	equ 0x23		; Main Image Start Address 3
LCDREG_MIW0	equ 0x24		; Main Image Width 0
LCDREG_MIW1	equ 0x25		; Main Image Width 1
LCDREG_MWULX0	equ 0x26		; Main Window Upper-Left corner X-coordinates 0
LCDREG_MWULX1	equ 0x27		; Main Window Upper-Left corner X-coordinates 1
LCDREG_MWULY0	equ 0x28		; Main Window Upper-Left corner Y-coordinates 0
LCDREG_MWULY1	equ 0x29		; Main Window Upper-Left corner Y-coordinates 1

LCDREG_GTCCR	equ 0x3C		; Graphic/Text Cursor Control Register
LCDREG_BTCR	equ 0x3D		; Blink Time Control Register
LCDREG_CURHS	equ 0x3E		; Text Cursor Horizontal Size Register
LCDREG_CURVS	equ 0x3F		; Text Cursor Vertical Size Register

LCDREG_CVSSA0	equ 0x50		; Canvas Start Address 0
LCDREG_CVSSA1	equ 0x51		; Canvas Start Address 1
LCDREG_CVSSA2	equ 0x52		; Canvas Start Address 2
LCDREG_CVSSA3	equ 0x53		; Canvas Start Address 3
LCDREG_CVS_IMWTH0 equ 0x54		; Canvas Image Width 0
LCDREG_CVS_IMWTH1 equ 0x55		; Canvas Image Width 1
LCDREG_AWUL_X0	equ 0x56		; Active Window Upper-Left corner X-coordinates 0
LCDREG_AWUL_X1	equ 0x57		; Active Window Upper-Left corner X-coordinates 1
LCDREG_AWUL_Y0	equ 0x58		; Active Window Upper-Left corner Y-coordinates 0
LCDREG_AWUL_Y1	equ 0x59		; Active Window Upper-Left corner Y-coordinates 1
LCDREG_AW_WTH0	equ 0x5A		; Active Window Width 0
LCDREG_AW_WTH1	equ 0x5B		; Active Window Width 1
LCDREG_AW_HT0	equ 0x5C		; Active Window Height 0
LCDREG_AW_HT1	equ 0x5D		; Active Window Height 1
LCDREG_AW_COLOR equ 0x5E		; Color Depth of Canvas & Active Window

LCDREG_F_CURX0	equ 0x63		; Text Write X-coordinates Register 0
LCDREG_F_CURX1	equ 0x64		; Text Write X-coordinates Register 1
LCDREG_F_CURY0	equ 0x65		; Text Write Y-coordinates Register 0
LCDREG_F_CURY1	equ 0x66		; Text Write Y-coordinates Register 1
LCDREG_DCR0	equ 0x67		; Draw Line/Triangle Control Register 0
LCDREG_DLHSR0	equ 0x68		; Draw Line/Square/Triangle Point 1 X-coordinates 0
LCDREG_DLHSR1	equ 0x69		; Draw Line/Square/Triangle Point 1 X-coordinates 1
LCDREG_DLVSR0	equ 0x6A		; Draw Line/Square/Triangle Point 1 Y-coordinates 0
LCDREG_DLVSR1	equ 0x6B		; Draw Line/Square/Triangle Point 1 Y-coordinates 1
LCDREG_DLHER0	equ 0x6C		; Draw Line/Square/Triangle Point 2 X-coordinates 0
LCDREG_DLHER1	equ 0x6D		; Draw Line/Square/Triangle Point 2 X-coordinates 1
LCDREG_DLVER0	equ 0x6E		; Draw Line/Square/Triangle Point 2 Y-coordinates 0
LCDREG_DLVER1	equ 0x6F		; Draw Line/Square/Triangle Point 2 Y-coordinates 1
LCDREG_DTPH0	equ 0x70		; Draw Triangle Point 3 X-coordinates 0
LCDREG_DTPH1	equ 0x71		; Draw Triangle Point 3 X-coordinates 1
LCDREG_DTPV0	equ 0x72		; Draw Triangle Point 3 Y-coordinates 0
LCDREG_DTPV1	equ 0x73		; Draw Triangle Point 3 Y-coordinates 1
; Registers 0x74-0x75 reserved
LCDREG_DCR1	equ 0x76		; Draw Circle/Ellipse/Ellipse Curve/Circle Square Ctl Reg
LCDREG_ELL_A0	equ 0x77		; Draw Circle/Ellipse/Circle Square Major radius Setting Reg
LCDREG_ELL_A1	equ 0x78		; Draw Circle/Ellipse/Circle Square Major radius Setting Reg
LCDREG_ELL_B0	equ 0x79		; Draw Circle/Ellipse/Circle Square Minor radius Setting Reg
LCDREG_ELL_B1	equ 0x7A		; Draw Circle/Ellipse/Circle Square Minor radius Setting Reg
LCDREG_DEHR0	equ 0x7B		; Draw Circle/Ellipse/Circle Square Center X-coords 0
LCDREG_DEHR1	equ 0x7C		; Draw Circle/Ellipse/Circle Square Center X-coords 1
LCDREG_DEVR0	equ 0x7D		; Draw Circle/Ellipse/Circle Square Center Y-coords 0
LCDREG_DEVR1	equ 0x7E		; Draw Circle/Ellipse/Circle Square Center Y-coords 1

LCDREG_BTE_CTRL0 equ 0x90		; BTE Function Control Register 0
LCDREG_BTE_CTRL1 equ 0x91		; BTE Function Control Register 1
LCDREG_BTE_COLR equ 0x92		; Source 0/1 & Destination Color Depth
LCDREG_S0_STR0	equ 0x93		; Source 0 memory start address 0
LCDREG_S0_STR1	equ 0x94		; Source 0 memory start address 1
LCDREG_S0_STR2	equ 0x95		; Source 0 memory start address 2
LCDREG_S0_STR3	equ 0x96		; Source 0 memory start address 3
LCDREG_S0_WTH0	equ 0x97		; Source 0 image width 0
LCDREG_S0_WTH1	equ 0x98		; Source 0 image width 1
LCDREG_S0_X0	equ 0x99		; Source 0 Window Upper-Left corner X-coordinates 0
LCDREG_S0_X1	equ 0x9A		; Source 0 Window Upper-Left corner X-coordinates 1
LCDREG_S0_Y0	equ 0x9B		; Source 0 Window Upper-Left corner Y-coordinates 0
LCDREG_S0_Y1	equ 0x9C		; Source 0 Window Upper-Left corner Y-coordinates 1
LCDREG_S1_STR0	equ 0x9D		; Source 1 memory start address 0
LCDREG_S1_STR1	equ 0x9E		; Source 1 memory start address 1
LCDREG_S1_STR2	equ 0x9F		; Source 1 memory start address 2
LCDREG_S1_STR3	equ 0xA0		; Source 1 memory start address 3
LCDREG_S1_WTH0	equ 0xA1		; Source 1 image width 0
LCDREG_S1_WTH1	equ 0xA2		; Source 1 image width 1
LCDREG_S1_X0	equ 0xA3		; Source 1 Window Upper-Left corner X-coordinates 0
LCDREG_S1_X1	equ 0xA4		; Source 1 Window Upper-Left corner X-coordinates 1
LCDREG_S1_Y0	equ 0xA5		; Source 1 Window Upper-Left corner Y-coordinates 0
LCDREG_S1_Y1	equ 0xA6		; Source 1 Window Upper-Left corner Y-coordinates 1
LCDREG_DT_STR0	equ 0xA7		; Destination memory start address 0
LCDREG_DT_STR1	equ 0xA8		; Destination memory start address 1
LCDREG_DT_STR2	equ 0xA9		; Destination memory start address 2
LCDREG_DT_STR3	equ 0xAA		; Destination memory start address 3
LCDREG_DT_WTH0	equ 0xAB		; Destination image width 0
LCDREG_DT_WTH1	equ 0xAC		; Destination image width 1
LCDREG_DT_X0	equ 0xAD		; Destination Window Upper-Left corner X-coordinates 0
LCDREG_DT_X1	equ 0xAE		; Destination Window Upper-Left corner X-coordinates 1
LCDREG_DT_Y0	equ 0xAF		; Destination Window Upper-Left corner Y-coordinates 0
LCDREG_DT_Y1	equ 0xB0		; Destination Window Upper-Left corner Y-coordinates 1
LCDREG_BTE_WTH0	equ 0xB1		; BTE Window Width 0
LCDREG_BTE_WTH1	equ 0xB2		; BTE Window Width 1
LCDREG_BTE_HIG0	equ 0xB3		; BTE Window Height 0
LCDREG_BTE_HIG1	equ 0xB4		; BTE Window Height 1
LCDREG_APB_CTRL equ 0xB5		; Alpha Blending

LCDREG_CCR0	equ 0xCC		; Character Control Register 0
LCDREG_CCR1	equ 0xCD		; Character Control Register 1

LCDREG_FLDR	equ 0xD0		; Character Line Gap Setting Register
LCDREG_F2FSSR	equ 0xD1		; Character to Character Space Setting Register
LCDREG_FGCR	equ 0xD2		; Foreground Color Register - Red
LCDREG_FGCG	equ 0xD3		; Foreground Color Register - Green
LCDREG_FGCB	equ 0xD4		; Foreground Color Register - Blue
LCDREG_BGCR	equ 0xD5		; Background Color Register - Red
LCDREG_BGCG	equ 0xD6		; Background Color Register - Green
LCDREG_BGCB	equ 0xD7		; Background Color Register - Blue

LCDREG_SDRAR	equ 0xE0		; SDRAM Attribute Register
LCDREG_SDRMD	equ 0xE1		; SDRAM mode register & extended mode register
LCDREG_SDR_REF_ITVL0 equ 0xE2		; SDRAM auto refresh interval
LCDREG_SDR_REF_ITVL1 equ 0xE3		; SDRAM auto refresh interval
LCDREG_SDRCR	equ 0xE4		; SDRAM Control Register

; Write "val" to LCD register "regnum"
M_lcdwrite	macro regnum, val
    ; destroys A
    M_out   (PORT_LCDCMD), &regnum
    M_out   (PORT_LCDDAT), &val
    endm

; Write 0 to LCD register "regnum"
M_lcdwrite0	macro regnum
    ; destroys A
    M_out   (PORT_LCDCMD), &regnum
    M_out0  (PORT_LCDDAT)
    endm
