//
//  zed-80.hpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef zed_80_hpp
#define zed_80_hpp

#import "ViewController.h"

#include "mmu.hpp"
#include "iommu.hpp"
#include "z80.h"
#include "io_joyseg.hpp"
#include "io_lcdpanel.h"

using std::unique_ptr;

class ZED80 {
    static constexpr uint64_t   CLOCK_HZ = 10000000;
    
    unique_ptr<vector<uint8_t>> _ramData;
    unique_ptr<vector<uint8_t>> _romData;
    shared_ptr<SysRegDevice>    _sysRegDevice;
    shared_ptr<JoySegDevice>    _joySegDevice;
    shared_ptr<LcdPanelDevice>  _lcdPanelDevice;
    shared_ptr<MMU>             _mmu;
    unique_ptr<IOMMU>           _iommu;
    z80_t                       _cpu;
    ViewController *            _uiDelegate;

    static uint64_t z80TickCallback(int numTicks, uint64_t pins, void *userData);

    uint64_t tickCallback(int numTicks, uint64_t pins);
    
public:
    ZED80();
    
    void writeMemory(paddr_t address, size_t length, vector<uint8_t> const &data) {
        _mmu->writeMemory(address, length, data);
    }
    
    void setUiDelegate(ViewController *uiDelegate);

    void run();
    void smallRun(uint64_t ms);
};

#endif /* zed_80_hpp */
