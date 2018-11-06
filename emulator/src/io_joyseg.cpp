//
//  io_joyseg.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "io_joyseg.hpp"
#include "strutils.hpp"
#include "z80.h"

using std::cout;
using std::endl;

// Print a brief message describing this device.
void JoySegDevice::describe(std::ostream &out) const {
    out << "JOY/SEG";
}

// Called at each step of the main CPU emulation.
uint64_t JoySegDevice::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    if ((pins & Z80_RD) != 0) {
        // TODO: Joysticks
        cout << "JOY: ignoring IO read from port $" << to_hex(ioAddr) << endl;
    } else if ((pins & Z80_WR) != 0) {
        // TODO: 7-segment displays
        cout << "SEG: ignoring IO write to port $" << to_hex(ioAddr) << endl;
    }
    return pins;
}
