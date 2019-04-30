//
//  mmu.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "mmu.hpp"
#include "strutils.hpp"
#include "z80.h"

void MMU::describe(std::ostream &out) const {
    out << "MMU: mapped ROM at $0000, RAM at $" << to_hex(RAM_BASE) << endl;
}
    
uint64_t MMU::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;

    if ((pins & Z80_RD) != 0) {
        cout << "MMU: ignoring IO read from port $" << to_hex(ioAddr) << endl;
    } else if ((pins & Z80_WR) != 0) {
        uint8_t physPage = ioAddr & 0x03;
        _map[physPage] = Z80_GET_DATA(pins) & 0x0F;
    }

    return pins;
}

