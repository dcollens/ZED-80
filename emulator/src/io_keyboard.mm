//
//  io_keyboard.mm
//  gui
//
//  Created by Lawrence Kesteloot on 5/23/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#include "io_keyboard.h"
#include "strutils.h"
#include "z80.h"

using std::cout;
using std::endl;

// Print a brief message describing this device.
void KeyboardDevice::describe(std::ostream &out) const {
    out << "Keyboard";
}

// Called at each step of the main CPU emulation.
uint64_t KeyboardDevice::tickCallback(int numTicks, uint64_t pins) {
    if ((pins & Z80_RD) != 0) {
        uint8_t scanCode = _scanCodeQueue.empty() ? 0 : _scanCodeQueue.front();
        // Invert bits, we're getting ~KDAT.
        Z80_SET_DATA(pins, ~scanCode);
    }
    return pins;
}

void KeyboardDevice::receivedScanCode(uint8_t scanCode) {
    _scanCodeQueue.push(scanCode);
}

void KeyboardDevice::setShiftRegisterClear(bool clear) {
    if (clear && !_shiftRegisterClear && !_scanCodeQueue.empty()) {
        _scanCodeQueue.pop();
    }

    _shiftRegisterClear = clear;
}

void KeyboardDevice::reset() {
    // Nothing.
}
