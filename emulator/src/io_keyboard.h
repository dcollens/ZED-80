//
//  io_keyboard.h
//  gui
//
//  Created by Lawrence Kesteloot on 5/23/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#ifndef io_keyboard_h
#define io_keyboard_h

#include <queue>

#include "iodevice.h"
#include "io_pio.h"

using std::shared_ptr;

class KeyboardDevice : public IoDevice {
    shared_ptr<PioDevice>   _pioDevice;
    std::queue<uint8_t>     _scanCodeQueue;
    bool                    _shiftRegisterClear;

    // Set the shift register's start bit (active high).
    void setShiftRegisterStart(bool start);
    
public:
    KeyboardDevice(shared_ptr<PioDevice> pioDevice)
    : _pioDevice(pioDevice), _shiftRegisterClear(false)
    {}

    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;

    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

    // UI received this scan code, queue it up.
    void receivedScanCode(uint8_t scanCode);

    // Whether a scan code is available in the queue.
    bool isScanCodeAvailable() const { return !_scanCodeQueue.empty(); }

    // Set the shift register's clear bit (active high).
    void setShiftRegisterClear(bool clear);

    void reset();
};

#endif /* io_keyboard_h */
