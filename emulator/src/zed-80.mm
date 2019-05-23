//
//  zed-80.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#include <iostream>

#include "zed-80.h"
#include "strutils.h"

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

ZED80::ZED80() : _audioDevice(CPU_CLOCK_HZ, AUDIO_CLOCK_DIVISOR), _uiDelegate(nil) {
    _sysRegDevice = make_shared<SysRegDevice>();
    _mmu = make_shared<MMU>(_sysRegDevice);
    _iommu = make_unique<IOMMU>();
    _joySegDevice = make_shared<JoySegDevice>();
    _pioDevice = make_shared<PioDevice>();
    _ctcDevice = make_shared<CtcDevice>();
    _lcdPanelDevice = make_shared<LcdPanelDevice>();
    _iommu->setDevice(0, _joySegDevice);
    _iommu->setDevice(1, _joySegDevice);
    // TODO: _iommu->setDevice(2, _sioDevice);
    _iommu->setDevice(3, _pioDevice);
    _iommu->setDevice(4, _ctcDevice);
    _iommu->setDevice(5, _lcdPanelDevice);
    _iommu->setDevice(6, _mmu);
    _iommu->setDevice(7, _sysRegDevice);
    // TODO: iommu->setDevice(8, sdcardDevice);
    // TODO: iommu->setDevice(9, kbdDevice);

    cout << "Z80: " << (CPU_CLOCK_HZ / 1000000) << "MHz clock" << endl;
    _iommu->describe(cout);
    _audioDevice.describe(cout);
    cout << endl;

    z80_desc_t cpuDesc;
    cpuDesc.tick_cb = z80TickCallback;
    cpuDesc.user_data = this;
    z80_init(&_cpu, &cpuDesc);
}

void ZED80::setUiDelegate(ViewController *uiDelegate) {
    _uiDelegate = uiDelegate;
    _joySegDevice->setUiDelegate(uiDelegate);
    _lcdPanelDevice->setUiDelegate(uiDelegate);
}

uint64_t ZED80::tickCallback(int numTicks, uint64_t pins) {
    CtcDevice &ctcDevice = *_ctcDevice;
    PioDevice &pioDevice = *_pioDevice;
    
    // First, tick the cycle-accurate devices once for each elapsed tick.
    for (int i = 0; i < numTicks; ++i) {
        pins = ctcDevice.singleTickCallback(pins);
    }
    _audioDevice.tickCallback(numTicks);
    
    // Next, decode any active memory or IO request.
    vaddr_t const addr = Z80_GET_ADDR(pins);
    if ((pins & Z80_MREQ) != 0) {
        if ((pins & Z80_RD) != 0) {
            Z80_SET_DATA(pins, _mmu->read(addr));
        } else if ((pins & Z80_WR) != 0) {
            _mmu->write(addr, Z80_GET_DATA(pins));
        }
    } else if ((pins & Z80_IORQ) != 0) {
        pins = _iommu->tickCallback(numTicks, pins);
        // If the BC1/BDIR pins have changed since the last simulator step, run an IO cycle
        // on the audio chip.
        _audioDevice.checkIorq(*_sysRegDevice, pioDevice);
    }
    
    // Finally, handle the interrupt chain.
    Z80_DAISYCHAIN_BEGIN(pins)
    {
        // The IEI/IEO pins on the schematic are wired up so that the device interrupt priority
        // order is (highest priority to lowest): SIO, PIO, CTC.
        
        // TODO: SIO interrupt processing
        pins = pioDevice.interruptDaisyChain(pins);
        pins = ctcDevice.interruptDaisyChain(pins);
    }
    Z80_DAISYCHAIN_END(pins);
    
    // Make sure we mask off any lingering pseudo-pins from peripheral devices.
    return pins & Z80_PIN_MASK;
}

void ZED80::run() {
    for (;;) {
        constexpr int TICKS_PER_LOOP = 100000000;
        
        auto numTicks = z80_exec(&_cpu, TICKS_PER_LOOP);
        cout << "CPU: ran for " << numTicks << " ticks" << endl;
        break;
    }
}

void ZED80::smallRun(uint64_t ms) {
    uint32_t ticks = uint32_t(ms * CPU_CLOCK_HZ / 1000);

    ticks = z80_exec(&_cpu, ticks);
//    cout << "CPU: ran for " << ticks << " ticks" << endl;
}
