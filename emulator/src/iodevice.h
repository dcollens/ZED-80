//
//  iodevice.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef iodevice_h
#define iodevice_h

#include <iostream>

class IoDevice {
public:
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const = 0;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) = 0;
};

#endif /* iodevice_h */
