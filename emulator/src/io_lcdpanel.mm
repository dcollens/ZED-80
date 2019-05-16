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
                _ra8876.write_dat(Z80_GET_DATA(pins));
                break;
            default:
                cout << "LCD: ignoring IO write to port $" << to_hex(ioAddr) << endl;
                break;
        }
    }
    return pins;
}
