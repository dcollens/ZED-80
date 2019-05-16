//
//  io_lcdpanel.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-05-16.

#ifndef io_lcdpanel_h
#define io_lcdpanel_h

#import "ViewController.h"

#include "iodevice.h"
#include "ra8876.h"

class LcdPanelDevice : public IoDevice {
    RA8876 _ra8876;
    ViewController *_uiDelegate;
    
public:
    LcdPanelDevice() : _uiDelegate(nil) {}
    
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins);

    void setUiDelegate(ViewController *uiDelegate) {
        _uiDelegate = uiDelegate;
    }
};

#endif /* io_lcdpanel_h */
