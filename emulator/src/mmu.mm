//
//  mmu.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "mmu.h"
#include "strutils.h"
#include "z80.h"

void MMU::describe(std::ostream &out) const {
    out << "MMU with ROM at $" << to_hex(ROM_BASE) << ", RAM at $" << to_hex(RAM_BASE);
}

void MMU::writeMemory(paddr_t address, size_t length, vector<uint8_t> const &data) {
    for (paddr_t offset = 0; offset < length; ++offset) {
        paddr_t writeAddress = address + offset;
        if (writeAddress < RAM_BASE) {
            _rom.at(writeAddress) = data.at(offset);
        } else {
            _ram.at(writeAddress - RAM_BASE) = data.at(offset);
        }
    }
}

uint64_t MMU::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;

    if ((pins & Z80_RD) != 0) {
        cout << "MMU: ignoring IO read from port $" << to_hex(ioAddr) << endl;
    } else if ((pins & Z80_WR) != 0) {
        uint8_t physPage = ioAddr & 0x03;
        uint8_t previousPage = _map[physPage];
        uint8_t newPage = Z80_GET_DATA(pins) & 0x0F;
        _map[physPage] = newPage;
        cout << "MMU: updated physical page " << int(physPage)
             << " from address $" << to_hex(previousPage)
             << " to address $" << to_hex(newPage) << " ("
             << (newPage << MMU_PAGE_SHIFT >= RAM_BASE ? "RAM" : "ROM")
             << " page " << (((newPage << MMU_PAGE_SHIFT) % RAM_BASE) >> MMU_PAGE_SHIFT)
             << ")" << endl;
    }

    return pins;
}

