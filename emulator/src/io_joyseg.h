//
//  io_joyseg.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef io_joyseg_h
#define io_joyseg_h

#import "ViewController.h"

#include "iodevice.h"

class JoySegDevice : public IoDevice {
    ViewController *_uiDelegate;

public:
    JoySegDevice() : _uiDelegate(nil) {}

    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

    void setUiDelegate(ViewController *uiDelegate) {
        _uiDelegate = uiDelegate;
    }
};

#endif /* io_joyseg_h */
