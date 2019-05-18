//
//  ZedView.h
//  gui
//
//  Created by Lawrence Kesteloot on 5/17/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LcdPanelView.h"

NS_ASSUME_NONNULL_BEGIN

// Top-level view for emulator window.
@interface ZedView : NSView

@property (nonatomic,readonly) LcdPanelView *lcdPanelView;

- (void)setSevenSegment:(uint8_t)port to:(uint8_t)value;

@end

NS_ASSUME_NONNULL_END
