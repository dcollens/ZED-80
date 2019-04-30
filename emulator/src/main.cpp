//
//  main.cpp
//  zed-80-emulator
//
//  Created by Daniel Collens on 2018-10-25.
//  Copyright © 2018 The Head. All rights reserved.
//

#include <iostream>
#include <fstream>
#include <vector>

#include "zed-80.hpp"
#include "io_joyseg.hpp"
#include "io_sysreg.hpp"

using std::cout;
using std::cerr;
using std::endl;
using std::unique_ptr;
using std::make_unique;
using std::make_shared;
using std::vector;
using std::string;
using std::ifstream;

static constexpr int EMULATOR_VERSION = 1;

static void usage(string const &exeName) {
    cerr << "Usage: " << exeName << " <rom-image>" << endl;
    cerr << "Where: <rom-image> is a " << (ROM_SIZE / 1024) << "KiB raw binary ROM image" << endl;
}

static unique_ptr<vector<uint8_t>> loadFile(string const &fileName) {
    ifstream file(fileName, ifstream::in | ifstream::binary);
    if (file.fail()) {
        cerr << "Can't open \"" << fileName << "\" for input" << endl;
        return nullptr;
    }
    
    file.seekg(0, ifstream::end);
    auto fileSize = file.tellg();
    file.seekg(0);
    
    auto data = make_unique<vector<uint8_t>>(fileSize);
    file.read(reinterpret_cast<char *>(data->data()), data->size());
    if (file.fail()) {
        cerr << "Error reading \"" << fileName << "\"" << endl;
        return nullptr;
    }
    return data;
}

int main(int argc, const char *argv[]) {
    if (argc != 2) {
        usage(argv[0]);
        return EXIT_FAILURE;
    }
    
    auto romData = loadFile(argv[1]);
    if (romData == nullptr) {
        return EXIT_FAILURE;
    }
    if (romData->size() > ROM_SIZE) {
        cerr << "Warning: ROM image in \"" << argv[1] << "\" is too long at "
             << romData->size() << " bytes; truncating to " << ROM_SIZE << " bytes" << endl;
        romData->resize(ROM_SIZE);
    } else if (romData->size() < ROM_SIZE) {
        cerr << "Warning: ROM image in \"" << argv[1] << "\" is too short at "
             << romData->size() << " bytes; padding with zeroes to " << ROM_SIZE << " bytes"
             << endl;
        romData->resize(ROM_SIZE);
    }
    
    cout << "ZED-80 Emulator v" << EMULATOR_VERSION << " starting" << endl;
    
    ZED80 zed80;
    zed80.setRom(std::move(romData));

    zed80.run();
    
    return EXIT_SUCCESS;
}
