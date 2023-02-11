//
//  NSImage+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSImage+Dejal.h"


@implementation NSImage (Dejal)

- (void)tfy_drawFlippedInRect:(NSRect)rect operation:(NSCompositingOperation)op fraction:(CGFloat)delta
{
    CGContextRef context;

    context = [[NSGraphicsContext currentContext] CGContext];
    CGContextSaveGState(context);

    {
        CGContextTranslateCTM(context, 0, NSMaxY(rect));
        CGContextScaleCTM(context, 1, -1);

        rect.origin.y = 0;
        [self drawInRect:rect fromRect:NSZeroRect operation:op fraction:delta];
    }

    CGContextRestoreGState(context);
}

- (void)tfy_drawFlippedInRect:(NSRect)rect operation:(NSCompositingOperation)op
{
    [self tfy_drawFlippedInRect:rect operation:op fraction:1.0];
}

- (void)tfy_applyBadge:(NSImage *)badge withAlpha:(CGFloat)alpha scale:(CGFloat)scale
{
    if (!badge)
    {
        return;
    }
    
    NSImage *newBadge = [badge copy];
    
    newBadge.size = NSMakeSize(self.size.width * scale, self.size.height * scale);
    
    [self lockFocus];
    
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [newBadge drawAtPoint:NSMakePoint(self.size.width - newBadge.size.width, 0) fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:alpha];
    
    [self unlockFocus];
}

- (NSImage *)tfy_tintedImageWithColor:(NSColor *)tint;
{
    return [self tfy_tintedImageWithColor:tint operation:NSCompositingOperationSourceAtop];
}

- (NSImage *)tfy_tintedImageWithColor:(NSColor *)tint operation:(NSCompositingOperation)operation;
{
    NSSize size = self.size;
    NSRect bounds = NSMakeRect(0.0, 0.0, size.width, size.height);
    NSImage *image = [[NSImage alloc] initWithSize:size];
    
    [image lockFocus];
    [self drawAtPoint:NSZeroPoint fromRect:bounds operation:NSCompositingOperationSourceOver fraction:1.0];
    [tint set];
    NSRectFillUsingOperation(bounds, operation);
    [image unlockFocus];
    
    return image;
}

- (NSData *)tfy_PNGRepresentation;
{
    CGImageRef cgRef = [self CGImageForProposedRect:NULL context:nil hints:nil];
    NSBitmapImageRep *newRep = [[NSBitmapImageRep alloc] initWithCGImage:cgRef];
    
    newRep.size = self.size;
    
    return [newRep representationUsingType:NSBitmapImageFileTypePNG properties:@{}];
}

+(NSImage *)tfy_imageWithColor:(NSColor *)color {
    CGSize size = CGSizeMake(1.0, 1.0);
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
   return image;
}

@end

