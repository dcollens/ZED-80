//
//  io_ctc.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-22.
//Copyright © 2019 The Head. All rights reserved.
//

#include "io_ctc.h"

using std::cout;
using std::endl;

CtcDevice::CtcDevice() : _ctc_pins(0) {
    z80ctc_init(&_z80ctc);
}

// Print a brief message describing this device.
void CtcDevice::describe(std::ostream &out) const {
    out << "Z84C30 CTC";
}

// Called at each step of the main CPU emulation.
uint64_t CtcDevice::tickCallback(int numTicks, uint64_t pins) {
    pins |= Z80CTC_CE;
    if ((pins & Z80_A0) != 0) {
        pins |= Z80CTC_CS0;
    }
    if ((pins & Z80_A1) != 0) {
        pins |= Z80CTC_CS1;
    }
    pins = z80ctc_iorq(&_z80ctc, pins);
    // Make sure to turn off the CTC's pseudo-pins before returning to the main simulation loop.
    pins &= Z80_PIN_MASK;
    return pins;
}

void CtcDevice::reset() {
    _ctc_pins = 0;
    z80ctc_reset(&_z80ctc);
}
