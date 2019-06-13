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

// Converts a 64-bit pin word to a string. Move this somewhere.
std::string pins_to_str(uint64_t pins) {
    return std::string()
        + ((pins & Z80_RETI) != 0 ? "RETI " : "---- ")
        + ((pins & Z80_IEIO) != 0 ? "IEIO " : "---- ")
        + ((pins & Z80_WAIT2) != 0 ? "2" : "-")
        + ((pins & Z80_WAIT1) != 0 ? "1" : "-")
        + ((pins & Z80_WAIT0) != 0 ? "0 " : "- ")
        + ((pins & Z80_BUSACK) != 0 ? "BA " : "-- ")
        + ((pins & Z80_BUSREQ) != 0 ? "BQ " : "-- ")
        + ((pins & Z80_NMI) != 0 ? "NMI " : "--- ")
        + ((pins & Z80_INT) != 0 ? "INT " : "--- ")
        // Skip HALT.
        + ((pins & Z80_WR) != 0 ? "WR " : "-- ")
        + ((pins & Z80_RD) != 0 ? "RD " : "-- ")
        + ((pins & Z80_IORQ) != 0 ? "IORQ " : "---- ")
        + ((pins & Z80_MREQ) != 0 ? "MREQ " : "---- ")
        + ((pins & Z80_M1) != 0 ? "M1 " : "-- ")
        + to_hex(uint8_t(Z80_GET_DATA(pins)))
        + " "
        + to_hex(uint16_t(Z80_GET_ADDR(pins)));
}

//static
uint64_t ZED80::z80TickCallback(int numTicks, uint64_t pins, void *userData) {
    return static_cast<ZED80 *>(userData)->tickCallback(numTicks, pins);
}

ZED80::ZED80()
: _audioDevice(CPU_CLOCK_HZ, AUDIO_CLOCK_DIVISOR), _uiDelegate(nil), _recordPinHistory(false)
{
    _sysRegDevice = make_shared<SysRegDevice>();
    _mmu = make_shared<MMU>(_sysRegDevice);
    _iommu = make_unique<IOMMU>();
    _joySegDevice = make_shared<JoySegDevice>();
    _keyboardDevice = make_shared<KeyboardDevice>();
    _sioDevice = make_shared<SioDevice>();
    _pioDevice = make_shared<PioDevice>(_keyboardDevice);
    _ctcDevice = make_shared<CtcDevice>();
    _lcdPanelDevice = make_shared<LcdPanelDevice>();
    _iommu->setDevice(0, _joySegDevice);
    _iommu->setDevice(1, _joySegDevice);
    _iommu->setDevice(2, _sioDevice);
    _iommu->setDevice(3, _pioDevice);
    _iommu->setDevice(4, _ctcDevice);
    _iommu->setDevice(5, _lcdPanelDevice);
    _iommu->setDevice(6, _mmu);
    _iommu->setDevice(7, _sysRegDevice);
    // TODO: iommu->setDevice(8, sdcardDevice);
    _iommu->setDevice(9, _keyboardDevice);

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

void ZED80::receivedKeyboardScanCode(uint8_t scanCode) {
    _keyboardDevice->receivedScanCode(scanCode);
}

void ZED80::dumpPinHistory() {
    cout << "Pin history:" << endl;
    for (auto pins : _pinHistory) {
        cout << "    " << pins_to_str(pins) << endl;
    }
}

uint64_t ZED80::tickCallback(int numTicks, uint64_t pins) {
    if (_recordPinHistory) {
        _pinHistory.emplace_back(pins);
        while (_pinHistory.size() > 16) {
            _pinHistory.pop_front();
        }
    }

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
            if (addr < 0x4000) {
                // Catch ROM writes. XXX temporary for debugging, remove.
                dumpPinHistory();
            }
            _mmu->write(addr, Z80_GET_DATA(pins));
        }
    } else if ((pins & Z80_IORQ) != 0 && (pins & (Z80_RD|Z80_WR)) != 0) {
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

uint64_t ZED80::smallRun(uint64_t nanos) {
    uint32_t ticks = uint32_t(nanos * CPU_CLOCK_HZ / NANOS_PER_SECOND);

    ticks = z80_exec(&_cpu, ticks);
    return ticks * NANOS_PER_SECOND / CPU_CLOCK_HZ;
}

void ZED80::reset() {
    _audioDevice.reset();
    _sysRegDevice->reset();
    _joySegDevice->reset();
    _sioDevice->reset();
    _pioDevice->reset();
    _ctcDevice->reset();
    _lcdPanelDevice->reset();
    _keyboardDevice->reset();
    z80_reset(&_cpu);
}
