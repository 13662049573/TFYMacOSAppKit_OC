//
//  NSPopover+Hook.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/9.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPopover (Hook)

+ (NSPopover*)create:(NSViewController *)controller;

- (void)show:(NSView *)view preferredEdge:(NSRectEdge)edge;

@end

NS_ASSUME_NONNULL_END
