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
using std::shared_ptr;
using std::unique_ptr;
using std::make_unique;
using std::make_shared;

//static
uint64_t ZED80::z80TickCallback(int numTicks, uint64_t pins, void *userData) {
    return static_cast<ZED80 *>(userData)->tickCallback(numTicks, pins);
}

ZED80::ZED80()
{
    auto romData = make_unique<vector<uint8_t>>(ROM_SIZE);
    _ramData = make_unique<vector<uint8_t>>(RAM_SIZE);
    _sysRegDevice = make_shared<SysRegDevice>();
    _mmu = make_shared<MMU>(std::move(romData), std::move(_ramData), _sysRegDevice);
    _iommu = make_unique<IOMMU>();
    _joySegDevice = make_shared<JoySegDevice>();
    _iommu->setDevice(0, _joySegDevice);
    _iommu->setDevice(1, _joySegDevice);
    _iommu->setDevice(6, _mmu);
    _iommu->setDevice(7, _sysRegDevice);
    // TODO: iommu->setDevice(2, sioDevice);
    // TODO: iommu->setDevice(3, pioDevice);
    // TODO: iommu->setDevice(4, ctcDevice);

    _mmu->describe(cout);
    _iommu->describe(cout);

    z80_desc_t desc;
    desc.tick_cb = z80TickCallback;
    desc.user_data = this;
    
    z80_init(&_cpu, &desc);
}

void ZED80::setRom(unique_ptr<vector<uint8_t>> &&rom) {
    _mmu->setRom(std::move(rom));
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
        break;
    }
}

void ZED80::smallRun(uint32_t ms) {
    uint32_t ticks = uint32_t(uint64_t(ms)*CLOCK_HZ/1000);

    ticks = z80_exec(&_cpu, ticks);
//    cout << "CPU: ran for " << ticks << " ticks" << endl;
}
