#ifndef _LCD_H_INCLUDED
#define _LCD_H_INCLUDED

#include <stdint.h>

// Panel geometry
#define LCD_WIDTH	1024
#define LCD_HEIGHT	600
#define LCD_TXT_WIDTH	8
#define LCD_TXT_HEIGHT	16

// Status register values
#define LCDSTAT_INTR	0x01		// Interrupt pin state (active high)
#define LCDSTAT_MODE	0x02		// Operation mode status (normal=low)
#define LCDSTAT_RAMRDY	0x04		// SDRAM ready for access (active high)
#define LCDSTAT_BUSY	0x08		// Core task is busy (active high)
#define LCDSTAT_RDEMPTY	0x10		// Host Memory Read FIFO empty (active high)
#define LCDSTAT_RDFULL	0x20		// Host Memory Read FIFO full (active high)
#define LCDSTAT_WREMPTY	0x40		// Host Memory Write FIFO empty (active high)
#define LCDSTAT_WRFULL	0x80		// Host Memory Write FIFO full (active high)

// DCR0 (register $67) register values
#define LCDDCR0_DRWLIN	0x00		// Draw line
#define LCDDCR0_DRWTRI	0x02		// Draw triangle
#define LCDDCR0_FILL	0x20		// Fill (0 = outline, 1 = fill)
#define LCDDCR0_RUN	0x80		// Start drawing / drawing in progress

// DCR1 (register $76) register values
#define LCDDCR1_QUADBL	0x00		// Ellipse curve, bottom-left quadrant
#define LCDDCR1_QUADTL	0x01		// Ellipse curve, top-left quadrant
#define LCDDCR1_QUADTR	0x02		// Ellipse curve, top-right quadrant
#define LCDDCR1_QUADBR	0x03		// Ellipse curve, bottom-right quadrant
#define LCDDCR1_DRWELL	0x00		// Draw circle/ellipse
#define LCDDCR1_DRWCUR	0x10		// Draw circle/ellipse curve (one quadrant)
#define LCDDCR1_DRWRCT	0x20		// Draw rectangle
#define LCDDCR1_DRWRR	0x30		// Draw round-rectangle
#define LCDDCR1_FILL	0x40		// Fill (0 = outline, 1 = fill)
#define LCDDCR1_RUN	0x80		// Start drawing / drawing in progress

// Register numbers within the RA8876 chip
#define LCDREG_SRR	0x00		// Software Reset Register
#define LCDREG_CCR	0x01		// Chip Configuration Register
#define LCDREG_MACR	0x02		// Memory Access Control Register
#define LCDREG_ICR	0x03		// Input Control Register
#define LCDREG_MRWDP	0x04		// Memory Data Read/Write Port
#define LCDREG_PPLLC1	0x05		// SCLK PLL Control Register 1
#define LCDREG_PPLLC2	0x06		// SCLK PLL Control Register 2
#define LCDREG_MPLLC1	0x07		// MCLK PLL Control Register 1
#define LCDREG_MPLLC2	0x08		// MCLK PLL Control Register 2
#define LCDREG_SPLLC1	0x09		// CCLK PLL Control Register 1
#define LCDREG_SPLLC2	0x0A		// CCLK PLL Control Register 2
#define LCDREG_INTEN	0x0B		// Interrupt Enable Register
#define LCDREG_INTF	0x0C		// Interrupt Event Flag Register
#define LCDREG_MINTFR	0x0D		// Mask Interrupt Flag Register
#define LCDREG_PUENR	0x0E		// Pull-up Enable Register
#define LCDREG_PSFSR	0x0F		// PDAT for PIO/Key Function Select Register
#define LCDREG_MPWCTR	0x10		// Main/PIP Window Control Register
#define LCDREG_PIPCDEP	0x11		// PIP Window Color Depth Setting
#define LCDREG_DPCR	0x12		// Display Configuration Register
#define LCDREG_PCSR	0x13		// Panel scan Clock & Data Setting Register
#define LCDREG_HDWR	0x14		// Horizontal Display Width Register
#define LCDREG_HDWFTR	0x15		// Horizontal Display Width Fine Tune Register
#define LCDREG_HNDR	0x16		// Horizontal Non-Display Period Register
#define LCDREG_HNDFTR	0x17		// Horizontal Non-Display Period Fine Tune Register
#define LCDREG_HSTR	0x18		// HSYNC Start Position Register
#define LCDREG_HPWR	0x19		// HSYNC Pulse Width Register
#define LCDREG_VDHR0	0x1A		// Vertical Display Height Register 0
#define LCDREG_VDHR1	0x1B		// Vertical Display Height Register 1
#define LCDREG_VNDR0	0x1C		// Vertical Non-Display Period Register 0
#define LCDREG_VNDR1	0x1D		// Vertical Non-Display Period Register 1
#define LCDREG_VSTR	0x1E		// VSYNC Start Position Register
#define LCDREG_VPWR	0x1F		// VSYNC Pulse Width Register
#define LCDREG_MISA0	0x20		// Main Image Start Address 0
#define LCDREG_MISA1	0x21		// Main Image Start Address 1
#define LCDREG_MISA2	0x22		// Main Image Start Address 2
#define LCDREG_MISA3	0x23		// Main Image Start Address 3
#define LCDREG_MIW0	0x24		// Main Image Width 0
#define LCDREG_MIW1	0x25		// Main Image Width 1
#define LCDREG_MWULX0	0x26		// Main Window Upper-Left corner X-coordinates 0
#define LCDREG_MWULX1	0x27		// Main Window Upper-Left corner X-coordinates 1
#define LCDREG_MWULY0	0x28		// Main Window Upper-Left corner Y-coordinates 0
#define LCDREG_MWULY1	0x29		// Main Window Upper-Left corner Y-coordinates 1

#define LCDREG_GTCCR	0x3C		// Graphic/Text Cursor Control Register
#define LCDREG_BTCR	0x3D		// Blink Time Control Register
#define LCDREG_CURHS	0x3E		// Text Cursor Horizontal Size Register
#define LCDREG_CURVS	0x3F		// Text Cursor Vertical Size Register

#define LCDREG_CVSSA0	0x50		// Canvas Start Address 0
#define LCDREG_CVSSA1	0x51		// Canvas Start Address 1
#define LCDREG_CVSSA2	0x52		// Canvas Start Address 2
#define LCDREG_CVSSA3	0x53		// Canvas Start Address 3
#define LCDREG_CVS_IMWTH0 0x54		// Canvas Image Width 0
#define LCDREG_CVS_IMWTH1 0x55		// Canvas Image Width 1
#define LCDREG_AWUL_X0	0x56		// Active Window Upper-Left corner X-coordinates 0
#define LCDREG_AWUL_X1	0x57		// Active Window Upper-Left corner X-coordinates 1
#define LCDREG_AWUL_Y0	0x58		// Active Window Upper-Left corner Y-coordinates 0
#define LCDREG_AWUL_Y1	0x59		// Active Window Upper-Left corner Y-coordinates 1
#define LCDREG_AW_WTH0	0x5A		// Active Window Width 0
#define LCDREG_AW_WTH1	0x5B		// Active Window Width 1
#define LCDREG_AW_HT0	0x5C		// Active Window Height 0
#define LCDREG_AW_HT1	0x5D		// Active Window Height 1
#define LCDREG_AW_COLOR 0x5E		// Color Depth of Canvas & Active Window

#define LCDREG_F_CURX0	0x63		// Text Write X-coordinates Register 0
#define LCDREG_F_CURX1	0x64		// Text Write X-coordinates Register 1
#define LCDREG_F_CURY0	0x65		// Text Write Y-coordinates Register 0
#define LCDREG_F_CURY1	0x66		// Text Write Y-coordinates Register 1
#define LCDREG_DCR0	0x67		// Draw Line/Triangle Control Register 0
#define LCDREG_DLHSR0	0x68		// Draw Line/Square/Triangle Point 1 X-coordinates 0
#define LCDREG_DLHSR1	0x69		// Draw Line/Square/Triangle Point 1 X-coordinates 1
#define LCDREG_DLVSR0	0x6A		// Draw Line/Square/Triangle Point 1 Y-coordinates 0
#define LCDREG_DLVSR1	0x6B		// Draw Line/Square/Triangle Point 1 Y-coordinates 1
#define LCDREG_DLHER0	0x6C		// Draw Line/Square/Triangle Point 2 X-coordinates 0
#define LCDREG_DLHER1	0x6D		// Draw Line/Square/Triangle Point 2 X-coordinates 1
#define LCDREG_DLVER0	0x6E		// Draw Line/Square/Triangle Point 2 Y-coordinates 0
#define LCDREG_DLVER1	0x6F		// Draw Line/Square/Triangle Point 2 Y-coordinates 1
#define LCDREG_DTPH0	0x70		// Draw Triangle Point 3 X-coordinates 0
#define LCDREG_DTPH1	0x71		// Draw Triangle Point 3 X-coordinates 1
#define LCDREG_DTPV0	0x72		// Draw Triangle Point 3 Y-coordinates 0
#define LCDREG_DTPV1	0x73		// Draw Triangle Point 3 Y-coordinates 1
// Registers 0x74-0x75 reserved
#define LCDREG_DCR1	0x76		// Draw Circle/Ellipse/Ellipse Curve/Circle Square Ctl Reg
#define LCDREG_ELL_A0	0x77		// Draw Circle/Ellipse/Circle Square Major radius Setting Reg
#define LCDREG_ELL_A1	0x78		// Draw Circle/Ellipse/Circle Square Major radius Setting Reg
#define LCDREG_ELL_B0	0x79		// Draw Circle/Ellipse/Circle Square Minor radius Setting Reg
#define LCDREG_ELL_B1	0x7A		// Draw Circle/Ellipse/Circle Square Minor radius Setting Reg
#define LCDREG_DEHR0	0x7B		// Draw Circle/Ellipse/Circle Square Center X-coords 0
#define LCDREG_DEHR1	0x7C		// Draw Circle/Ellipse/Circle Square Center X-coords 1
#define LCDREG_DEVR0	0x7D		// Draw Circle/Ellipse/Circle Square Center Y-coords 0
#define LCDREG_DEVR1	0x7E		// Draw Circle/Ellipse/Circle Square Center Y-coords 1

#define LCDREG_BTE_CTRL0 0x90		// BTE Function Control Register 0
#define LCDREG_BTE_CTRL1 0x91		// BTE Function Control Register 1
#define LCDREG_BTE_COLR 0x92		// Source 0/1 & Destination Color Depth
#define LCDREG_S0_STR0	0x93		// Source 0 memory start address 0
#define LCDREG_S0_STR1	0x94		// Source 0 memory start address 1
#define LCDREG_S0_STR2	0x95		// Source 0 memory start address 2
#define LCDREG_S0_STR3	0x96		// Source 0 memory start address 3
#define LCDREG_S0_WTH0	0x97		// Source 0 image width 0
#define LCDREG_S0_WTH1	0x98		// Source 0 image width 1
#define LCDREG_S0_X0	0x99		// Source 0 Window Upper-Left corner X-coordinates 0
#define LCDREG_S0_X1	0x9A		// Source 0 Window Upper-Left corner X-coordinates 1
#define LCDREG_S0_Y0	0x9B		// Source 0 Window Upper-Left corner Y-coordinates 0
#define LCDREG_S0_Y1	0x9C		// Source 0 Window Upper-Left corner Y-coordinates 1
#define LCDREG_S1_STR0	0x9D		// Source 1 memory start address 0
#define LCDREG_S1_STR1	0x9E		// Source 1 memory start address 1
#define LCDREG_S1_STR2	0x9F		// Source 1 memory start address 2
#define LCDREG_S1_STR3	0xA0		// Source 1 memory start address 3
#define LCDREG_S1_WTH0	0xA1		// Source 1 image width 0
#define LCDREG_S1_WTH1	0xA2		// Source 1 image width 1
#define LCDREG_S1_X0	0xA3		// Source 1 Window Upper-Left corner X-coordinates 0
#define LCDREG_S1_X1	0xA4		// Source 1 Window Upper-Left corner X-coordinates 1
#define LCDREG_S1_Y0	0xA5		// Source 1 Window Upper-Left corner Y-coordinates 0
#define LCDREG_S1_Y1	0xA6		// Source 1 Window Upper-Left corner Y-coordinates 1
#define LCDREG_DT_STR0	0xA7		// Destination memory start address 0
#define LCDREG_DT_STR1	0xA8		// Destination memory start address 1
#define LCDREG_DT_STR2	0xA9		// Destination memory start address 2
#define LCDREG_DT_STR3	0xAA		// Destination memory start address 3
#define LCDREG_DT_WTH0	0xAB		// Destination image width 0
#define LCDREG_DT_WTH1	0xAC		// Destination image width 1
#define LCDREG_DT_X0	0xAD		// Destination Window Upper-Left corner X-coordinates 0
#define LCDREG_DT_X1	0xAE		// Destination Window Upper-Left corner X-coordinates 1
#define LCDREG_DT_Y0	0xAF		// Destination Window Upper-Left corner Y-coordinates 0
#define LCDREG_DT_Y1	0xB0		// Destination Window Upper-Left corner Y-coordinates 1
#define LCDREG_BTE_WTH0	0xB1		// BTE Window Width 0
#define LCDREG_BTE_WTH1	0xB2		// BTE Window Width 1
#define LCDREG_BTE_HIG0	0xB3		// BTE Window Height 0
#define LCDREG_BTE_HIG1	0xB4		// BTE Window Height 1
#define LCDREG_APB_CTRL 0xB5		// Alpha Blending

#define LCDREG_CCR0	0xCC		// Character Control Register 0
#define LCDREG_CCR1	0xCD		// Character Control Register 1

#define LCDREG_FLDR	0xD0		// Character Line Gap Setting Register
#define LCDREG_F2FSSR	0xD1		// Character to Character Space Setting Register
#define LCDREG_FGCR	0xD2		// Foreground Color Register - Red
#define LCDREG_FGCG	0xD3		// Foreground Color Register - Green
#define LCDREG_FGCB	0xD4		// Foreground Color Register - Blue
#define LCDREG_BGCR	0xD5		// Background Color Register - Red
#define LCDREG_BGCG	0xD6		// Background Color Register - Green
#define LCDREG_BGCB	0xD7		// Background Color Register - Blue

#define LCDREG_SDRAR	0xE0		// SDRAM Attribute Register
#define LCDREG_SDRMD	0xE1		// SDRAM mode register & extended mode register
#define LCDREG_SDR_REF_ITVL0 0xE2	// SDRAM auto refresh interval
#define LCDREG_SDR_REF_ITVL1 0xE3	// SDRAM auto refresh interval
#define LCDREG_SDRCR	0xE4		// SDRAM Control Register

// We can't pass structs as function arguments (or return them from functions) in SDCC, so
// we just use a uint32_t to represent a color.
// R in the least-significant byte, G in the second byte, B in the third byte.
// R,G,B uses upper 5,6,5 bits of precision only (i.e. 16bpp color).
typedef uint32_t lcd_color_t;

#define COLOR_MAKE(r,g,b)	((uint32_t)(r) | ((uint32_t)(g) << 8) | ((uint32_t)(b) << 16))
#define COLOR_R(c)		((uint8_t)(c))
#define COLOR_G(c)		((uint8_t)((c) >> 8))
#define COLOR_B(c)		((uint8_t)((c) >> 16))

#define COLOR_BLACK		0x000000UL
#define COLOR_WHITE		0xFFFFFFUL

void lcd_set_fgcolor(lcd_color_t color) __z88dk_fastcall;

void lcd_out32(uint8_t regbase, uint16_t v1, uint16_t v2);

#define lcd_line_start_xy(x, y)	    lcd_out32(LCDREG_DLHSR0, (x), (y))
#define lcd_line_end_xy(x, y)	    lcd_out32(LCDREG_DLHER0, (x), (y))

void lcd_wait_idle(void);

#endif
