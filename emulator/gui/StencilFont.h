//
//  StencilFont.h
//  zed-80-emulator
//
//  Created by Daniel Collens on 2020-12-15.
//  Copyright © 2020 The Head. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StencilFont : NSObject

@property (nonatomic, readonly) size_t glyphWidth;
@property (nonatomic, readonly) size_t glyphHeight;

@property (nonatomic, readonly) size_t stride;

- (instancetype)initWithFont:(NSFont *)font;

- (uint16_t const *)bitmapDataForGlyph:(uint8_t)glyph;

@end
