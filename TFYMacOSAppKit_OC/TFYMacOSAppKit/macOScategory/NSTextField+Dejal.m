//
//  NSTextField+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSTextField+Dejal.h"
#import "NSView+Dejal.h"
#import "NSWindow+Dejal.h"
#import <objc/message.h>

@implementation NSTextField (Dejal)

/**
 如果字段的字符串值非空，即非nil和非@""则返回YES。
*/

- (BOOL)tfy_containsSomething
{
    return ([[self stringValue] length] > 0);
}

/**
 执行设置带有冒号后缀的提示符标签的常见任务。
*/

- (void)tfy_setPromptLabel:(NSString *)label
{
    if ([label length])
    {
        if (![label hasSuffix:@":"])
            label = [label stringByAppendingString:@":"];
        
        [self setStringValue:label];
    }
}

/**
 执行设置字段值的常见任务，确保该值不是nil。
*/

- (void)tfy_setFieldValue:(NSString *)value
{
    if (value)
        [self setStringValue:value];
    else
        [self setStringValue:@""];
}

/**
 使用从滑块开始的范围验证字段值，并根据需要将接收器或滑块设置为该值。返回值。所有这些都可以通过绑定来完成，但这也可以，并且在Mac OS X 10.2中也可以工作。
*/

- (NSInteger)tfy_syncronizeWithIntegerSlider:(NSSlider *)slider usingFieldValue:(BOOL)isUsingField
{
    NSInteger max = [slider maxValue];
    NSInteger value = 0;
    
    if (isUsingField)
    {
        value = [self integerValue];
        
        if (max > 1000)
            value *= 60;
    }
    else
        value = [slider integerValue];
    
    if (value < [slider minValue] || value > [slider maxValue])
    {
        isUsingField = NO;
        value = [slider integerValue];
    }
    
    if (isUsingField)
        [slider setIntegerValue:value];
    else
    {
        NSInteger temp = value;
        
        if (max > 1000)
            temp /= 60;
        
        [self setIntegerValue:temp];
    }
    
    return value;
}

/**
 如果字段内容当前不适合它的框架，该方法将调整包含该字段的窗口和字段本身的大小，使其适合。窗口和字段仅垂直调整大小。此更改不需要或不影响自动调整大小的spring和struts。窗口的大小只会增加，而不会减少。如果需要调整大小则返回YES，如果已经足够大则返回NO。
*/

- (BOOL)tfy_resizeWindowVerticallyToFit;
{
    NSRect oldFrame = [self frame];
    NSRect newFrame = oldFrame;
    
    // Determine the ideal height for the field:
    newFrame.size.height = 10000.0;
    newFrame.size = [[self cell] cellSizeForBounds:newFrame];
    
    // If no change, or the new height would be smaller, do nothing:
    if (NSHeight(newFrame) <= NSHeight(oldFrame))
        return NO;
    
    // We need to resize, so adjust the autoresize masks:
    NSArray *masks = [self tfy_adjustAutoresizeMasks];
    
    // Resize the window based on the new text field frame size:
    [[self window] tfy_setFrameSoView:self hasSize:newFrame.size centerHorizontalPostion:NO];
    
    // Tidy up:
    [self tfy_restoreAutoresizeMasks:masks];
    
    return YES;
}

- (void)setTfy_placeholderStringColor:(NSColor *)tfy_placeholderStringColor {
    objc_setAssociatedObject(self, @selector(tfy_placeholderStringColor), tfy_placeholderStringColor, OBJC_ASSOCIATION_COPY);
    [self msSetPlaceholder:self.placeholderString color:tfy_placeholderStringColor];
}

- (NSColor *)tfy_placeholderStringColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)msSetPlaceholder:(NSString *)placeholder color:(NSColor*)color{
    NSFont *font = self.font;
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font,
                           NSFontAttributeName,
                           color,
                           NSForegroundColorAttributeName,
                           nil];
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:placeholder?:@"" attributes:attrs];
    [self setPlaceholderAttributedString:attributedString];
}


@end

