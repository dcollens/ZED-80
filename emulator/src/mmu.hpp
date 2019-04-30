//
//  mmu.hpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef mmu_hpp
#define mmu_hpp

#include <memory>
#include <vector>
#include "iodevice.h"
#include "strutils.hpp"
#include "io_sysreg.hpp"

using std::unique_ptr;
using std::shared_ptr;
using std::vector;
using std::endl;
using std::cout;

typedef uint16_t vaddr_t;
typedef uint32_t paddr_t;

constexpr size_t ROM_SIZE = 128 * 1024;
constexpr size_t RAM_SIZE = 128 * 1024;
constexpr size_t PAGE_SHIFT = 14;                       // 16 KiB pages.
constexpr size_t PAGE_SIZE = 1 << PAGE_SHIFT;
constexpr size_t PHYS_SIZE = 64 * 1024;                  // Addressable space.
constexpr size_t PHYS_PAGE_COUNT = PHYS_SIZE >> PAGE_SHIFT;

class MMU : public IoDevice {
    static constexpr uint8_t UNINITIALIZED = 0xFF;
    static constexpr paddr_t RAM_BASE = 8 * PAGE_SIZE;
    
    unique_ptr<const vector<uint8_t>>   _rom;
    unique_ptr<vector<uint8_t>>         _ram;
    shared_ptr<SysRegDevice>            _sysReg;

    // Map from virtual page number to physical page number.
    uint8_t                             _map[PHYS_PAGE_COUNT];
    
public:
    MMU(unique_ptr<const vector<uint8_t>> &&rom, unique_ptr<vector<uint8_t>> &&ram,
            shared_ptr<SysRegDevice> sysReg)
    : _rom(std::move(rom)), _ram(std::move(ram)), _sysReg(sysReg)
    {
        for (int i = 0; i < PHYS_PAGE_COUNT; i++) {
            _map[i] = UNINITIALIZED;
        }
    }
    
    vector<uint8_t> const &rom() const { return *_rom; }
    vector<uint8_t> &ram() const { return *_ram; }
    
    uint8_t read(vaddr_t vaddr) const {
        paddr_t paddr = virtToPhys(vaddr);
        return paddr < RAM_BASE ? rom()[paddr] : ram()[paddr - RAM_BASE];
    }
    void write(vaddr_t vaddr, uint8_t data) {
        paddr_t paddr = virtToPhys(vaddr);
        if (paddr >= RAM_BASE) {
            ram()[paddr - RAM_BASE] = data;
        } else {
            cout << "Warning: Write $" << to_hex(data) << " to ROM at $"
                << to_hex(paddr) << " (virtual $" << to_hex(vaddr) << ")" << endl;
        }
    }

    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins);

private:
    // Convert virtual address to physical address.
    paddr_t virtToPhys(vaddr_t vaddr) const {
        if (isEnabled()) {
            uint8_t mapped = _map[vaddr >> PAGE_SHIFT];
            if (mapped == UNINITIALIZED) {
                cout << "Warning: MMU is enabled but not initialized" << endl;
            }
            return paddr_t(mapped) << PAGE_SHIFT;
        } else {
            // Pass-through when disabled.
            return vaddr;
        }
    }

    // Whether the MMU is enabled by the system register.
    bool isEnabled() const {
        return _sysReg->isMmuEnabled();
    }
};

#endif /* mmu_hpp */
