PORT_LCDBASE	equ 0x50		; base port address for RA8876 chip
PORT_LCDCMD	equ PORT_LCDBASE	; port address for RA8876 command/status register
PORT_LCDDAT	equ PORT_LCDBASE + 1	; port address for RA8876 data register

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

LCDREG_FGCR	equ 0xD2		; Foreground Color Register - Red
LCDREG_FGCG	equ 0xD3		; Foreground Color Register - Green
LCDREG_FGCB	equ 0xD4		; Foreground Color Register - Blue

LCDREG_SDRAR	equ 0xE0		; SDRAM Attribute Register
LCDREG_SDRMD	equ 0xE1		; SDRAM mode register & extended mode register
LCDREG_SDR_REF_ITVL0 equ 0xE2		; SDRAM auto refresh interval
LCDREG_SDR_REF_ITVL1 equ 0xE3		; SDRAM auto refresh interval
LCDREG_SDRCR	equ 0xE4		; SDRAM Control Register

M_lcdwrite	macro regnum, val
    ; destroys A
    ld	    a, &regnum
    out	    (PORT_LCDCMD), a
    ld	    a, &val
    out	    (PORT_LCDDAT), a
    endm
