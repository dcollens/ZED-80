//
//  iommu.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-27.
//  Copyright © 2018 The Head. All rights reserved.
//

#include <iostream>

#include "iommu.hpp"
#include "strutils.hpp"
#include "z80.h"

using std::endl;
using std::cerr;
using std::cout;

void IOMMU::describe(std::ostream &out) const {
    for (uint8_t iorqNum = 0; iorqNum < N_IORQ; ++iorqNum) {
        auto device = _devices[iorqNum];
        if (device == nullptr) continue;
        
        out << "IOMMU: port $" << to_hex(uint8_t(iorqNum << 4)) << " ";
        device->describe(out);
        out << endl;
    }
}

uint64_t IOMMU::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    if (ioAddr < 128) {
        // '138 IO decoder selected.
        uint8_t iorqNum = ioAddr >> 4;
        auto device = _devices[iorqNum];
        if (device == nullptr) {
            cout << "IORQ: ignoring request for IO device at port $" << to_hex(ioAddr) << endl;
        } else {
            pins = device->tickCallback(numTicks, pins);
        }
    } else {
        cerr << "IORQ: ignoring request for IO device at port $" << to_hex(ioAddr) << endl;
    }
    return pins;
}
