//
//  NSSplitView+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import <Cocoa/Cocoa.h>

@interface NSSplitView (Dejal)
/**
 设置第一个分割分隔符的位置。可以通过[[splitView animator] setSplitPosition:position]进行动画。
*/
@property (nonatomic, setter=tfy_setSplitPosition:) CGFloat tfy_splitPosition;

- (CGFloat)tfy_splitPositionOfDividerAtIndex:(NSUInteger)idx;
/**
 返回指定分割分隔符的当前位置。

 idx分隔符，第一个为零。
 @返回分隔符的位置。
 */
- (void)tfy_toggleSubviewAtIndex:(NSUInteger)idx;
/**
 折叠指定索引处的子视图;假设只使用了两个子视图。如果已经崩溃了什么都没有
 idx崩溃索引。
 */
- (void)tfy_collapseSubviewAtIndex:(NSUInteger)idx;
/**
 展开指定索引处的子视图;假设只使用了两个子视图。如果已经扩展，什么都没有
 idx扩展索引。
 */
- (void)tfy_expandSubviewAtIndex:(NSUInteger)idx;

@end

