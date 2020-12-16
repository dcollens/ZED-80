//
//  StencilFont.mm
//  zed-80-emulator
//
//  Created by Daniel Collens on 2020-12-15.
//  Copyright © 2020 The Head. All rights reserved.
//

#import "StencilFont.h"

namespace {

constexpr size_t N_GLYPHS = 256;

} // namespace

@implementation StencilFont {
    NSBitmapImageRep *      _imageRep;
}

- (instancetype)initWithFont:(NSFont *)font {
    self = [super init];
    
    NSRect bounds = font.boundingRectForFont;
    _glyphWidth = bounds.size.width;
    _glyphHeight = bounds.size.height;
    
    size_t imageWidth = N_GLYPHS * _glyphWidth;
    size_t imageHeight = _glyphHeight;
    
    _stride = imageWidth;
    
    _imageRep =
    [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                            pixelsWide:imageWidth
                                            pixelsHigh:imageHeight
                                         bitsPerSample:16
                                       samplesPerPixel:1
                                              hasAlpha:NO
                                              isPlanar:NO
                                        colorSpaceName:NSCalibratedWhiteColorSpace
                                          bitmapFormat:NSBitmapFormatSixteenBitLittleEndian
                                           bytesPerRow:2 * imageWidth
                                          bitsPerPixel:16];
    
    CGContextRef gfx = self.gfxContext.CGContext;
    
    // Black out the image.
    CGContextSetRGBFillColor(gfx, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(gfx, 0, 0, 0, 1);
    CGContextFillRect(gfx, NSMakeRect(0, 0, imageWidth, imageHeight));

    NSDictionary<NSAttributedStringKey, id> *attr = @{
        NSForegroundColorAttributeName: NSColor.whiteColor,
        NSBackgroundColorAttributeName: NSColor.blackColor,
        NSFontAttributeName: font,
    };
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:self.gfxContext];
    for (int ch = 0; ch < N_GLYPHS; ++ch) {
        NSString *text = [NSString stringWithFormat:@"%c", ch];
        
        [text drawAtPoint:NSMakePoint(ch * _glyphWidth, 0) withAttributes:attr];
    }
    [NSGraphicsContext restoreGraphicsState];

#if 0
    uint16_t const *words = [self bitmapDataForGlyph:'A'];
    for (int y = 0; y < _glyphHeight; ++y) {
        for (int x = 0; x < 16 * _glyphWidth; ++x) {
            printf("%c", words[y * imageWidth + x] == 0 ? ' ' : '#');
        }
        printf("\n");
    }
#endif

    return self;
}

- (NSGraphicsContext *)gfxContext {
    // For some reason, hanging onto the NSGraphicsContext between re-draw cycles did not work, so
    // we make a fresh one each time we need it.
    NSGraphicsContext *gfxContext = [NSGraphicsContext graphicsContextWithBitmapImageRep:_imageRep];

    CGContextRef cgContext = gfxContext.CGContext;
    
    // Set up global graphics context parameters.
    CGContextSetAllowsAntialiasing(cgContext, false);
    CGContextSetShouldAntialias(cgContext, false);
    CGContextSetLineWidth(cgContext, 1);

    return gfxContext;
}

- (uint16_t const *)bitmapDataForGlyph:(uint8_t)glyph {
    return reinterpret_cast<uint16_t *>(_imageRep.bitmapData) + glyph * _glyphWidth;
}

@end
