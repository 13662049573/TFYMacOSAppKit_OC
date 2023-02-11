//
//  NSView+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSView (DejalSubviews)
/**
 返回当前外观是否为暗模式。在NSColor+Dejal类别中还提供了一个类似的类方法，用于当视图不可用时。

 如果暗，@返回YES，否则返回NO。
 */
- (BOOL)tfy_isDark;
/**
 将指定的视图添加为接收器的子视图，并设置其自动布局约束以保持接收器的完整大小。
*/

- (void)tfy_addFullyConstrainedSubview:(NSView *)subview;
/**
 调整接收器的指定子视图的自动布局约束，使其保持接收器的完整大小。
*/
- (void)tfy_addFullSizeConstraintsForSubview:(NSView *)subview;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSView (DejalSizing)
/**
 调整窗口中的自动调整大小蒙版，以便当窗口调整大小时，接收器将垂直展开，而其他视图将保持相同的高度。返回旧掩码的数组，将传递给下面的-restoreAutoresizeMasks，以将掩码更改为调用此方法之前的掩码。
*/

- (NSArray *)tfy_adjustAutoresizeMasks;
/**
 调整窗口中的自动调整大小蒙版，以便当窗口调整大小时，接收器将垂直展开，而其他视图将保持相同的高度。返回旧掩码的数组，将传递给下面的-restoreAutoresizeMasks，以将掩码更改为调用此方法之前的掩码。
*/
- (NSArray *)tfy_adjustAutoresizingAroundPosition:(CGFloat)position stickPositionToTop:(BOOL)stickPositionToTop;
/**
 更改窗口的自动调整蒙版到-adjustAutoresizeMasks或-adjustAutoresizingAroundPosition:stickPositionToTop:被调用之前的样子。
*/

- (void)tfy_restoreAutoresizeMasks:(NSArray *)masks;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSView (DejalScaling)
/**
 此方法返回接收器坐标系相对于窗口基坐标系的比例，以绝对值表示。
*/
@property (nonatomic, setter=tfy_setScale:) NSSize tfy_scale;
/**
 此方法设置以百分比表示的刻度。
*/
@property (nonatomic, setter=tfy_setScalePercent:) CGFloat tfy_scalePercent;
/**
 此方法使接收器的缩放等于窗口的基本坐标系统。
*/

- (void)tfy_resetScaling;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSView (DejalDrawing)
/**
 更改接收器的alphaValue为不透明或透明。

 如果是，将接收器的alphaValue设置为1.0(不透明)，否则设置为0.0(透明)。
 */
@property (nonatomic, setter=tfy_setAlphaOpaque:) BOOL tfy_alphaOpaque;
/**
 更改接收器的alphaValue，使其不透明或透明，可选择使用动画。

 如果是，将接收器的alphaValue设置为1.0(不透明)，否则设置为0.0(透明)。
 animated如果是，使用动画器设置alphaValue，否则立即设置。
 */
- (void)tfy_setAlphaOpaque:(BOOL)makeOpaque animated:(BOOL)animated;

@end

