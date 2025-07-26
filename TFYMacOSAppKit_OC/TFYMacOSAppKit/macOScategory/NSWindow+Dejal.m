//
//  NSWindow+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSWindow+Dejal.h"


@implementation NSWindow (Dejal)

/**
 如果可能，使指定的视图成为第一响应器，并且无论如何确保没有使用字段编辑器。应始终在创建新字段编辑器之前调用此函数，或在无需通知每次击键的情况下将编辑刷新到当前字段。
*/

- (void)tfy_forceEndEditingForView:(NSView *)view
{
    // 确保没有其他人在使用字段编辑器:
    if (![self makeFirstResponder:view])
        [self endEditingFor:nil];
}


/**
 将窗口的alpha值设置为百分比(从0.0到100.0)，并显示窗口。通常你会调用下面的方法来动画淡出，而不是这个。
*/

- (void)tfy_fadeTo:(CGFloat)percent
{
    if (percent > 100.0)
        percent = 100.0;
    else if (percent < 0.0)
        percent = 0.0;

    CGFloat amount = percent / 100.0;

    // Set the window's alpha value from 0.0-1.0:
    [self setAlphaValue:amount];

    // Tell the window to redraw things:
    [self display];
}

/**
 如果fadeIn为YES，则将一个透明窗口淡入为不透明窗口，反之亦然，花费指示的总时间进行转换。请参见fadeIn:forInterval:target:selector:withObject:如果你想在窗口淡出时做其他工作。
 */

- (void)tfy_fadeIn:(BOOL)fadeIn forInterval:(NSTimeInterval)totalTime
{
    [self tfy_fadeIn:fadeIn forInterval:totalTime target:nil selector:nil withObject:nil];
}

/**
 如果fadeIn为YES，则将一个透明窗口淡入为不透明窗口，反之亦然，花费指示的总时间进行转换。当它被动画化时，选择器被发送到带有object参数的目标。为了避免这种情况，目标或选择器可以为nil。这样调用的方法必须有一个(而且只有一个)参数:对象。对象可以是任何值。如。

 - (void) doSomethingDuringFadeIn: (id)对象;

*/

- (void)tfy_fadeIn:(BOOL)fadeIn forInterval:(NSTimeInterval)totalTime target:(id)target selector:(SEL)aSelector withObject:(id)object
{
    NSDate *start = [NSDate date];
    NSTimeInterval elapsedTime;
    CGFloat percent;

    do
    {
        elapsedTime = -[start timeIntervalSinceNow];
        percent = (elapsedTime * 100.0) / totalTime;
        
        if (!fadeIn)
            percent = 100.0 - percent;

        [self tfy_fadeTo:percent];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (target && aSelector)
            [target performSelector:aSelector withObject:object];
#pragma clang diagnostic pop
    }
    while (elapsedTime < totalTime);

    if (fadeIn)
        [self tfy_fadeTo:100.0];
    else
        [self tfy_fadeTo:0.0];
}

/**
 调整接收窗口的大小，以便将指定的视图调整为指定的大小——假设为该视图设置了自动调整大小的弹簧。如果centerHoriz为YES，则移动窗口位置，使窗口的水平中心保持在相同的位置，否则窗口位置不会改变。通常情况下，对于表将传递YES，对于窗口将传递NO，尽管有些窗口可能想要传递YES。
*/

- (void)tfy_setFrameSoView:(NSView *)view hasSize:(NSSize)newViewSize centerHorizontalPostion:(BOOL)centerHoriz
{
    if (!view)
        return;
    
    NSRect oldViewFrame = [view frame];
    
    CGFloat deltaH = newViewSize.width - NSWidth(oldViewFrame);
    CGFloat deltaV = newViewSize.height - NSHeight(oldViewFrame);
    
    NSRect oldWindowFrame = [NSWindow contentRectForFrameRect:[self frame] styleMask:[self styleMask]];
    
    CGFloat newWindowWidth = NSWidth(oldWindowFrame) + deltaH;
    CGFloat newWindowHeight = NSHeight(oldWindowFrame) + deltaV;
    CGFloat horizPosition = centerHoriz ? NSMinX(oldWindowFrame) - (deltaH / 2) : NSMinX(oldWindowFrame);
    
    NSRect newWindowFrame = [NSWindow frameRectForContentRect:NSMakeRect(horizPosition, NSMaxY(oldWindowFrame) - newWindowHeight, newWindowWidth, newWindowHeight) styleMask:[self styleMask]];
    
    [self setFrame:newWindowFrame display:YES animate:[self isVisible]];
}

@end

