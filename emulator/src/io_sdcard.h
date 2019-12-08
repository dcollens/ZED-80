//
//  io_sdcard.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-12-07.
//

#ifndef io_sdcard_h
#define io_sdcard_h

#include "iodevice.h"
#include "io_sysreg.h"

class SdcardDevice : public IoDevice {
    Sysreg_t    _lastSysreg;
    
    uint8_t     _srIn;          // input shift register
    uint8_t     _srOut;         // output shift register
    
    void handleSdClkChange(Sysreg_t sysreg);
    void handleSdCsChange(Sysreg_t sysreg);
    void handleSdIClrChange(Sysreg_t sysreg);
    void handleSdOClkChange(Sysreg_t sysreg);

public:
    SdcardDevice() : _srIn(0), _srOut(0) {}
    
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

    // Called when the SD-related signals in SysReg may have changed, so we may need to simulate
    // some action on the shift registers or SD card state machine.
    void checkSysreg(Sysreg_t sysreg);
};

#endif /* io_sdcard_h */
