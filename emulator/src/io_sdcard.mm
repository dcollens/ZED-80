//
//  io_sdcard.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-12-07.
//

#import "io_sdcard.h"
#include "strutils.h"
#include "z80.h"

using std::cout;
using std::endl;

// Mask of all SYSREG bits that are relevant to the SD card device.
static constexpr uint8_t SYSREG_SDMASK = Sysreg_t::SYS_SDCLK
                                       | Sysreg_t::SYS_SDCS
                                       | Sysreg_t::SYS_SDICLR
                                       | Sysreg_t::SYS_SDOCLK;

// Print a brief message describing this device.
void SdcardDevice::describe(std::ostream &out) const {
    out << "SDcard";
}

// Called at each step of the main CPU emulation.
uint64_t SdcardDevice::tickCallback(int numTicks, uint64_t pins) {
    //uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    if ((pins & Z80_RD) != 0) {
        Z80_SET_DATA(pins, _srIn);
    } else if ((pins & Z80_WR) != 0) {
        _srOut = Z80_GET_DATA(pins);
    }
    return pins;
}

// Called when the SD-related signals in SysReg may have changed, so we may need to simulate
// some action on the shift registers or SD card state machine.
void SdcardDevice::checkSysreg(Sysreg_t sysreg) {
    if (((sysreg.get() ^ _lastSysreg.get()) & SYSREG_SDMASK) != 0) {
        if (sysreg.getSdClk() != _lastSysreg.getSdClk()) {
            handleSdClkChange(sysreg);
        }
        if (sysreg.getSdCs() != _lastSysreg.getSdCs()) {
            handleSdCsChange(sysreg);
        }
        if (sysreg.getSdIClr() != _lastSysreg.getSdIClr()) {
            handleSdIClrChange(sysreg);
        }
        if (sysreg.getSdOClk() != _lastSysreg.getSdOClk()) {
            handleSdOClkChange(sysreg);
        }
    }
    _lastSysreg = sysreg;
}

void SdcardDevice::handleSdClkChange(Sysreg_t sysreg) {
    // TODO: not yet implemented
}

void SdcardDevice::handleSdCsChange(Sysreg_t sysreg) {
    // TODO: not yet implemented
}

void SdcardDevice::handleSdIClrChange(Sysreg_t sysreg) {
    if (!sysreg.getSdIClr()) {
        // Clear input shift register, active low.
        _srIn = 0;
    }
}

void SdcardDevice::handleSdOClkChange(Sysreg_t sysreg) {
    if (sysreg.getSdOClk()) {
        // Output shift register clocked on rising edge of SDOCLK.
        _srOut <<= 1;
    }
}
