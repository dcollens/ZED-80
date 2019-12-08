//
//  io_sysreg.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-11-05.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef io_sysreg
#define io_sysreg

#include "iodevice.h"

struct Sysreg_t {
    static constexpr uint8_t RESET_STATE   = 0x00; // Value after hardware reset.
    
    static constexpr uint8_t SYS_MMUEN     = 0x01; // MMU enable
    static constexpr uint8_t SYS_SDCLK     = 0x02; // SD card input register & card clock
    static constexpr uint8_t SYS_SDCS      = 0x04; // SD card chip select (active low)
    static constexpr uint8_t SYS_SDICLR    = 0x08; // SD card input register clear (active low)
    static constexpr uint8_t SYS_SDOCLK    = 0x10; // SD card output register clock
    static constexpr uint8_t SYS_BDIR      = 0x20; // Audio chip BDIR line (bus direction)
    static constexpr uint8_t SYS_BC1       = 0x40; // Audio chip BC1 line (bus control 1)
    static constexpr uint8_t SYS_RESERVED  = 0x80; // Reserved for future use

    uint8_t _value;
    
    Sysreg_t() : _value(RESET_STATE) {}
    Sysreg_t(uint8_t value) : _value(value) {}
    
    void reset() { _value = RESET_STATE; }
    uint8_t get() const { return _value; }
    void set(uint8_t value) { _value = value; }
    
    // MMU enable
    bool isMmuEnabled() const {
        return (_value & SYS_MMUEN) != 0;
    }

    // SD card input register & card clock
    bool getSdClk() const {
        return (_value & SYS_SDCLK) != 0;
    }

    // SD card chip select (active low)
    bool getSdCs() const {
        return (_value & SYS_SDCS) != 0;
    }

    // SD card input register clear (active low)
    bool getSdIClr() const {
        return (_value & SYS_SDICLR) != 0;
    }

    // SD card output register clock
    bool getSdOClk() const {
        return (_value & SYS_SDOCLK) != 0;
    }

    // Audio chip BDIR line (bus direction)
    bool getBDir() const {
        return (_value & SYS_BDIR) != 0;
    }

    // Audio chip BC1 line (bus control 1)
    bool getBC1() const {
        return (_value & SYS_BC1) != 0;
    }
};

class SysRegDevice : public IoDevice {
    Sysreg_t _value;

public:
    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

    // Reset to boot-up state.
    void reset() {
        _value.reset();
    }
    
    Sysreg_t value() const { return _value; }
};

#endif /* io_sysreg */
