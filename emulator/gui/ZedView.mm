//
//  ZedView.m
//  gui
//
//  Created by Lawrence Kesteloot on 5/17/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import <array>

#import "ZedView.h"
#import "SevenSegmentView.h"
#import "KeycodeMap.h"

// The "device dependent" modifier flags don't seem to be defined anywhere that I can see, so
// we define them here from experimentation.
static constexpr uint32_t MODFLAG_LSHIFT = 0x0002;
static constexpr uint32_t MODFLAG_RSHIFT = 0x0004;
static constexpr uint32_t MODFLAG_LCTRL = 0x0001;
static constexpr uint32_t MODFLAG_RCTRL = 0x2000;
static constexpr uint32_t MODFLAG_LALT = 0x0020;
static constexpr uint32_t MODFLAG_RALT = 0x0040;

static constexpr size_t SEVEN_SEGMENT_COUNT = 2;
static constexpr CGFloat V_PADDING = 8;

class Modifier {
    uint32_t        _flag;
    NSNumber *      _pseudoKey;
    
public:
    Modifier(uint32_t flag, NSNumber *pseudoKey) : _flag(flag), _pseudoKey(pseudoKey) {}
    
    uint32_t flag() const { return _flag; }
    NSNumber *pseudoKey() const { return _pseudoKey; }
};

static std::array<Modifier,6> const g_Modifiers = {
    Modifier(MODFLAG_LSHIFT, @1000),
    Modifier(MODFLAG_RSHIFT, @1001),
    Modifier(MODFLAG_LCTRL, @1002),
    Modifier(MODFLAG_RCTRL, @1003),
    Modifier(MODFLAG_LALT, @1004),
    Modifier(MODFLAG_RALT, @1005)
};

@implementation ZedView {
    id<ZedViewDelegate> __weak _delegate;
    
    std::array<SevenSegmentView *,SEVEN_SEGMENT_COUNT> _sevenSegment;
    
    uint32_t _lastModifierFlags;
}

- (instancetype)initWithDelegate:(id<ZedViewDelegate>)delegate {
    self = [super init];

    _delegate = delegate;
    _lastModifierFlags = 0;

    for (int i = 0; i < SEVEN_SEGMENT_COUNT; i++) {
        _sevenSegment[i] = [SevenSegmentView new];
        [self addSubview:_sevenSegment[i]];
    }
    
    _lcdPanelView = [LcdPanelView new];
    [self addSubview:_lcdPanelView];

    return self;
}

- (void)layout {
    [super layout];

    NSRect lcdFrame;
    lcdFrame.origin = NSZeroPoint;
    lcdFrame.size = _lcdPanelView.intrinsicContentSize;
    _lcdPanelView.frame = lcdFrame;

    for (int i = 0; i < SEVEN_SEGMENT_COUNT; i++) {
        NSSize size = _sevenSegment[i].intrinsicContentSize;
        NSRect frame;
        frame.origin = NSMakePoint(i * size.width, lcdFrame.size.height + V_PADDING);
        frame.size = size;

        _sevenSegment[i].frame = frame;
    }
}

- (BOOL)acceptsFirstResponder {
    // So we can get key events.
    return YES;
}

- (void)keyDown:(NSEvent *)event {
    NSArray *codes = g_KeyPressScanCodes[[NSNumber numberWithInteger:event.keyCode]];
    if (codes == nil) {
        NSLog(@"Warning: No scan codes for key code %d", event.keyCode);
    } else {
        [self submitScanCodes:codes];
    }
}

- (void)keyUp:(NSEvent *)event {
    NSArray *codes = g_KeyReleaseScanCodes[[NSNumber numberWithInteger:event.keyCode]];
    if (codes == nil) {
        NSLog(@"Warning: No scan codes for key code %d", event.keyCode);
    } else {
        [self submitScanCodes:codes];
    }
}

- (void)flagsChanged:(NSEvent *)event {
    auto modifierFlags = event.modifierFlags;
    auto modifierChanges = modifierFlags ^ _lastModifierFlags;
    
    for (auto const &mod : g_Modifiers) {
        auto const flag = mod.flag();
        if ((modifierChanges & flag) == 0) continue;
        
        NSDictionary<NSNumber *,NSArray<NSNumber *> *> *scanCodeMap;
        if ((modifierFlags & flag) == 0) {
            scanCodeMap = g_KeyReleaseScanCodes;
        } else {
            scanCodeMap = g_KeyPressScanCodes;
        }
        [self submitScanCodes:scanCodeMap[mod.pseudoKey()]];
    }
    _lastModifierFlags = uint32_t(modifierFlags);
}

- (NSSize)intrinsicContentSize {
    return NSMakeSize(_lcdPanelView.intrinsicContentSize.width,
                      _lcdPanelView.intrinsicContentSize.height
                      + V_PADDING
                      + _sevenSegment[0].intrinsicContentSize.height);
}

- (void)setSevenSegment:(uint8_t)port to:(uint8_t)value {
    if (port >= SEVEN_SEGMENT_COUNT) {
        NSLog(@"Invalid seven segment port %d", int(port));
        return;
    }

    _sevenSegment[port].value = value;
}

- (void)submitScanCodes:(NSArray<NSNumber *> *)codes {
    for (NSNumber *n in codes) {
        [_delegate receivedKeyboardScanCode:n.unsignedCharValue];
    }
}

@end
