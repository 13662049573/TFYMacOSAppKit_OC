//
//  NSView+TFY_Tools.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "NSView+TFY_Tools.h"
#import <objc/runtime.h>
#import "NSObject+Dejal.h"
#import <time.h>

@interface NSView ()
@property(nonatomic,strong)dispatch_source_t timer;
@property(nonatomic,assign)NSInteger userTime;
@property(nonatomic,assign)NSInteger stopTime;
@end

static NSInteger const TimeInterval = 60; // 默认时间
static NSString * const ButtonTitleFormat = @"剩余%ld秒";
static NSString * const RetainTitle = @"重新获取";

@implementation NSView (TFY_Tools)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self tfy_exchangeInstanceMethod:self.class method1Sel:@selector(initWithFrame:) method2Sel:@selector(initWithFrame_hook:)];
        [self tfy_exchangeInstanceMethod:self.class method1Sel:@selector(init) method2Sel:@selector(init_hook)];
        [self tfy_exchangeInstanceMethod:self.class method1Sel:@selector(initWithCoder:) method2Sel:@selector(initWithCoder_hook:)];
    });
}

- (id)initWithFrame_hook:(NSRect)frameRect {
    self = [self initWithFrame_hook:frameRect];
    if (self) {
        self.wantsLayer = true;
    }
    return self;
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

- (CGPoint)macos_origin {
    return self.frame.origin;
}

- (void)setMacos_origin:(CGPoint)macos_origin {
    CGRect frame = self.frame;
    frame.origin = macos_origin;
    self.frame = frame;
}

- (CGFloat)macos_x {
    return self.frame.origin.x;
}

- (void)setMacos_x:(CGFloat)macos_x {
    CGRect frame = self.frame;
    frame.origin.x = macos_x;
    self.frame = frame;
}

- (CGFloat)macos_y {
    return self.frame.origin.y;
}

- (void)setMacos_y:(CGFloat)macos_y {
    CGRect frame = self.frame;
    frame.origin.y = macos_y;
    self.frame = frame;
}

- (CGSize)macos_size {
    return self.frame.size;
}

- (void)setMacos_size:(CGSize)macos_size {
    CGRect frame = self.frame;
    frame.size = macos_size;
    self.frame = frame;
}

- (CGFloat)macos_width {
    return self.frame.size.width;
}

- (void)setMacos_width:(CGFloat)macos_width {
    CGRect frame = self.frame;
    frame.size.width = macos_width;
    self.frame = frame;
}

- (CGFloat)macos_height {
    return self.frame.size.height;
}

- (void)setMacos_height:(CGFloat)macos_height {
    CGRect frame = self.frame;
    frame.size.height = macos_height;
    self.frame = frame;
}

- (CGFloat)macos_top {
    return self.frame.origin.y;
}

- (void)setMacos_top:(CGFloat)macos_top {
    CGRect frame = self.frame;
    frame.origin.y = macos_top;
    self.frame = frame;
}

- (CGFloat)macos_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMacos_bottom:(CGFloat)macos_bottom {
    CGRect frame = self.frame;
    frame.origin.y = macos_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)macos_left {
    return self.frame.origin.x;
}

- (void)setMacos_left:(CGFloat)macos_left {
    CGRect frame = self.frame;
    frame.origin.x = macos_left;
    self.frame = frame;
}

- (CGFloat)macos_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMacos_right:(CGFloat)macos_right {
    CGRect frame = self.frame;
    frame.origin.x = macos_right - self.frame.size.width;
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

- (BOOL)isFlipped {
    return YES;
}

- (void)setTfy_time:(NSInteger)tfy_time{
    objc_setAssociatedObject(self, @selector(tfy_time), @(tfy_time), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)tfy_time {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return  number.integerValue;
}

- (void)setTfy_format:(NSString *)tfy_format {
    objc_setAssociatedObject(self, @selector(tfy_format), tfy_format, OBJC_ASSOCIATION_COPY);
}

- (NSString *)tfy_format {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN);
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setUserTime:(NSInteger)userTime {
    objc_setAssociatedObject(self, @selector(userTime), @(userTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)userTime {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return  number.integerValue;
}

- (void)setStopTime:(NSInteger)stopTime {
    objc_setAssociatedObject(self, @selector(stopTime), @(stopTime), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)stopTime {
    NSNumber *number = objc_getAssociatedObject(self, @selector(stopTime));
    return  number.integerValue;
}

- (void)tfy_startTimer:(void (^)(NSString *time,NSInteger type))block {
    if (self.stopTime == 0) {
        if (!self.tfy_time) {
            self.tfy_time = TimeInterval;
        }
        if (!self.tfy_format) {
            self.tfy_format = ButtonTitleFormat;
        }
        dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            if (self.tfy_time <= 1) {
                dispatch_source_cancel(self.timer);
            }else
            {
                self.tfy_time --;
                dispatch_async(mainQueue, ^{
                    self.stopTime = 1;
                    block([NSString stringWithFormat:self.tfy_format,self.tfy_time],0);
                });
            }
        });
        dispatch_source_set_cancel_handler(self.timer, ^{
            dispatch_async(mainQueue, ^{
                self.stopTime = 0;
                block(RetainTitle,1);
                if (self.userTime) {
                    self.tfy_time = self.userTime;
                } else
                {
                    self.tfy_time = TimeInterval;
                }
            });
        });
        dispatch_resume(self.timer);
    }
}

- (void)tfy_endTimer {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

@end
