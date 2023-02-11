//
//  NSWindow+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSWindow (Dejal)
/**
 如果可能，使指定的视图成为第一响应器，并且无论如何确保没有使用字段编辑器。应始终在创建新字段编辑器之前调用此函数，或在无需通知每次击键的情况下将编辑刷新到当前字段。
*/
- (void)tfy_forceEndEditingForView:(NSView *)view;
/**
 将窗口的alpha值设置为百分比(从0.0到100.0)，并显示窗口。通常你会调用下面的方法来动画淡出，而不是这个。
*/
- (void)tfy_fadeTo:(CGFloat)percent;
/**
 如果fadeIn为YES，则将一个透明窗口淡入为不透明窗口，反之亦然，花费指示的总时间进行转换。请参见fadeIn:forInterval:target:selector:withObject:如果你想在窗口淡出时做其他工作。
 */

- (void)tfy_fadeIn:(BOOL)fadeIn forInterval:(NSTimeInterval)totalTime;
/**
 如果fadeIn为YES，则将一个透明窗口淡入为不透明窗口，反之亦然，花费指示的总时间进行转换。当它被动画化时，选择器被发送到带有object参数的目标。为了避免这种情况，目标或选择器可以为nil。这样调用的方法必须有一个(而且只有一个)参数:对象。对象可以是任何值。如。

 - (void) doSomethingDuringFadeIn: (id)对象;

*/
- (void)tfy_fadeIn:(BOOL)fadeIn forInterval:(NSTimeInterval)totalTime target:(id)target selector:(SEL)aSelector withObject:(id)object;
/**
 调整接收窗口的大小，以便将指定的视图调整为指定的大小——假设为该视图设置了自动调整大小的弹簧。如果centerHoriz为YES，则移动窗口位置，使窗口的水平中心保持在相同的位置，否则窗口位置不会改变。通常情况下，对于表将传递YES，对于窗口将传递NO，尽管有些窗口可能想要传递YES。
*/

- (void)tfy_setFrameSoView:(NSView *)view hasSize:(NSSize)newViewSize centerHorizontalPostion:(BOOL)centerHoriz;

@end

