//
//  io_sio.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2019-06-02.
//  Copyright © 2019 The Head. All rights reserved.
//

#include "io_sio.h"
#include "strutils.h"
#include "z80.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
// Command values for WR0.
static constexpr uint8_t SIO_CMD_NOP = 0;           // no command
static constexpr uint8_t SIO_CMD_SND_ABRT = 1;      // send abort (SDLC only)
static constexpr uint8_t SIO_CMD_RST_EXTINT = 2;    // reset external/status interrupts
static constexpr uint8_t SIO_CMD_RST_CHAN = 3;      // reset channel
static constexpr uint8_t SIO_CMD_INTENA_NXTRX = 4;  // enable interrupt on next receive character
static constexpr uint8_t SIO_CMD_RST_TXINTPND = 5;  // reset TX interrupt pending
static constexpr uint8_t SIO_CMD_RST_ERR = 6;       // reset error latches
static constexpr uint8_t SIO_CMD_INTRETN = 7;       // return from interrupt (not needed with Z80)

// RR0 status bits (mostly normal operation)
static constexpr uint8_t SIORR0_RCA = 0x01;         // RX character available
static constexpr uint8_t SIORR0_INTPND = 0x02;      // interrupt pending (channel A only)
static constexpr uint8_t SIORR0_TBE = 0x04;         // TX buffer empty
static constexpr uint8_t SIORR0_DCD = 0x08;         // latched DCD input bit
static constexpr uint8_t SIORR0_SYNC = 0x10;        // latched SYNC input bit (hunt in SDLC)
static constexpr uint8_t SIORR0_CTS = 0x20;         // latched CTS input bit
static constexpr uint8_t SIORR0_TX_UNDR = 0x40;     // TX underrun / end of message
static constexpr uint8_t SIORR0_BRK_ABRT = 0x80;    // break/abort detected
#pragma clang diagnostic pop

using std::cout;
using std::endl;

uint64_t SioDevice::SioPort::processIoRead(uint64_t pins) {
    bool isCtrl = (pins & Z80_A1) != 0;
    if (isCtrl) {
        // Read from control port.
        int regNum = _wreg.at(0) & 0x07;
        _wreg.at(0) &= ~0x07;
        if (regNum < NUM_RR) {
            Z80_SET_DATA(pins, _rreg.at(regNum));
        } else {
            cout << "SIO: ignoring attempt to read from illegal register number " << regNum << endl;
        }
    } else {
        // Read data from serial port. Currently unsupported, so we just return a NUL.
        Z80_SET_DATA(pins, 0);
    }
    return pins;
}

uint64_t SioDevice::SioPort::processIoWrite(uint64_t pins) {
    uint8_t data = Z80_GET_DATA(pins);
    bool isCtrl = (pins & Z80_A1) != 0;
    if (isCtrl) {
        // Write to control port.
        int regNum = _wreg.at(0) & 0x07;
        _wreg.at(0) &= ~0x07;
        _wreg.at(regNum) = data;
        
        if (regNum == 0) {
            int cmd = (data >> 3) & 0x07;
            switch (cmd) {
                case SIO_CMD_NOP:
                    break;
                case SIO_CMD_SND_ABRT:
                    cout << "SIO: send abort not implemented" << endl;
                    break;
                case SIO_CMD_RST_EXTINT:
                    cout << "SIO: reset external/status interrupts not implemented" << endl;
                    break;
                case SIO_CMD_RST_CHAN:
                    reset();
                    break;
                case SIO_CMD_INTENA_NXTRX:
                    cout << "SIO: enable interrupt on next RX character not implemented" << endl;
                    break;
                case SIO_CMD_RST_TXINTPND:
                    cout << "SIO: reset TX interrupt pending not implemented" << endl;
                    break;
                case SIO_CMD_RST_ERR:
                    cout << "SIO: reset error latches not implemented" << endl;
                    break;
                case SIO_CMD_INTRETN:
                    cout << "SIO: return from interrupt not implemented" << endl;
                    break;
                default:
                    break;
            }
        }
    } else {
        // Write data to serial port. We model an infinitely fast TX channel.
        cout << char(data);
    }
    return pins;
}

uint64_t SioDevice::SioPort::processIorq(uint64_t pins) {
    if ((pins & Z80_RD) != 0) {
        pins = processIoRead(pins);
    } else if ((pins & Z80_WR) != 0) {
        pins = processIoWrite(pins);
    }
    return pins;
}

void SioDevice::SioPort::reset() {
    _wreg.fill(0);
    _rreg.fill(0);
    
    _rreg.at(0) |= SIORR0_TBE | SIORR0_DCD | SIORR0_CTS;
}

// Print a brief message describing this device.
void SioDevice::describe(std::ostream &out) const {
    out << "Z84C40 SIO";
}

// Called at each step of the main CPU emulation.
uint64_t SioDevice::tickCallback(int numTicks, uint64_t pins) {
    uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    int portNum = ioAddr & 0x01;
    pins = _ports.at(portNum).processIorq(pins);
    return pins;
}

void SioDevice::reset() {
    for (auto &port : _ports) {
        port.reset();
    }
}
