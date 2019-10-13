//
//  ViewController.m
//  gui
//
//  Created by Lawrence Kesteloot on 4/29/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#include <mach/mach_time.h>
#include <fstream>
#include "zed-80.h"

#import "ViewController.h"
#import "SevenSegmentView.h"
#import "AppDelegate.h"

using std::cout;
using std::cerr;
using std::endl;
using std::unique_ptr;
using std::make_unique;
using std::make_shared;
using std::array;
using std::vector;
using std::string;
using std::ifstream;

static constexpr NSTimeInterval EMULATION_SLICE = 0.010;    // 10ms emulation quantum

static uint64_t nanosSinceBoot() {
    uint64_t ticksSinceBoot = mach_absolute_time();     // this clock stops when machine sleeps

    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return ticksSinceBoot * timebase.numer / timebase.denom;
}

// Return the pathname without the extension ("file.x" becomes "file").
// If the pathname does not have an extension, it is returned unchanged.
static string stripExtension(string const &pathname) {
    auto slash = pathname.rfind('/');
    auto dot = pathname.rfind('.');
    if (dot == pathname.npos || (slash != pathname.npos && dot < slash)) {
        // No extension.
        return pathname;
    }

    return pathname.substr(0, dot);
}

// The modification date of the file, or nil on error.
static NSDate *modificationDateOfFile(string const &fileName) {
    NSString *nsFileName = [NSString stringWithUTF8String:fileName.c_str()];

    NSDictionary<NSFileAttributeKey, id> *attrs =
        [[NSFileManager defaultManager] attributesOfItemAtPath:nsFileName
                                                         error:nil];
    if (attrs == nil) {
        return nil;
    }

    return attrs.fileModificationDate;
}

static unique_ptr<vector<uint8_t>> loadFile(string const &fileName) {
    // Make sure the ROM or BIN is up to date.
    NSDate *binDate = modificationDateOfFile(fileName);
    if (binDate == nil) {
        NSLog(@"Warning: Can't get date of %s", fileName.c_str());
    } else {
        string asmFileName = stripExtension(fileName) + ".asm";
        NSDate *asmDate = modificationDateOfFile(asmFileName);
        if (asmDate == nil) {
            NSLog(@"Warning: Can't get date of %s", asmFileName.c_str());
        } else if ([binDate compare:asmDate] == NSOrderedAscending) {
            NSLog(@"Warning: %s is older than its source %s", fileName.c_str(), asmFileName.c_str());
        }
    }

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

@interface ViewController () <ZedViewDelegate>
@end

@implementation ViewController {
    ZED80           _zed80;
    NSTimer *       _emulatorRunTimer;
    uint64_t        _emulatorTimestamp; // last timestamp at which we emulated
    uint64_t        _nanosToEmulate; // number of nanoseconds of real time we still need to emulate
}

- (void)loadView {
    _zedView = [[ZedView alloc] initWithDelegate:self];
    self.view = _zedView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Resize to fit around content.
    NSRect frame = self.view.frame;
    frame.size = _zedView.intrinsicContentSize;
    self.view.frame = frame;

    _zed80.setUiDelegate(self);

    [self loadPrograms];
}

- (void)viewWillLayout {
    [super viewWillLayout];
}

- (void)loadPrograms {
    std::string treeDir;
    if ([NSUserName() isEqualToString:@"lk"]) {
        treeDir = "/Users/lk/mine";
    } else {
        treeDir = "/Users/dcollens/Documents";
    }

//    std::string romPathname = treeDir + "/zed-80/src/zed-80/rom_for_emulator.rom";
    std::string romPathname = treeDir + "/zed-80/src/zed-80/rom_monitor.rom";
//    std::string romPathname = treeDir + "/zed-80/src/zed-80/rom_ram_test.rom";
    auto romData = loadFile(romPathname);
    if (romData == nullptr) {
        NSLog(@"Can't load ROM file \"%s\"", romPathname.c_str());
    } else {
        _zed80.writeMemory(ROM_BASE, romData->size(), *romData);
    }

//    std::string ramPathname = treeDir + "/zed-80/src/zed-80/forth.bin";
    std::string ramPathname = treeDir + "/zed-80/src/zed-80/lcd_basic.bin";
//    std::string ramPathname = treeDir + "/zed-80/src/zed-80/song.bin";
//    std::string ramPathname = treeDir + "/zed-80/src/zed-80/lcd_test.bin";
    auto ramData = loadFile(ramPathname);
    if (ramData == nullptr) {
        NSLog(@"Can't load RAM file \"%s\"", ramPathname.c_str());
    } else {
        _zed80.writeMemory(RAM_BASE, ramData->size(), *ramData);
    }
}

- (void)cancelEmulatorTimer {
    if (_emulatorRunTimer != nil) {
        [_emulatorRunTimer invalidate];
        _emulatorRunTimer = nil;
    }
}

- (void)startEmulator {
    _emulatorTimestamp = nanosSinceBoot();
    _nanosToEmulate = 0;

    auto emulatorBlock = ^(NSTimer * _Nonnull timer) {
        uint64_t now = nanosSinceBoot();
        self->_nanosToEmulate += now - self->_emulatorTimestamp;
        self->_emulatorTimestamp = now;
        
        uint64_t nanosEmulated = self->_zed80.smallRun(self->_nanosToEmulate);
        self->_nanosToEmulate -= nanosEmulated;
    };

    _emulatorRunTimer = [NSTimer scheduledTimerWithTimeInterval:EMULATION_SLICE
                                                        repeats:YES
                                                          block:emulatorBlock];
}

- (void)stopEmulator {
    [self cancelEmulatorTimer];
    _emulatorTimestamp = 0;
    _nanosToEmulate = 0;
}

- (IBAction)emulatorGo:(id)sender {
    [self stopEmulator];
    [self startEmulator];
}

- (IBAction)emulatorStop:(id)sender {
    [self stopEmulator];
}

- (IBAction)emulatorReset:(id)sender {
    _zed80.reset();
}

- (IBAction)emulatorReload:(id)sender {
    [self stopEmulator];
    [self loadPrograms];
    _zed80.reset();
    [self startEmulator];
}

// Magically called via first responder from menu item.
- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    BOOL enabled;

    SEL action = menuItem.action;
    if (action == @selector(emulatorGo:)) {
        enabled = _emulatorRunTimer == nil;
    } else if (action == @selector(emulatorStop:)) {
        enabled = _emulatorRunTimer != nil;
    } else {
        // We can't bubble up (super doesn't implement this method),
        // so return YES as per instructions ("Enabling Menu Items").
        enabled = YES;
    }

    return enabled;
}

// ZedViewDelegate:
- (void)receivedKeyboardScanCode:(uint8_t)scanCode {
    _zed80.receivedKeyboardScanCode(scanCode);
}

@end
