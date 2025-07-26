//
//  NSToolbarCategories.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import "NSToolbar+Dejal.h"


@implementation NSToolbar (Dejal)

+ (CGFloat)tfy_toolbarHeightForWindow:(NSWindow *)window
{
    NSToolbar *toolbar = [window toolbar];
    CGFloat toolbarHeight = 0.0;
    NSRect windowFrame;

    if(toolbar && [toolbar isVisible])
    {
        windowFrame = [NSWindow contentRectForFrameRect:[window frame] styleMask:[window styleMask]];
        toolbarHeight = NSHeight(windowFrame) - NSHeight([[window contentView] frame]);
    }

    return toolbarHeight;
}

- (NSUInteger)tfy_indexOfFirstToolbarItemWithIdentifier:(NSString *)identifier;
{
    return [self.items indexOfObjectPassingTest:^BOOL(NSToolbarItem *item, NSUInteger idx, BOOL *stop)
            {
                return [item.itemIdentifier isEqualToString:identifier];
            }];
}

@end

