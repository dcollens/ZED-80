//
//  io_lcdpanel.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.
//Copyright © 2019 The Head. All rights reserved.
//

#include "io_lcdpanel.h"
#include "strutils.hpp"
#include "z80.h"

using std::cout;
using std::endl;
using std::min;
using std::abs;

LcdPanelDevice::LcdPanelDevice() : _ra8876(_gfx_ops), _uiDelegate(nil) {}

// Print a brief message describing this device.
void LcdPanelDevice::describe(std::ostream &out) const {
    out << "LCD panel w/RA8876";
}

// Called at each step of the main CPU emulation.
uint64_t LcdPanelDevice::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    uint8_t portAddr = ioAddr & 0xF;
    if ((pins & Z80_RD) != 0) {
        switch (portAddr) {
            case 0:     // read from status register
                Z80_SET_DATA(pins, _ra8876.read_status());
                break;
            case 1:     // read from data register
                Z80_SET_DATA(pins, _ra8876.read_data());
                break;
            default:
                cout << "LCD: ignoring IO read from port $" << to_hex(ioAddr) << endl;
                break;
        }
    } else if ((pins & Z80_WR) != 0) {
        switch (portAddr) {
            case 0:     // write to command/address register
                _ra8876.write_cmd(Z80_GET_DATA(pins));
                break;
            case 1:     // write to data register
                _ra8876.write_data(Z80_GET_DATA(pins));
                break;
            default:
                cout << "LCD: ignoring IO write to port $" << to_hex(ioAddr) << endl;
                break;
        }
    }
    return pins;
}

// static
NSColor *LcdPanelDevice::Gfx_ops::nscolor(Color c) {
    return [NSColor colorWithSRGBRed:CGFloat(c.r) / 0xFF
                               green:CGFloat(c.g) / 0xFF
                                blue:CGFloat(c.b) / 0xFF
                               alpha:1];
}

// static
NSRect LcdPanelDevice::Gfx_ops::nsrect(Point p1, Point p2) {
    return NSMakeRect(min(p1.x, p2.x), min(p1.y, p2.y),
                      abs(p2.x - p1.y), abs(p2.y - p1.y));
}

void LcdPanelDevice::Gfx_ops::draw_line(Color c, Point p1, Point p2) {
    [_panelView drawLineFrom:NSMakePoint(p1.x, p1.y)
                          to:NSMakePoint(p2.x, p2.y)
                   withColor:nscolor(c)];
}

void LcdPanelDevice::Gfx_ops::draw_rect(Color c, Point p1, Point p2) {
    [_panelView drawRect:nsrect(p1, p2) withColor:nscolor(c)];
}

void LcdPanelDevice::Gfx_ops::fill_rect(Color c, Point p1, Point p2) {
    [_panelView fillRect:nsrect(p1, p2) withColor:nscolor(c)];
}

void LcdPanelDevice::Gfx_ops::draw_triangle(Color c, Point p1, Point p2, Point p3) {
    [_panelView drawTriangleFrom:NSMakePoint(p1.x, p1.y)
                              to:NSMakePoint(p2.x, p2.y)
                              to:NSMakePoint(p3.x, p3.y)
                       withColor:nscolor(c)];
}

void LcdPanelDevice::Gfx_ops::fill_triangle(Color c, Point p1, Point p2, Point p3) {
    [_panelView fillTriangleFrom:NSMakePoint(p1.x, p1.y)
                              to:NSMakePoint(p2.x, p2.y)
                              to:NSMakePoint(p3.x, p3.y)
                       withColor:nscolor(c)];
}

void LcdPanelDevice::Gfx_ops::draw_ellipse(Color c, Point center, Point radii) {
    [_panelView drawEllipseAt:NSMakePoint(center.x, center.y)
                    withRadii:NSMakeSize(radii.x, radii.y)
                        color:nscolor(c)];
}

void LcdPanelDevice::Gfx_ops::fill_ellipse(Color c, Point center, Point radii) {
    [_panelView fillEllipseAt:NSMakePoint(center.x, center.y)
                    withRadii:NSMakeSize(radii.x, radii.y)
                        color:nscolor(c)];
}
