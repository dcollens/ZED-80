//
//  mmu.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-26.
//  Copyright © 2018 The Head. All rights reserved.
//

#include "mmu.hpp"
#include "strutils.hpp"

using std::endl;

void MMU::describe(std::ostream &out) const {
    out << "MMU: mapped ROM at $0000, RAM at $" << to_hex(RAM_BASE) << endl;
}
