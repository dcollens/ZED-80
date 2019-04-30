//
//  io_sysreg.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "io_sysreg.hpp"
#include "strutils.hpp"
#include "z80.h"

using std::cout;
using std::endl;

// Print a brief message describing this device.
void SysRegDevice::describe(std::ostream &out) const {
    out << "SysReg";
}

// Called at each step of the main CPU emulation.
uint64_t SysRegDevice::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    if ((pins & Z80_RD) != 0) {
        Z80_SET_DATA(pins, _value);
    } else if ((pins & Z80_WR) != 0) {
        _value = Z80_GET_DATA(pins);
    }
    return pins;
}
