//
//  io_pio.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-22.
//  Copyright © 2019 The Head. All rights reserved.
//

#include "io_pio.h"
#include "strutils.h"

using std::cout;
using std::endl;

//static
uint8_t PioDevice::pioInputCallback(int portId, void *userData) {
    return static_cast<PioDevice *>(userData)->inputCallback(portId);
}

//static
void PioDevice::pioOutputCallback(int portId, uint8_t data, void *userData) {
    static_cast<PioDevice *>(userData)->outputCallback(portId, data);
}

PioDevice::PioDevice(shared_ptr<KeyboardDevice> keyboardDevice)
    : _keyboardDevice(keyboardDevice)
{
    z80pio_desc_t pioDesc;
    pioDesc.in_cb = pioInputCallback;
    pioDesc.out_cb = pioOutputCallback;
    pioDesc.user_data = this;
    
    z80pio_init(&_z80pio, &pioDesc);
    
    _portInputs.fill(0);
    _portOutputs.fill(0);
}

// Print a brief message describing this device.
void PioDevice::describe(std::ostream &out) const {
    out << "Z84C20 PIO";
}

// Called at each step of the main CPU emulation.
uint64_t PioDevice::tickCallback(int numTicks, uint64_t pins) {
    pins |= Z80PIO_CE;
    if ((pins & Z80_A0) != 0) {
        pins |= Z80PIO_BASEL;
    }
    if ((pins & Z80_A1) != 0) {
        pins |= Z80PIO_CDSEL;
    }
    pins = z80pio_iorq(&_z80pio, pins);
    // Make sure to turn off the PIO's pseudo-pins before returning to the main simulation loop.
    pins &= Z80_PIN_MASK;
    return pins;
}

uint8_t PioDevice::inputCallback(int portId) {
    // Emulation of PIO device is requesting current values of the PIO port pins.
    uint8_t value = _portInputs.at(portId);

    if (portId == Z80PIO_PORT_A) {
        // Add keyboard start bit.
        if (_keyboardDevice->isScanCodeAvailable()) {
            value |= 0x20;
        }
    }

    return value;
}

void PioDevice::outputCallback(int portId, uint8_t data) {
    // Emulation of PIO device is updating us about the output state of the PIO port pins.
    if (portId == Z80PIO_PORT_A) {
        _keyboardDevice->setShiftRegisterClear((data & 0x08) == 0);
    }
    _portOutputs.at(portId) = data;
}

void PioDevice::reset() {
    _portInputs.fill(0);
    _portOutputs.fill(0);
    z80pio_reset(&_z80pio);
}
