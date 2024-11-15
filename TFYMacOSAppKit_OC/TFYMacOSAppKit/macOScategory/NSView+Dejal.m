//
//  NSView+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


#import "NSView+Dejal.h"


@implementation NSView (DejalSubviews)

- (BOOL)tfy_isDark;
{
    if (@available(macOS 10.14, *)) {
        return [self.effectiveAppearance bestMatchFromAppearancesWithNames:@[NSAppearanceNameAqua, NSAppearanceNameDarkAqua]] == NSAppearanceNameDarkAqua;
    }
    
    return false;
}

/**
 将指定的视图添加为接收器的子视图，并设置其自动布局约束以保持接收器的完整大小。
*/

- (void)tfy_addFullyConstrainedSubview:(NSView *)subview;
{
    [self addSubview:subview];
    [self tfy_addFullSizeConstraintsForSubview:subview];
}

/**
 调整接收器的指定子视图的自动布局约束，使其保持接收器的完整大小。
*/

- (void)tfy_addFullSizeConstraintsForSubview:(NSView *)subview;
{
    // 另见视图控制器视图根级别的IB复选框“将掩码转换为约束”:
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subview);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|" options:0 metrics:nil views:views]];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSView (DejalSizing)

/**
 调整窗口中的自动调整大小蒙版，以便当窗口调整大小时，接收器将垂直展开，而其他视图将保持相同的高度。返回旧掩码的数组，将传递给下面的-restoreAutoresizeMasks，以将掩码更改为调用此方法之前的掩码。
*/

- (NSArray *)tfy_adjustAutoresizeMasks;
{
    return [self tfy_adjustAutoresizingAroundPosition:NSMaxY([self frame]) stickPositionToTop:YES];
}

/**
 调整窗口中的自动调整大小蒙版，以便当窗口调整大小时，接收器将垂直展开，而其他视图将保持相同的高度。返回旧掩码的数组，将传递给下面的-restoreAutoresizeMasks，以将掩码更改为调用此方法之前的掩码。
*/

- (NSArray *)tfy_adjustAutoresizingAroundPosition:(CGFloat)position stickPositionToTop:(BOOL)stickPositionToTop;
{
    NSMutableArray *subviewMasks = [NSMutableArray array];
    NSView *superview = self;
    NSView *oldSuperview = superview;
    
    while (superview)
    {
        // 首先调整父视图的蒙版:
        NSUInteger mask = [superview autoresizingMask];
        [subviewMasks addObject:@(mask)];
        
        // Make it stick to the top and bottom of the window, and change height:
        mask |= NSViewHeightSizable;
        mask &= ~NSViewMaxYMargin;
        mask &= ~NSViewMinYMargin;
        
        [superview setAutoresizingMask:mask];
        
        NSArray *subviews = [superview subviews];
        
        for (NSView *subview in subviews)
        {
            
            if (subview != oldSuperview)
            {
                mask = [subview autoresizingMask];
                BOOL stickToBottom = NSMaxY([subview frame]) <= position;
                
                if (!stickPositionToTop && (NSMaxY([subview frame]) == position))
                    stickToBottom = YES;
                
                [subviewMasks addObject:@(mask)];
                
                if (stickToBottom)
                {
                    // 这个子视图在我们下面。让它粘在窗口底部，不改变高度:
                    mask &= ~NSViewHeightSizable;
                    mask |= NSViewMaxYMargin;
                    mask &= ~NSViewMinYMargin;
                }
                else
                {
                    // 这个子视图在我们上面。让它粘在窗户顶部，不改变高度:
                    mask &= ~NSViewHeightSizable;
                    mask &= ~NSViewMaxYMargin;
                    mask |= NSViewMinYMargin;
                }
                
                [subview setAutoresizingMask:mask];
            }
        }
        // 到这个父视图的父视图，重复这个过程;注意，循环算法必须在下面的恢复方法中完全复制。理想情况下，这两个方法都应该使用另一个方法来获得下一个子视图，但我不能在这个阶段重构它，所以要注意这个问题:
        oldSuperview = superview;
        position = NSMaxY([superview frame]);
        superview = [superview superview];
    }
    
    return subviewMasks;
}

/**
 更改窗口的自动调整蒙版到-adjustAutoresizeMasks或-adjustAutoresizingAroundPosition:stickPositionToTop:被调用之前的样子。
*/

- (void)tfy_restoreAutoresizeMasks:(NSArray *)masks;
{
    NSView *superview = self;
    NSView *oldSuperview = superview;
    NSEnumerator *enumerator = [masks objectEnumerator];
    
    while (superview)
    {
        // 第一项是父视图的蒙版:
        [superview setAutoresizingMask:[[enumerator nextObject] unsignedIntegerValue]];
        
        // 以下是子视图掩码:
        NSArray *subviews = [superview subviews];
        
        for (NSView *subview in subviews)
        {
            
            if (subview != oldSuperview)
                [subview setAutoresizingMask:[[enumerator nextObject] unsignedIntegerValue]];
        }
        
        //到这个父视图的父视图，重复这个过程;注意，循环算法必须在上面的adjust方法中完全复制。理想情况下，这两个方法都应该使用另一个方法来获得下一个子视图，但我不能在这个阶段重构它，所以要注意这个问题:
        oldSuperview = superview;
        superview = [superview superview];
    }
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSView (DejalScaling)

const NSSize unitSize = {1.0, 1.0};

/**
 此方法使接收器的缩放等于窗口的基本坐标系统。
*/

- (void)tfy_resetScaling
{
    [self scaleUnitSquareToSize:[self convertSize:unitSize fromView:nil]];
}

/**
 此方法返回接收器坐标系相对于窗口基坐标系的比例，以绝对值表示。
*/

- (NSSize)tfy_scale
{
    return [self convertSize:unitSize fromView:nil];
}

/**
 这种方法以绝对值设置刻度。
*/

- (void)tfy_setScale:(NSSize)newScale
{
    [self tfy_resetScaling];  // 首先，将缩放与窗口的坐标系统相匹配
    [self scaleUnitSquareToSize:newScale]; // T母鸡，调一下秤。
}

/**
 此方法返回接收器坐标系统相对于窗口基本坐标系统的比例，以百分比表示。
*/

- (CGFloat)tfy_scalePercent
{
    return [self tfy_scale].width * 100;
}

/**
 此方法设置以百分比表示的刻度。
*/

- (void)tfy_setScalePercent:(CGFloat)scale
{
    scale = scale / 100.0;
    [self tfy_setScale:NSMakeSize(scale, scale)];
    [self setNeedsDisplay:YES];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSView (DejalDrawing)

/**
 如果接收者的alphaValue为1.0，则返回YES，否则返回NO。
 */

- (BOOL)tfy_alphaOpaque;
{
    return self.alphaValue == 1.0;
}

/**
 更改接收器的alphaValue为不透明或透明。

 如果是，将接收器的alphaValue设置为1.0(不透明)，否则设置为0.0(透明)。
 */

- (void)tfy_setAlphaOpaque:(BOOL)makeOpaque;
{
    self.alphaValue = makeOpaque ? 1.0 : 0.0;
}

/**
 更改接收器的alphaValue，使其不透明或透明，可选择使用动画。

 如果是，将接收器的alphaValue设置为1.0(不透明)，否则设置为0.0(透明)。
 animated如果是，使用动画器设置alphaValue，否则立即设置。
 */

- (void)tfy_setAlphaOpaque:(BOOL)makeOpaque animated:(BOOL)animated;
{
    if (animated)
    {
        self.animator.alphaValue = makeOpaque ? 1.0 : 0.0;
    }
    else
    {
        self.alphaValue = makeOpaque ? 1.0 : 0.0;
    }
}

@end

