//
//  io_ctc.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-22.
//Copyright © 2019 The Head. All rights reserved.
//

#ifndef io_ctc_h
#define io_ctc_h

#include "iodevice.h"
#include "z80.h"
#include "z80ctc.h"

class CtcDevice : public IoDevice {
    z80ctc_t            _z80ctc;
    uint64_t            _ctc_pins;
    
public:
    CtcDevice();
    
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;
    
    // The CTC device needs to simulate every single CPU clock tick, unlike most of our IO devices,
    // so it has this extra callback that gets called once for every tick (regardless of CPU pin
    // decoding, etc.)
    // Don't decode the IORQ|(RD,WR) operations here -- those will be presented in the normal
    // tickCallback() function above by the IOMMU.
    inline uint64_t singleTickCallback(uint64_t pins) {
        // This is where you set the CLKTRG0..3 input pins (e.g. for external clock sources).
        // Our schematic wires ZCTO2 to CLKTRG3, so set CLKTRG3 based on last-simulated value
        // for ZCTO2:
        if ((_ctc_pins & Z80CTC_ZCTO2) != 0) {
            pins |= Z80CTC_CLKTRG3;
        }
        // CLKTRG0..2 are wired to the 1.8432MHz crystal, which we currently only use for baud
        // rate generation, so we don't simulate that here.
        
        // Simulate one tick of the CTC.
        pins = z80ctc_tick(&_z80ctc, pins);
        
        // This is where you read the ZCTO0..3 output pins to see what counters hit zero, etc.
        // Save the ZCTOn pins so we can use them on the next tick (as the input to CLKTRG3, e.g.)
        _ctc_pins = pins;
        
        // We have to mask off the CTC's pseudo-pins before returning to the main simulation.
        return pins & Z80_PIN_MASK;
    }
    
    // Called inside a special interrupt daisy-chain processing phase to determine which device
    // in the chain, if any, is permitted to assert the Z80's INT pin, and to do so if that device
    // has a pending interrupt condition. Also handles placing interrupt vector on the bus for
    // interrupt mode 2, and decoding end of interrupt condition (signaled via the Z80 simulator's
    // Z80_RETI pseudo-pin).
    inline uint64_t interruptDaisyChain(uint64_t pins) {
        return z80ctc_int(&_z80ctc, pins);
    }
};

#endif /* io_joyseg_h */
