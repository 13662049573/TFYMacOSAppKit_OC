//
//  NSSplitView+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSSplitView+Dejal.h"
#import <QuartzCore/QuartzCore.h>


@implementation NSSplitView (Dejal)

/**
 为splitPosition键添加一个可动画属性。
*/

+ (id)defaultAnimationForKey:(NSString *)key;
{
    if ([key isEqualToString:@"splitPosition"])
    {
        CAAnimation *animation = [CABasicAnimation animation];
        
        animation.duration = 0.2;
        
        return animation;
    }
    else
        return [super defaultAnimationForKey:key];
}

/**
 返回指定分割分隔符的当前位置。

 idx分隔符，第一个为零。
 @返回分隔符的位置。
 */

- (CGFloat)tfy_splitPositionOfDividerAtIndex:(NSUInteger)idx;
{
    NSRect frame = [[[self subviews] objectAtIndex:idx] frame];
    
    if ([self isVertical])
        return NSMaxX(frame);
    else
        return NSMaxY(frame);
}

/**
 返回第一个分割分隔符的当前位置。
*/

- (CGFloat)tfy_splitPosition;
{
    return [self tfy_splitPositionOfDividerAtIndex:0];
}

/**
 设置第一个分割分隔符的位置。可以通过[[splitView animator] setSplitPosition:position]进行动画。
*/

- (void)tfy_setSplitPosition:(CGFloat)position;
{
    [self setPosition:position ofDividerAtIndex:0];
}

/**
 切换子视图在指定索引处的可见性;假设只使用了两个子视图。
 idx折叠或展开的索引。
 */

- (void)tfy_toggleSubviewAtIndex:(NSUInteger)idx;
{
    BOOL isCollapsed = [self isSubviewCollapsed:[self.subviews objectAtIndex:idx]];
    
    if (isCollapsed)
    {
        [self tfy_expandSubviewAtIndex:idx];
    }
    else
    {
        [self tfy_collapseSubviewAtIndex:idx];
    }
}

/**
 折叠指定索引处的子视图;假设只使用了两个子视图。如果已经崩溃了什么都没有
 idx崩溃索引。
 */

- (void)tfy_collapseSubviewAtIndex:(NSUInteger)idx;
{
    NSUInteger other = idx ? 0 : 1;

    NSView *remaining  = [self.subviews objectAtIndex:other];
    NSView *collapsing = [self.subviews objectAtIndex:idx];
    NSRect remainingFrame = remaining.frame;
    NSRect overallFrame = self.frame;
    
    if (collapsing.hidden)
    {
        return;
    }
    
    collapsing.hidden = YES;
    
    if (self.vertical)
    {
        remaining.frameSize = NSMakeSize(overallFrame.size.width, remainingFrame.size.height);
    }
    else
    {
        remaining.frameSize = NSMakeSize(remainingFrame.size.width, overallFrame.size.height);
    }
    
    [self display];
}

/**
 展开指定索引处的子视图;假设只使用了两个子视图。如果已经扩展，什么都没有
 idx扩展索引。
 */

- (void)tfy_expandSubviewAtIndex:(NSUInteger)idx;
{
    NSUInteger other = idx ? 0 : 1;
    
    NSView *remaining  = [self.subviews objectAtIndex:other];
    NSView *collapsing = [self.subviews objectAtIndex:idx];
    CGFloat thickness = self.dividerThickness;
    
    if (!collapsing.hidden)
    {
        return;
    }
    
    collapsing.hidden = NO;
    
    NSRect remainingFrame = remaining.frame;
    NSRect collapsingFrame = collapsing.frame;
    
    if (self.vertical)
    {
        remainingFrame.size.height = (remainingFrame.size.height - collapsingFrame.size.height - thickness);
        collapsingFrame.origin.y = remainingFrame.size.height + thickness;
    }
    else
    {
        remainingFrame.size.width = (remainingFrame.size.width - collapsingFrame.size.width - thickness);
        collapsingFrame.origin.x = remainingFrame.size.width + thickness;
    }
    
    remaining.frameSize = remainingFrame.size;
    collapsing.frame = collapsingFrame;
    
    [self display];
}

@end

