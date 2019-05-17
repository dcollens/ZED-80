//
//  ra8876.cpp
//  gui
//
//  Created by Daniel Collens on 2019-05-16.
//  Copyright © 2019 The Head. All rights reserved.
//

#include <iostream>
#include "ra8876.h"
#include "strutils.hpp"

using std::cout;
using std::endl;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
// Status register values
static constexpr uint8_t STAT_INTR =    0x01;   // Interrupt pin state (active high)
static constexpr uint8_t STAT_MODE =    0x02;   // Operation mode status (normal=low)
static constexpr uint8_t STAT_RAMRDY =  0x04;   // SDRAM ready for access (active high)
static constexpr uint8_t STAT_BUSY =    0x08;   // Core task is busy (active high)
static constexpr uint8_t STAT_RDEMPTY = 0x10;   // Host Memory Read FIFO empty (active high)
static constexpr uint8_t STAT_RDFULL =  0x20;   // Host Memory Read FIFO full (active high)
static constexpr uint8_t STAT_WREMPTY = 0x40;   // Host Memory Write FIFO empty (active high)
static constexpr uint8_t STAT_WRFULL =  0x80;   // Host Memory Write FIFO full (active high)

// DCR0 (register $67) register values
static constexpr uint8_t DCR0_DRWLIN =  0x00;   // Draw line
static constexpr uint8_t DCR0_DRWTRI =  0x02;   // Draw triangle
static constexpr uint8_t DCR0_FILL =    0x20;   // Fill (0 = outline, 1 = fill)
static constexpr uint8_t DCR0_RUN =     0x80;   // Start drawing / drawing in progress

// DCR1 (register $76) register values
static constexpr uint8_t DCR1_QUADBL =  0x00;   // Ellipse curve, bottom-left quadrant
static constexpr uint8_t DCR1_QUADTL =  0x01;   // Ellipse curve, top-left quadrant
static constexpr uint8_t DCR1_QUADTR =  0x02;   // Ellipse curve, top-right quadrant
static constexpr uint8_t DCR1_QUADBR =  0x03;   // Ellipse curve, bottom-right quadrant
static constexpr uint8_t DCR1_DRWELL =  0x00;   // Draw circle/ellipse
static constexpr uint8_t DCR1_DRWCUR =  0x10;   // Draw circle/ellipse curve (one quadrant)
static constexpr uint8_t DCR1_DRWRCT =  0x20;   // Draw rectangle
static constexpr uint8_t DCR1_DRWRR =   0x30;   // Draw round-rectangle
static constexpr uint8_t DCR1_FILL =    0x40;   // Fill (0 = outline, 1 = fill)
static constexpr uint8_t DCR1_RUN =     0x80;   // Start drawing / drawing in progress

// Register numbers within the RA8876 chip
static constexpr uint8_t REG_SRR = 0x00;        // Software Reset Register
static constexpr uint8_t REG_CCR = 0x01;        // Chip Configuration Register
static constexpr uint8_t REG_MACR = 0x02;       // Memory Access Control Register
static constexpr uint8_t REG_ICR = 0x03;        // Input Control Register
static constexpr uint8_t REG_MRWDP = 0x04;      // Memory Data Read/Write Port
static constexpr uint8_t REG_PPLLC1 = 0x05;     // SCLK PLL Control Register 1
static constexpr uint8_t REG_PPLLC2 = 0x06;     // SCLK PLL Control Register 2
static constexpr uint8_t REG_MPLLC1 = 0x07;     // MCLK PLL Control Register 1
static constexpr uint8_t REG_MPLLC2 = 0x08;     // MCLK PLL Control Register 2
static constexpr uint8_t REG_SPLLC1 = 0x09;     // CCLK PLL Control Register 1
static constexpr uint8_t REG_SPLLC2 = 0x0A;     // CCLK PLL Control Register 2
static constexpr uint8_t REG_INTEN = 0x0B;      // Interrupt Enable Register
static constexpr uint8_t REG_INTF = 0x0C;       // Interrupt Event Flag Register
static constexpr uint8_t REG_MINTFR = 0x0D;     // Mask Interrupt Flag Register
static constexpr uint8_t REG_PUENR = 0x0E;      // Pull-up Enable Register
static constexpr uint8_t REG_PSFSR = 0x0F;      // PDAT for PIO/Key Function Select Register
static constexpr uint8_t REG_MPWCTR = 0x10;     // Main/PIP Window Control Register
static constexpr uint8_t REG_PIPCDEP = 0x11;    // PIP Window Color Depth Setting
static constexpr uint8_t REG_DPCR = 0x12;       // Display Configuration Register
static constexpr uint8_t REG_PCSR = 0x13;       // Panel scan Clock & Data Setting Register
static constexpr uint8_t REG_HDWR = 0x14;       // Horizontal Display Width Register
static constexpr uint8_t REG_HDWFTR = 0x15;     // Horizontal Display Width Fine Tune Register
static constexpr uint8_t REG_HNDR = 0x16;       // Horizontal Non-Display Period Register
static constexpr uint8_t REG_HNDFTR = 0x17;     // Horizontal Non-Display Period Fine Tune Register
static constexpr uint8_t REG_HSTR = 0x18;       // HSYNC Start Position Register
static constexpr uint8_t REG_HPWR = 0x19;       // HSYNC Pulse Width Register
static constexpr uint8_t REG_VDHR0 = 0x1A;      // Vertical Display Height Register 0
static constexpr uint8_t REG_VDHR1 = 0x1B;      // Vertical Display Height Register 1
static constexpr uint8_t REG_VNDR0 = 0x1C;      // Vertical Non-Display Period Register 0
static constexpr uint8_t REG_VNDR1 = 0x1D;      // Vertical Non-Display Period Register 1
static constexpr uint8_t REG_VSTR = 0x1E;       // VSYNC Start Position Register
static constexpr uint8_t REG_VPWR = 0x1F;       // VSYNC Pulse Width Register
static constexpr uint8_t REG_MISA0 = 0x20;      // Main Image Start Address 0
static constexpr uint8_t REG_MISA1 = 0x21;      // Main Image Start Address 1
static constexpr uint8_t REG_MISA2 = 0x22;      // Main Image Start Address 2
static constexpr uint8_t REG_MISA3 = 0x23;      // Main Image Start Address 3
static constexpr uint8_t REG_MIW0 = 0x24;       // Main Image Width 0
static constexpr uint8_t REG_MIW1 = 0x25;       // Main Image Width 1
static constexpr uint8_t REG_MWULX0 = 0x26;     // Main Window Upper-Left corner X-coordinates 0
static constexpr uint8_t REG_MWULX1 = 0x27;     // Main Window Upper-Left corner X-coordinates 1
static constexpr uint8_t REG_MWULY0 = 0x28;     // Main Window Upper-Left corner Y-coordinates 0
static constexpr uint8_t REG_MWULY1 = 0x29;     // Main Window Upper-Left corner Y-coordinates 1

static constexpr uint8_t REG_CVSSA0 = 0x50;     // Canvas Start Address 0
static constexpr uint8_t REG_CVSSA1 = 0x51;     // Canvas Start Address 1
static constexpr uint8_t REG_CVSSA2 = 0x52;     // Canvas Start Address 2
static constexpr uint8_t REG_CVSSA3 = 0x53;     // Canvas Start Address 3
static constexpr uint8_t REG_CVS_IMWTH0 = 0x54; // Canvas Image Width 0
static constexpr uint8_t REG_CVS_IMWTH1 = 0x55; // Canvas Image Width 1
static constexpr uint8_t REG_AWUL_X0 = 0x56;    // Active Window Upper-Left corner X-coordinates 0
static constexpr uint8_t REG_AWUL_X1 = 0x57;    // Active Window Upper-Left corner X-coordinates 1
static constexpr uint8_t REG_AWUL_Y0 = 0x58;    // Active Window Upper-Left corner Y-coordinates 0
static constexpr uint8_t REG_AWUL_Y1 = 0x59;    // Active Window Upper-Left corner Y-coordinates 1
static constexpr uint8_t REG_AW_WTH0 = 0x5A;    // Active Window Width 0
static constexpr uint8_t REG_AW_WTH1 = 0x5B;    // Active Window Width 1
static constexpr uint8_t REG_AW_HT0 = 0x5C;     // Active Window Height 0
static constexpr uint8_t REG_AW_HT1 = 0x5D;     // Active Window Height 1
static constexpr uint8_t REG_AW_COLOR = 0x5E;   // Color Depth of Canvas & Active Window

static constexpr uint8_t REG_F_CURX0 = 0x63;    // Text Write X-coordinates Register 0
static constexpr uint8_t REG_F_CURX1 = 0x64;    // Text Write X-coordinates Register 1
static constexpr uint8_t REG_F_CURY0 = 0x65;    // Text Write Y-coordinates Register 0
static constexpr uint8_t REG_F_CURY1 = 0x66;    // Text Write Y-coordinates Register 1
static constexpr uint8_t REG_DCR0 = 0x67;       // Draw Line/Triangle Control Register 0
static constexpr uint8_t REG_DLHSR0 = 0x68;     // Draw Line/Square/Triangle Point 1 X-coordinates 0
static constexpr uint8_t REG_DLHSR1 = 0x69;     // Draw Line/Square/Triangle Point 1 X-coordinates 1
static constexpr uint8_t REG_DLVSR0 = 0x6A;     // Draw Line/Square/Triangle Point 1 Y-coordinates 0
static constexpr uint8_t REG_DLVSR1 = 0x6B;     // Draw Line/Square/Triangle Point 1 Y-coordinates 1
static constexpr uint8_t REG_DLHER0 = 0x6C;     // Draw Line/Square/Triangle Point 2 X-coordinates 0
static constexpr uint8_t REG_DLHER1 = 0x6D;     // Draw Line/Square/Triangle Point 2 X-coordinates 1
static constexpr uint8_t REG_DLVER0 = 0x6E;     // Draw Line/Square/Triangle Point 2 Y-coordinates 0
static constexpr uint8_t REG_DLVER1 = 0x6F;     // Draw Line/Square/Triangle Point 2 Y-coordinates 1
static constexpr uint8_t REG_DTPH0 = 0x70;      // Draw Triangle Point 3 X-coordinates 0
static constexpr uint8_t REG_DTPH1 = 0x71;      // Draw Triangle Point 3 X-coordinates 1
static constexpr uint8_t REG_DTPV0 = 0x72;      // Draw Triangle Point 3 Y-coordinates 0
static constexpr uint8_t REG_DTPV1 = 0x73;      // Draw Triangle Point 3 Y-coordinates 1
// Registers 0x74-0x75 reserved
static constexpr uint8_t REG_DCR1 = 0x76;       // Draw Circle/Ellipse/Ellipse Curve/Circle Square Ctl Reg
static constexpr uint8_t REG_ELL_A0 = 0x77;     // Draw Circle/Ellipse/Circle Square Major radius Setting Reg
static constexpr uint8_t REG_ELL_A1 = 0x78;     // Draw Circle/Ellipse/Circle Square Major radius Setting Reg
static constexpr uint8_t REG_ELL_B0 = 0x79;     // Draw Circle/Ellipse/Circle Square Minor radius Setting Reg
static constexpr uint8_t REG_ELL_B1 = 0x7A;     // Draw Circle/Ellipse/Circle Square Minor radius Setting Reg
static constexpr uint8_t REG_DEHR0 = 0x7B;      // Draw Circle/Ellipse/Circle Square Center X-coords 0
static constexpr uint8_t REG_DEHR1 = 0x7C;      // Draw Circle/Ellipse/Circle Square Center X-coords 1
static constexpr uint8_t REG_DEVR0 = 0x7D;      // Draw Circle/Ellipse/Circle Square Center Y-coords 0
static constexpr uint8_t REG_DEVR1 = 0x7E;      // Draw Circle/Ellipse/Circle Square Center Y-coords 1

static constexpr uint8_t REG_CCR0 = 0xCC;       // Character Control Register 0
static constexpr uint8_t REG_CCR1 = 0xCD;       // Character Control Register 1

static constexpr uint8_t REG_FLDR = 0xD0;       // Character Line Gap Setting Register
static constexpr uint8_t REG_F2FSSR = 0xD1;     // Character to Character Space Setting Register
static constexpr uint8_t REG_FGCR = 0xD2;       // Foreground Color Register - Red
static constexpr uint8_t REG_FGCG = 0xD3;       // Foreground Color Register - Green
static constexpr uint8_t REG_FGCB = 0xD4;       // Foreground Color Register - Blue
static constexpr uint8_t REG_BGCR = 0xD5;       // Background Color Register - Red
static constexpr uint8_t REG_BGCG = 0xD6;       // Background Color Register - Green
static constexpr uint8_t REG_BGCB = 0xD7;       // Background Color Register - Blue

static constexpr uint8_t REG_SDRAR = 0xE0;      // SDRAM Attribute Register
static constexpr uint8_t REG_SDRMD = 0xE1;      // SDRAM mode register & extended mode register
static constexpr uint8_t REG_SDR_REF_ITVL0 = 0xE2; // SDRAM auto refresh interval
static constexpr uint8_t REG_SDR_REF_ITVL1 = 0xE3; // SDRAM auto refresh interval
static constexpr uint8_t REG_SDRCR = 0xE4;      // SDRAM Control Register
#pragma clang diagnostic pop

RA8876::RA8876(Gfx_ops &gfx_ops) : _gfx_ops(gfx_ops) {
    _status = 0;
    _address = 0;
    _regs.fill(0);

    soft_reset();
}

void RA8876::soft_reset() {
    _status = STAT_RAMRDY | STAT_RDEMPTY | STAT_WREMPTY;
    _regs.at(REG_SRR) = (0x06 << 5) | (0x05 << 2) | 0x02;
    _regs.at(REG_CCR) = 0x88;
}

void RA8876::wr(uint8_t value) {
    _regs.at(_address) = value;
}

RA8876::Color RA8876::get_fg_color() const {
    return Color(_regs.at(REG_FGCR), _regs.at(REG_FGCG), _regs.at(REG_FGCB));
}

RA8876::Color RA8876::get_bg_color() const {
    return Color(_regs.at(REG_BGCR), _regs.at(REG_BGCG), _regs.at(REG_BGCB));
}

RA8876::Point RA8876::get_pt(uint8_t base_reg) const {
    return Point(_regs.at(base_reg) | (uint16_t(_regs.at(base_reg + 1)) << 8),
                 _regs.at(base_reg + 2) | (uint16_t(_regs.at(base_reg + 3)) << 8));
}

void RA8876::set_pt(Point p, uint8_t base_reg) {
    _regs.at(base_reg) = p.x & 0xFF;
    _regs.at(base_reg + 1) = (p.x >> 8) & 0x1F;
    _regs.at(base_reg + 2) = p.y & 0xFF;
    _regs.at(base_reg + 3) = (p.y >> 8) & 0x1F;
}

RA8876::Point RA8876::get_awul_pt() const {
    return get_pt(REG_AWUL_X0);
}

RA8876::Point RA8876::get_aw_sz() const {
    return get_pt(REG_AW_WTH0);
}

RA8876::Point RA8876::get_lintri_pt1() const {
    return get_pt(REG_DLHSR0);
}
RA8876::Point RA8876::get_lintri_pt2() const {
    return get_pt(REG_DLHER0);
}
RA8876::Point RA8876::get_lintri_pt3() const {
    return get_pt(REG_DTPH0);
}

RA8876::Point RA8876::get_text_pt() const {
    return get_pt(REG_F_CURX0);
}

void RA8876::set_text_pt(Point p) {
    set_pt(p, REG_F_CURX0);
}

RA8876::Point RA8876::get_ellipse_pt() const {
    return get_pt(REG_DEHR0);
}
RA8876::Point RA8876::get_ellipse_radii() const {
    return get_pt(REG_ELL_A0);
}

void RA8876::advance_text_position() {
    int char_width = 0;
    int char_height = 0;
    switch ((_regs.at(REG_CCR0) >> 4) & 0x3) {
        case 0:
            char_width = 8;
            char_height = 16;
            break;
        case 1:
            char_width = 12;
            char_height = 24;
            break;
        case 2:
            char_width = 16;
            char_height = 32;
            break;
    }
    
    Point p = get_text_pt();
    p.x += char_width
        + (_regs.at(REG_F2FSSR) & 0x3F);    // character to character space setting
    
    // Wrap to the next line at the right-hand edge of the active window
    Point awpt = get_awul_pt();
    Point awsz = get_aw_sz();
    if (p.x + char_width > awpt.x + awsz.x) {
        // Wrap line.
        p.x = awpt.x;
        p.y += char_height
            + (_regs.at(REG_FLDR) & 0x1F);  // character line gap setting
    }
    set_text_pt(p);
}

void RA8876::write_data(uint8_t value) {
    // The approach is to whitelist any write operations, making sure we mask off the bits that
    // are read-only in the register space. Some registers trigger operations, in which case we
    // make the appropriate call-outs.
    switch (_address) {
        case REG_SRR:
            if ((value & 0x01) != 0) {
                soft_reset();
            }
            break;
        case REG_CCR:
            wr(value & 0x7F);
            break;
        case REG_MACR:
            wr(value & 0xF6);
            break;
        case REG_MPWCTR:
            wr(value & 0xDD);
            break;
        case REG_PPLLC1:
            wr(value & 0xBF);
            break;
        case REG_MPLLC1:
        case REG_SPLLC1:
        case REG_VDHR1:
        case REG_AW_COLOR:
            wr(value & 0x07);
            break;
        case REG_PPLLC2:
        case REG_MPLLC2:
        case REG_SPLLC2:
        case REG_VPWR:
        case REG_F2FSSR:
            wr(value & 0x3F);
            break;
        case REG_DPCR:
            wr(value & 0xEF);
            break;
        case REG_HDWFTR:
        case REG_HNDFTR:
            wr(value & 0x0F);
            break;
        case REG_VNDR1:
            wr(value & 0x03);
            break;
        case REG_CCR0:
            wr(value & 0xF3);
            break;
        case REG_CCR1:
            wr(value & 0xDF);
            break;
        case REG_HNDR:
        case REG_HSTR:
        case REG_HPWR:
        case REG_MIW1:
        case REG_MWULX1:
        case REG_MWULY1:
        case REG_AWUL_X1:
        case REG_AWUL_Y1:
        case REG_CVS_IMWTH1:
        case REG_AW_WTH1:
        case REG_AW_HT1:
        case REG_DLHSR1:
        case REG_DLVSR1:
        case REG_DLHER1:
        case REG_DLVER1:
        case REG_DTPH1:
        case REG_DTPV1:
        case REG_F_CURX1:
        case REG_F_CURY1:
        case REG_DEHR1:
        case REG_DEVR1:
        case REG_ELL_A1:
        case REG_ELL_B1:
        case REG_FLDR:
            wr(value & 0x1F);
            break;
        case REG_MISA0:
        case REG_CVSSA0:
        case REG_CVS_IMWTH0:
            wr(value & 0xFC);
            break;
        case REG_SDRCR:
            wr(value | (_regs.at(REG_SDRCR) & 0x01));
            break;
        // These registers are all just straight read/write.
        case REG_ICR:
        case REG_PCSR:
        case REG_HDWR:
        case REG_VDHR0:
        case REG_VNDR0:
        case REG_VSTR:
        case REG_MISA1:
        case REG_MISA2:
        case REG_MISA3:
        case REG_CVSSA1:
        case REG_CVSSA2:
        case REG_CVSSA3:
        case REG_MIW0:
        case REG_MWULX0:
        case REG_MWULY0:
        case REG_AWUL_X0:
        case REG_AWUL_Y0:
        case REG_AW_WTH0:
        case REG_AW_HT0:
        case REG_FGCR:
        case REG_FGCG:
        case REG_FGCB:
        case REG_BGCR:
        case REG_BGCG:
        case REG_BGCB:
        case REG_DLHSR0:
        case REG_DLVSR0:
        case REG_DLHER0:
        case REG_DLVER0:
        case REG_DTPH0:
        case REG_DTPV0:
        case REG_F_CURX0:
        case REG_F_CURY0:
        case REG_DEHR0:
        case REG_DEVR0:
        case REG_ELL_A0:
        case REG_ELL_B0:
        case REG_SDRAR:
        case REG_SDRMD:
        case REG_SDR_REF_ITVL0:
        case REG_SDR_REF_ITVL1:
            wr(value);
            break;
        case REG_DCR0:
            wr(value & 0x22);
            if ((value & DCR0_RUN) != 0) {
                Color c = get_fg_color();
                Point p1 = get_lintri_pt1();
                Point p2 = get_lintri_pt2();
                if ((value & 0x02) == DCR0_DRWLIN) {
                    _gfx_ops.draw_line(c, p1, p2);
                } else {
                    // Triangle.
                    Point p3 = get_lintri_pt3();
                    if ((value & 0x20) == DCR0_FILL) {
                        _gfx_ops.fill_triangle(c, p1, p2, p3);
                    } else {
                        _gfx_ops.draw_triangle(c, p1, p2, p3);
                    }
                }
            }
            break;
        case REG_DCR1:
            wr(value & 0x73);
            if ((value & DCR1_RUN) != 0) {
                Color c = get_fg_color();
                switch (value & 0x30) {
                    case DCR1_DRWELL: {
                        Point center = get_ellipse_pt();
                        Point radii = get_ellipse_radii();
                        if ((value & DCR1_FILL) == 0) {
                            _gfx_ops.draw_ellipse(c, center, radii);
                        } else {
                            _gfx_ops.fill_ellipse(c, center, radii);
                        }
                        break;
                    }
                    case DCR1_DRWCUR:
                        cout << "RA8876: ignoring attempt to draw curve" << endl;
                        break;
                    case DCR1_DRWRCT: {
                        Point p1 = get_lintri_pt1();
                        Point p2 = get_lintri_pt2();
                        if ((value & DCR1_FILL) == 0) {
                            _gfx_ops.draw_rect(c, p1, p2);
                        } else {
                            _gfx_ops.fill_rect(c, p1, p2);
                        }
                        break;
                    }
                    case DCR1_DRWRR:
                        cout << "RA8876: ignoring attempt to draw round-rect" << endl;
                        break;
                }
            }
            break;
        case REG_MRWDP:
            if ((_regs.at(REG_ICR) & 0x04) == 0) {
                cout << "RA8876: ignoring attempt to write to Memory Data Read/Write Port in graphics mode" << endl;
            } else {
                // Text mode.
                bool transparent_bg = (_regs.at(REG_CCR1) & 0x04) != 0;
                _gfx_ops.draw_text(value, get_text_pt(), get_fg_color(), get_bg_color(),
                                   transparent_bg);
                advance_text_position();
            }
            break;
        default:
            cout << "RA8876: ignoring write of $" << to_hex(value)
                 << " to register $" << to_hex(_address) << endl;
            break;
    }
}

uint8_t RA8876::read_data() const {
    if (_address == REG_MRWDP) {
        cout << "RA8876: ignoring attempt to read from Memory Data Read/Write Port ($04)" << endl;
        return 0;
    } else {
        return _regs.at(_address);
    }
}
