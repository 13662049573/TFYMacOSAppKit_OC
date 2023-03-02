//
//  NSView+TFY_Tools.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "NSView+TFY_Tools.h"
#import <objc/runtime.h>
#import "NSObject+Dejal.h"

@implementation NSView (TFY_Tools)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self tfy_exchangeInstanceMethod:self.class method1Sel:@selector(init) method2Sel:@selector(init_hook)];
        [self tfy_exchangeInstanceMethod:self.class method1Sel:@selector(initWithCoder:) method2Sel:@selector(initWithCoder_hook:)];
    });
}

- (id)init_hook{
    self = [self init_hook];
    if (self) {
        self.wantsLayer = true;
    }
    return self;
}

- (id)initWithCoder_hook:(NSCoder *)decoder{
    self = [self initWithCoder_hook:decoder];
    if (self) {
        self.wantsLayer = true;
    }
    return self;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (void)tfy_removeAllSubViews{
    while (self.subviews.count > 0) {
        [[self.subviews firstObject] removeFromSuperview];
    }
}

- (NSViewController *)tfy_viewController{
    id nextResponder = [self nextResponder];
    NSView *view = self;
    while (![nextResponder isKindOfClass:[NSViewController class]]) {
        view = view.superview;
        nextResponder = [view nextResponder];
    }
    return nextResponder;
}

- (CGFloat)tfy_visibleAlpha{
    if ([self isKindOfClass:[NSWindow class]]) {
        if (self.hidden) return 0;
        return self.alphaValue;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    NSView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alphaValue;
        v = v.superview;
    }
    return alpha;
}

- (NSData *)tfy_snapshotPDF{
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}



@end
