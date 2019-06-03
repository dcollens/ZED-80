//
//  io_sio.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-06-02.
//  Copyright © 2019 The Head. All rights reserved.
//

#ifndef io_sio_h
#define io_sio_h

#include <array>

#include "iodevice.h"

class SioDevice : public IoDevice {
    static constexpr int NUM_PORTS = 2;
    
    static constexpr int NUM_WR = 8;
    static constexpr int NUM_RR = 3;
    
    class SioPort {
        std::array<uint8_t,NUM_WR>  _wreg;
        std::array<uint8_t,NUM_RR>  _rreg;
        
        uint64_t processIoRead(uint64_t pins);
        uint64_t processIoWrite(uint64_t pins);

    public:
        SioPort() {
            reset();
        }
        
        // Called to process an IORQ operation to this port.
        uint64_t processIorq(uint64_t pins);
        
        void reset();
    };
    
    std::array<SioPort,NUM_PORTS>   _ports;
    
public:
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

    void reset();
};

#endif /* io_sio_h */
