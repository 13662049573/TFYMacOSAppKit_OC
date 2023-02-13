//
//  NSViewController+Hook.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "NSViewController+Hook.h"
#import <objc/message.h>

@implementation NSViewController (Hook)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self exchangeInstanceMethod:self.class method1Sel:@selector(loadView) method2Sel:@selector(hook_loadView)];
        });
    }
}

- (void)hook_loadView {
    NSWindow *window = NSApplication.sharedApplication.mainWindow;
    self.view = [[NSView alloc]initWithFrame:window.frame];
}

@end

@implementation NSView (Hook)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self exchangeInstanceMethod:self.class method1Sel:@selector(isFinished) method2Sel:@selector(hook_isFinished)];
        });
    }
}

- (BOOL)hook_isFinished {
    return YES;
}

@end

@implementation NSObject (Hook)

+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
