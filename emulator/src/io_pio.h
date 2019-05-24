//
//  io_pio.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-22.
//  Copyright © 2019 The Head. All rights reserved.
//

#ifndef io_pio_h
#define io_pio_h

#include <array>

#include "iodevice.h"
#include "z80.h"
#include "z80pio.h"
#include "io_keyboard.h"

using std::shared_ptr;

class PioDevice : public IoDevice {
    shared_ptr<KeyboardDevice>              _keyboardDevice;
    z80pio_t                                _z80pio;
    std::array<uint8_t,Z80PIO_NUM_PORTS>    _portInputs;
    std::array<uint8_t,Z80PIO_NUM_PORTS>    _portOutputs;
    
    static uint8_t pioInputCallback(int portId, void *userData);
    static void pioOutputCallback(int portId, uint8_t data, void *userData);

    uint8_t inputCallback(int portId);
    void outputCallback(int portId, uint8_t data);

public:
    PioDevice(shared_ptr<KeyboardDevice> keyboardDevice);
    
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;
    
    // Called inside a special interrupt daisy-chain processing phase to determine which device
    // in the chain, if any, is permitted to assert the Z80's INT pin, and to do so if that device
    // has a pending interrupt condition. Also handles placing interrupt vector on the bus for
    // interrupt mode 2, and decoding end of interrupt condition (signaled via the Z80 simulator's
    // Z80_RETI pseudo-pin).
    inline uint64_t interruptDaisyChain(uint64_t pins) {
        return z80pio_int(&_z80pio, pins);
    }
    
    void setPortInputs(int portId, uint8_t data) { _portInputs.at(portId) = data; }
    uint8_t getPortOutputs(int portId) const { return _portOutputs.at(portId); }

    void reset();
};

#endif /* io_pio_h */
