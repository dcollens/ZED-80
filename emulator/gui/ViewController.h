//
//  ViewController.h
//  gui
//
//  Created by Lawrence Kesteloot on 4/29/19.
//  Copyright © 2019 The Head. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LcdPanelView.h"

@interface ViewController : NSViewController

@property (nonatomic,readonly) LcdPanelView *lcdPanelView;

- (void)setSevenSegment:(uint8_t)port to:(uint8_t)value;

@end

