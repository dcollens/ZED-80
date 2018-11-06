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

using std::unique_ptr;
using std::vector;

typedef uint16_t vaddr_t;

constexpr size_t ROM_SIZE = 128 * 1024;
constexpr size_t RAM_SIZE = 128 * 1024;

class MMU {
    // rev8 prototype board maps the first 8KB of ROM into the bottom of the Z80 address space,
    // and then the remaining 56KB of address space maps to the RAM chip at physical addresses
    // 8KB-64KB.
    static constexpr vaddr_t RAM_BASE = 0x2000;
    
    unique_ptr<const vector<uint8_t>>   _rom;
    unique_ptr<vector<uint8_t>>         _ram;
    
public:
    MMU(unique_ptr<const vector<uint8_t>> &&rom, unique_ptr<vector<uint8_t>> &&ram)
    : _rom(std::move(rom)), _ram(std::move(ram))
    {}
    
    void describe(std::ostream &out) const;
    
    vector<uint8_t> const &rom() const { return *_rom; }
    vector<uint8_t> &ram() const { return *_ram; }
    
    uint8_t read(vaddr_t vaddr) const {
        return vaddr < RAM_BASE ? rom()[vaddr] : ram()[vaddr];
    }
    void write(vaddr_t vaddr, uint8_t data) {
        if (vaddr >= RAM_BASE) {
            ram()[vaddr] = data;
        }
    }
};

#endif /* mmu_hpp */
