//
//  NSImage+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSImage (Dejal)

- (void)tfy_drawFlippedInRect:(NSRect)rect operation:(NSCompositingOperation)op fraction:(CGFloat)delta;

- (void)tfy_drawFlippedInRect:(NSRect)rect operation:(NSCompositingOperation)op;

- (void)tfy_applyBadge:(NSImage*)badge withAlpha:(CGFloat)alpha scale:(CGFloat)scale;

- (NSImage *)tfy_tintedImageWithColor:(NSColor *)tint;
- (NSImage *)tfy_tintedImageWithColor:(NSColor *)tint operation:(NSCompositingOperation)operation;

- (NSData *)tfy_PNGRepresentation;

+(NSImage *)tfy_imageWithColor:(NSColor *)color;
@end

