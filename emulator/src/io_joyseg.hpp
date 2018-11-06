//
//  io_joyseg.hpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef io_joyseg_hpp
#define io_joyseg_hpp

#include "iodevice.h"

class JoySegDevice : public IoDevice {
public:
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins);
};

#endif /* io_joyseg_hpp */
