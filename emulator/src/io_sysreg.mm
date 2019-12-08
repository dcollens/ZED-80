//
//  io_sysreg.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "io_sysreg.h"
#include "strutils.h"
#include "z80.h"

using std::cout;
using std::endl;

// Print a brief message describing this device.
void SysRegDevice::describe(std::ostream &out) const {
    out << "SysReg";
}

// Called at each step of the main CPU emulation.
uint64_t SysRegDevice::tickCallback(int numTicks, uint64_t pins) {
    if ((pins & Z80_RD) != 0) {
        Z80_SET_DATA(pins, _value.get());
    } else if ((pins & Z80_WR) != 0) {
        _value.set(Z80_GET_DATA(pins));
    }
    return pins;
}
