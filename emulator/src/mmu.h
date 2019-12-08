//
//  mmu.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#ifndef mmu_h
#define mmu_h

#include <memory>
#include <array>
#include <vector>
#include "iodevice.h"
#include "strutils.h"
#include "io_sysreg.h"

using std::unique_ptr;
using std::shared_ptr;
using std::array;
using std::vector;
using std::endl;
using std::cout;

typedef uint16_t vaddr_t;
typedef uint32_t paddr_t;

constexpr size_t ROM_SIZE = 128 * 1024;
constexpr size_t RAM_SIZE = 128 * 1024;
constexpr paddr_t ROM_BASE = 0;
constexpr paddr_t RAM_BASE = ROM_BASE + ROM_SIZE;

constexpr size_t MMU_PAGE_SHIFT = 14;                       // 16 KiB pages.
constexpr size_t MMU_PAGE_SIZE = 1 << MMU_PAGE_SHIFT;
constexpr vaddr_t PAGE_OFFSET_MASK = MMU_PAGE_SIZE - 1;     // mask bits for offset into page
constexpr size_t VIRT_SIZE = 64 * 1024;                  // Addressable space.
constexpr size_t VIRT_PAGE_COUNT = VIRT_SIZE >> MMU_PAGE_SHIFT;

class MMU : public IoDevice {
    static constexpr uint8_t UNINITIALIZED = 0xFF;
    
    typedef array<uint8_t, ROM_SIZE> Rom;
    typedef array<uint8_t, RAM_SIZE> Ram;
    
    Rom                                 _rom;
    Ram                                 _ram;
    shared_ptr<SysRegDevice>            _sysReg;

    // Map from virtual page number to physical page number.
    uint8_t                             _map[VIRT_PAGE_COUNT];
    
public:
    MMU(shared_ptr<SysRegDevice> sysReg) : _sysReg(sysReg) {
        _rom.fill(0);
        _ram.fill(0);
        for (int i = 0; i < VIRT_PAGE_COUNT; i++) {
            _map[i] = UNINITIALIZED;
        }
    }

    void writeMemory(paddr_t address, size_t length, vector<uint8_t> const &data);

    Rom const &rom() const { return _rom; }
    Ram &ram() { return _ram; }
    
    uint8_t read(vaddr_t vaddr) const {
        paddr_t paddr = virtToPhys(vaddr);
        return paddr < RAM_BASE ? _rom[paddr] : _ram[paddr - RAM_BASE];
    }
    void write(vaddr_t vaddr, uint8_t data) {
        paddr_t paddr = virtToPhys(vaddr);
        if (paddr >= RAM_BASE) {
            _ram[paddr - RAM_BASE] = data;
        } else {
            cout << "Warning: Write $" << to_hex(data) << " to ROM at $"
                << to_hex(paddr) << " (virtual $" << to_hex(vaddr) << ")" << endl;
        }
    }

    // Print a brief message describing this device.
    virtual void describe(std::ostream &out) const override;
    
    // Called at each step of the main CPU emulation.
    virtual uint64_t tickCallback(int numTicks, uint64_t pins) override;

private:
    // Convert virtual address to physical address.
    paddr_t virtToPhys(vaddr_t vaddr) const {
        if (isEnabled()) {
            uint8_t mapped = _map[vaddr >> MMU_PAGE_SHIFT];
            if (mapped == UNINITIALIZED) {
                cout << "Warning: MMU is enabled but not initialized" << endl;
            }
            return (paddr_t(mapped) << MMU_PAGE_SHIFT) | (vaddr & PAGE_OFFSET_MASK);
        } else {
            // Pass-through when disabled.
            return vaddr;
        }
    }

    // Whether the MMU is enabled by the system register.
    bool isEnabled() const {
        return _sysReg->value().isMmuEnabled();
    }
};

#endif /* mmu_h */
