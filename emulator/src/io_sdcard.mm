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

static constexpr bool DEBUG_LOG = false;

static constexpr uint32_t SECTOR_SIZE = 512;

// Mask of all SYSREG bits that are relevant to the SD card device.
static constexpr uint8_t SYSREG_SDMASK = Sysreg_t::SYS_SDCLK
                                       | Sysreg_t::SYS_SDCS
                                       | Sysreg_t::SYS_SDICLR
                                       | Sysreg_t::SYS_SDOCLK;

static constexpr uint8_t SD_RESP_IDLE = 0x01;
//static constexpr uint8_t SD_RESP_ERASE_RESET = 0x02;
static constexpr uint8_t SD_RESP_ILLEGAL_COMMAND = 0x04;
//static constexpr uint8_t SD_RESP_CRC_ERROR = 0x08;
//static constexpr uint8_t SD_RESP_SEQUENCE_ERROR = 0x10;
//static constexpr uint8_t SD_RESP_ADDRESS_ERROR = 0x20;
//static constexpr uint8_t SD_RESP_PARAMETER_ERROR = 0x40;

// Print a brief message describing this device.
void SdcardDevice::describe(std::ostream &out) const {
    out << "SDcard";
}

// Called at each step of the main CPU emulation.
uint64_t SdcardDevice::tickCallback(int numTicks, uint64_t pins) {
    //uint8_t ioAddr = Z80_GET_ADDR(pins) & 0xFF;
    if ((pins & Z80_RD) != 0) {
        Z80_SET_DATA(pins, _srIn);
        if (DEBUG_LOG) {
            cout << "SdcardDevice: reading " << to_hex(_srIn) << endl;
        }
    } else if ((pins & Z80_WR) != 0) {
        _srOut = Z80_GET_DATA(pins);
        if (DEBUG_LOG) {
            cout << "SdcardDevice: writing " << to_hex(_srOut) << endl;
        }
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
    // Check whether SDCS is active before doing anything.
    if (sysreg.getSdCs()) {
        // SDCS is inactive (it's active low).
        if (DEBUG_LOG) {
            cout << "SdcardDevice::handleSdClkChange (ignored): " << sysreg.getSdClk() << endl;
        }
        return;
    }
    
    // We only take action on the rising edge of SDCLK.
    if (!sysreg.getSdClk()) {
        return;
    }
    
    // Latch MSB of output register.
    bool bit = _srOut & 0x80;
    _inQueue = (_inQueue << 1) | bit;
    _inQueueBitCount += 1;
    if (DEBUG_LOG) {
        cout << "SdcardDevice::handleSdClkChange latched bit " << bit << ", queue is " << to_hex(_inQueue) << ", size " << _inQueueBitCount << endl;
    }
    
    bool outBit;
    if (_outQueue.empty()) {
        // Send out 0xFF if we don't know what to do.
        outBit = true;
    } else {
        outBit = (_outQueue.front() >> (_outQueueBitCount - 1)) & 0x01;
        _outQueueBitCount -= 1;
        if (_outQueueBitCount == 0) {
            _outQueue.pop();
            _outQueueBitCount = 8;
        }
    }
    _srIn = (_srIn << 1) | outBit;

    if (_inQueueBitCount == 8 && _writeState != WRITE_STATE_NONE) {
        // Handle state machine for writing a sector.
        uint8_t byte = _inQueue & 0xFF;
        _inQueueBitCount = 0;
        if (DEBUG_LOG) {
            cout << "SdcardDevice: Got write byte " << to_hex(byte) << " with " << _writeBytesLeft << " left, state " << _writeState << "." << endl;
        }
        switch (_writeState) {
            case WRITE_STATE_NONE:
                // Can't happen.
                assert(false);
                break;

            case WRITE_STATE_WAITING_FOR_FE:
                if (byte == 0xFE) {
                    _writeState = WRITE_STATE_WAITING_FOR_DATA_BYTE;
                }
                break;
                
            case WRITE_STATE_WAITING_FOR_DATA_BYTE:
                assert(_writeBytesLeft > 0);
                _data[_writeAddress] = byte;
                _writeAddress += 1;
                _writeBytesLeft -= 1;
                if (_writeBytesLeft == 0) {
                    if (_sectorWriter != nullptr) {
                        _sectorWriter->writeSector(_writeAddress - SECTOR_SIZE, &_data[_writeAddress - SECTOR_SIZE], SECTOR_SIZE);
                    }
                    _writeState = WRITE_STATE_WAITING_FOR_CRC1;
                }
                break;

            case WRITE_STATE_WAITING_FOR_CRC1:
                // Ignore CRC.
                _writeState = WRITE_STATE_WAITING_FOR_CRC2;
                break;

            case WRITE_STATE_WAITING_FOR_CRC2:
                // Ignore CRC.
                sendResponseByte(0x05); // Signal success.
                _writeState = WRITE_STATE_NONE;
                break;
        }
    } else if (_inQueueBitCount == 8 && (_inQueue & 0xFF) == 0xFF) {
        // We were sent just 0xFF, it's polling.
        _inQueueBitCount = 0;
    } else if (_inQueueBitCount == 8*6) {
        // Got a full command.
        uint8_t cmd = (_inQueue >> (8*5)) & 0xFF;
        if ((cmd & 0x40) != 0) {
            cmd &= ~0x40;
            if (DEBUG_LOG) {
                cout << "SdcardDevice: Got command " << to_hex(cmd) << endl;
            }
            _inQueueBitCount = 0;
            
            switch (cmd) {
                case 0:
                    // Reset.
                    sendResponseByte(SD_RESP_IDLE);
                    break;
                    
                case 8:
                    // Check version.
                    if (DEBUG_LOG) {
                        cout << "SdcardDevice: Got version " << to_hex(uint32_t(_inQueue >> 8)) << endl;
                    }
                    sendResponseByte(SD_RESP_IDLE);
                    sendResponseByte(0x00);
                    sendResponseByte(0x00);
                    sendResponseByte(0x01);
                    sendResponseByte(0xAA);
                    break;
                    
                case 17: {
                    // Read sector.
                    uint32_t lba = uint32_t(_inQueue >> 8);
                    if (DEBUG_LOG) {
                        cout << "SdcardDevice: Got CMD17 (read) for sector " << to_hex(lba) << endl;
                    }
                    sendResponseByte(0x00); // Not idle.
                    sendResponseByte(0xFE); // Data token.
                    for (int i = 0; i < SECTOR_SIZE; i++) {
                        sendResponseByte(_data[lba*SECTOR_SIZE + i]);
                    }
                    sendResponseByte(0x00); // CRC 1
                    sendResponseByte(0x00); // CRC 2
                    break;
                }
                    
                case 24: {
                    // Write sector.
                    uint32_t lba = uint32_t(_inQueue >> 8);
                    if (DEBUG_LOG) {
                        cout << "SdcardDevice: Got CMD24 (write) for sector " << to_hex(lba) << endl;
                    }
                    sendResponseByte(0x00); // Successfully got command.
                    sendResponseByte(0xFF); // Ready to receive bytes.
                    // We'll receive:
                    //     0xFF to poll for 0x00 status response.
                    //     0xFF to poll for 0xFF ready.
                    //     0xFE for data token.
                    //     SECTOR_SIZE bytes of data.
                    //     0xFF for CRC 1.
                    //     0xFF for CRC 2.
                    //     0xFF to poll for status result.
                    _writeState = WRITE_STATE_WAITING_FOR_FE;
                    _writeAddress = lba*SECTOR_SIZE;
                    _writeBytesLeft = SECTOR_SIZE;
                    break;
                }
                    
                case 41:
                    if (DEBUG_LOG) {
                        cout << "SdcardDevice: Got CMD41 " << to_hex(uint32_t(_inQueue >> 8)) << endl;
                    }
                    // No longer idle.
                    sendResponseByte(0x00);
                    break;
                    
                case 55:
                    if (DEBUG_LOG) {
                        cout << "SdcardDevice: Got CMD55 " << to_hex(uint32_t(_inQueue >> 8)) << endl;
                    }
                    sendResponseByte(SD_RESP_IDLE);
                    break;
                    
                case 58:
                    // Block vs. byte address.
                    if (DEBUG_LOG) {
                        cout << "SdcardDevice: Got CMD58 " << to_hex(uint32_t(_inQueue >> 8)) << endl;
                    }
                    sendResponseByte(0x00);
                    sendResponseByte(0x40); // Block addressed.
                    sendResponseByte(0x00);
                    sendResponseByte(0x00);
                    sendResponseByte(0x00);
                    break;
                    
                default:
                    cout << "SdcardDevice: Got unknown command " << int(cmd) << endl;
                    sendResponseByte(SD_RESP_IDLE | SD_RESP_ILLEGAL_COMMAND);
                    break;
            }
        } else {
            cout << "SdcardDevice: Got unknown byte " << to_hex(cmd) << endl;
        }
    }
}

void SdcardDevice::handleSdCsChange(Sysreg_t sysreg) {
    // TODO: not yet implemented
    if (DEBUG_LOG) {
        cout << "SdcardDevice::handleSdCsChange: " << sysreg.getSdCs() << endl;
    }
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

void SdcardDevice::updateSdcardState() {
    _joySegDevice->setSdcardCardDetect(!_data.empty());
    _joySegDevice->setSdcardWriteProtect(_sectorWriter == nullptr);
}

void SdcardDevice::sendResponseByte(uint8_t b) {
    if (_outQueue.empty()) {
        // Starting a new byte.
        _outQueueBitCount = 8;
    }
    _outQueue.push(b);
}
