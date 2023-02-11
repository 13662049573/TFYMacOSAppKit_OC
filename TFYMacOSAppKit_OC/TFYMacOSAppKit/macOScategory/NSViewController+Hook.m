//
//  NSViewController+Hook.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSViewController+Hook.h"
#import "NSObject+Dejal.h"

@implementation NSViewController (Hook)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self tfy_exchangeInstanceMethod:self.class method1Sel:@selector(loadView) method2Sel:@selector(hook_loadView)];
        });
    }
}

- (void)hook_loadView {
    NSWindow *window = NSApplication.sharedApplication.mainWindow;
    self.view = [[NSView alloc]initWithFrame:window.frame];
}

@end
