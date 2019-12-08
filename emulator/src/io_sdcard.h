//
//  io_sdcard.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-12-07.
//

#ifndef io_sdcard_h
#define io_sdcard_h

#include <vector>
#include <queue>

#include "iodevice.h"
#include "io_sysreg.h"
#include "io_joyseg.h"

using std::vector;
using std::queue;
using std::shared_ptr;

class SdcardDevice : public IoDevice {
    shared_ptr<JoySegDevice> _joySegDevice;
    
    Sysreg_t    _lastSysreg;
    
    uint8_t     _srIn;          // input shift register
    uint8_t     _srOut;         // output shift register
    
    uint64_t    _inQueue;
    int         _inQueueBitCount;
    // Queue in the order we want to send out bytes, so first byte will
    // be sent first, MSB first.
    queue<uint8_t> _outQueue;
    // Number of bits left in first byte of _outQueue.
    int         _outQueueBitCount;
    
    vector<uint8_t> _data;
    
    void handleSdClkChange(Sysreg_t sysreg);
    void handleSdCsChange(Sysreg_t sysreg);
    void handleSdIClrChange(Sysreg_t sysreg);
    void handleSdOClkChange(Sysreg_t sysreg);
    
    // Update the state of the SD card hardware after a card has been inserted.
    void updateSdcardState();
    
    void sendResponseByte(uint8_t b);

public:
    SdcardDevice(shared_ptr<JoySegDevice> joySegDevice)
    : _joySegDevice(joySegDevice), _srIn(0), _srOut(0),
      _inQueueBitCount(0), _outQueueBitCount(0)
    {
        updateSdcardState();
    }

    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

    // Called when the SD-related signals in SysReg may have changed, so we may need to simulate
    // some action on the shift registers or SD card state machine.
    void checkSysreg(Sysreg_t sysreg);
    
    // Set the contents of the SD card. Pass an empty vector to mean "no card".
    void setData(const vector<uint8_t> &data) {
        _data = data;
        updateSdcardState();
    }
};

#endif /* io_sdcard_h */
