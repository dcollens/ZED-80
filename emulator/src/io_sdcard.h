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
public:
    // Interface for writing a sector.
    class SectorWriter {
    public:
        // Write the "count" bytes at "data" to the SD card at byte address "address".
        virtual void writeSector(uint32_t address, uint8_t *data, int count) = 0;
    };

private:
    // State machine for writing a sector.
    enum WriteState {
        WRITE_STATE_NONE,
        WRITE_STATE_WAITING_FOR_FE,
        WRITE_STATE_WAITING_FOR_DATA_BYTE,
        WRITE_STATE_WAITING_FOR_CRC1,
        WRITE_STATE_WAITING_FOR_CRC2,
    };
    
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
    // State when writing a sector.
    WriteState  _writeState;
    // Byte address (within _data) of next byte to write.
    uint32_t    _writeAddress;
    // Number of bytes left to write.
    uint32_t    _writeBytesLeft;
    // Delegate for writing sectors.
    shared_ptr<SectorWriter> _sectorWriter;
    
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
      _inQueueBitCount(0), _outQueueBitCount(0),
      _writeState(WRITE_STATE_NONE), _writeAddress(0), _writeBytesLeft(0)
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
    // Pass a null sectorWriter to mean that the card is write-protected.
    void setData(const vector<uint8_t> &data, shared_ptr<SectorWriter> sectorWriter) {
        _data = data;
        _sectorWriter = sectorWriter;

        updateSdcardState();
    }
};

#endif /* io_sdcard_h */
