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
    // Turn on SRSTRT
    setShiftRegisterStart(true);
}

void KeyboardDevice::setShiftRegisterStart(bool start) {
    _pioDevice->setPortInputs(Z80PIO_PORT_A, start ? 0x20 : 0x00);
}

void KeyboardDevice::setShiftRegisterClear(bool clear) {
    if (clear && !_shiftRegisterClear && !_scanCodeQueue.empty()) {
        _scanCodeQueue.pop();
        // Turn off SRSTRT
        setShiftRegisterStart(false);
        // If we have a waiting scan byte, we need to drive SRSTRT back high again.
        if (isScanCodeAvailable()) {
            setShiftRegisterStart(true);
        }
    }

    _shiftRegisterClear = clear;
}

void KeyboardDevice::reset() {
    _shiftRegisterClear = false;
}
