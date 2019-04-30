//
//  zed-80.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#include <iostream>

#include "zed-80.hpp"
#include "strutils.hpp"

using std::cout;
using std::cerr;
using std::endl;

//static
uint64_t ZED80::z80TickCallback(int numTicks, uint64_t pins, void *userData) {
    return static_cast<ZED80 *>(userData)->tickCallback(numTicks, pins);
}

ZED80::ZED80(shared_ptr<MMU> &mmu, unique_ptr<IOMMU> &&iommu)
: _mmu(mmu), _iommu(std::move(iommu))
{
    z80_desc_t desc;
    desc.tick_cb = z80TickCallback;
    desc.user_data = this;
    
    z80_init(&_cpu, &desc);
}

uint64_t ZED80::tickCallback(int numTicks, uint64_t pins) {
    vaddr_t const addr = Z80_GET_ADDR(pins);
    if ((pins & Z80_MREQ) != 0) {
        if ((pins & Z80_RD) != 0) {
            Z80_SET_DATA(pins, _mmu->read(addr));
        } else if ((pins & Z80_WR) != 0) {
            _mmu->write(addr, Z80_GET_DATA(pins));
        }
    } else if ((pins & Z80_IORQ) != 0) {
        pins = _iommu->tickCallback(numTicks, pins);
    }
    return pins;
}

void ZED80::run() {
    for (;;) {
        constexpr int TICKS_PER_LOOP = 100000000;
        
        auto numTicks = z80_exec(&_cpu, TICKS_PER_LOOP);
        cout << "CPU: ran for " << numTicks << " ticks" << endl;
    }
}
