//
//  io_joyseg.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "io_joyseg.h"
#include "strutils.h"
#include "z80.h"

using std::cout;
using std::endl;

static constexpr uint8_t JOY_UP = 0x01;
static constexpr uint8_t JOY_DOWN = 0x02;
static constexpr uint8_t JOY_LEFT = 0x04;
static constexpr uint8_t JOY_RIGHT = 0x08;
static constexpr uint8_t JOY_FIRE = 0x10;
static constexpr uint8_t JOY1_SDWP = 0x20; // SD-card write protect (only on PORT_JOY1)
static constexpr uint8_t JOY1_SDCD = 0x40; // SD-card card detect (active low) (only on PORT_JOY1)
// static constexpr uint8_t JOY_RESERVED = 0x80;

// Print a brief message describing this device.
void JoySegDevice::describe(std::ostream &out) const {
    out << "JOY/SEG";
}

// Called at each step of the main CPU emulation.
uint64_t JoySegDevice::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    if ((pins & Z80_RD) != 0) {
        // TODO: Joysticks
        uint8_t data = JOY_UP | JOY_DOWN | JOY_LEFT | JOY_RIGHT | JOY_FIRE;
        if ((ioAddr >> 4) == 0) {
            // JOY0
            cout << "JOY: ignoring IO read from port $" << to_hex(ioAddr) << endl;
        } else {
            // JOY1
            if (!_sdcardCardDetect) {
                // Card detect is active low.
                data |= JOY1_SDCD;
            }
            if (_sdcardWriteProtect) {
                // Write protect is active high.
                data |= JOY1_SDWP;
            }
        }
        Z80_SET_DATA(pins, data);
    } else if ((pins & Z80_WR) != 0) {
        [_uiDelegate.zedView setSevenSegment:(ioAddr >> 4) to:Z80_GET_DATA(pins)];
    }
    return pins;
}

void JoySegDevice::reset() {
    for (int i = 0; i < 2; ++i) {
        [_uiDelegate.zedView setSevenSegment:i to:0];
    }
}
