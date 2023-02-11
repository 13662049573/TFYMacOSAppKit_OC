//
//  NSPopover+Hook.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/9.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSPopover+Hook.h"

@implementation NSPopover (Hook)

+ (NSPopover*)create:(NSViewController *)controller {
    NSPopover *popover = NSPopover.new;
    popover.appearance = [[NSAppearance alloc] init];
    popover.behavior = NSPopoverBehaviorTransient;
    popover.contentViewController = controller;
    return popover;
}

- (void)show:(NSView *)view preferredEdge:(NSRectEdge)edge {
    if (self.isShown == YES) {
        [self close];
    }
    [self showRelativeToRect:view.bounds ofView:view preferredEdge:edge];
}

@end
