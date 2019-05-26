//
//  zed-80.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef zed_80_h
#define zed_80_h

#import "ViewController.h"

#include "mmu.h"
#include "iommu.h"
#include "z80.h"
#include "io_joyseg.h"
#include "io_lcdpanel.h"
#include "io_keyboard.h"
#include "io_ctc.h"
#include "io_pio.h"
#include "audiodevice.h"

using std::unique_ptr;

class ZED80 {
    static constexpr uint32_t   CPU_CLOCK_HZ = 10000000;    // 10MHz
    
    static constexpr uint32_t   AUDIO_CLOCK_DIVISOR = 5;    // 2MHz audio clock
    
    shared_ptr<SysRegDevice>    _sysRegDevice;
    shared_ptr<JoySegDevice>    _joySegDevice;
    shared_ptr<PioDevice>       _pioDevice;
    shared_ptr<CtcDevice>       _ctcDevice;
    shared_ptr<LcdPanelDevice>  _lcdPanelDevice;
    shared_ptr<KeyboardDevice>  _keyboardDevice;
    AudioDevice                 _audioDevice;
    shared_ptr<MMU>             _mmu;
    unique_ptr<IOMMU>           _iommu;
    z80_t                       _cpu;

    ViewController *            _uiDelegate;

    bool                        _recordPinHistory;
    std::deque<uint64_t>        _pinHistory;

    static uint64_t z80TickCallback(int numTicks, uint64_t pins, void *userData);

    uint64_t tickCallback(int numTicks, uint64_t pins);

    void dumpPinHistory();

public:
    ZED80();
    
    void writeMemory(paddr_t address, size_t length, vector<uint8_t> const &data) {
        _mmu->writeMemory(address, length, data);
    }
    
    void setUiDelegate(ViewController *uiDelegate);

    void receivedKeyboardScanCode(uint8_t scanCode);

    void run();
    void smallRun(uint64_t ms);
    void reset();
};

#endif /* zed_80_h */
