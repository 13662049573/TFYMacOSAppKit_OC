//
//  NSObject+AppKit+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSObject+Dejal.h"


@interface NSObject (DejalAppKit)
/**
 类似于-performSelector:withObject:withObject:，但调用模式did-end选择器标准模式中的方法。如果selector为nil，什么都不做。
*/
- (void)tfy_performSelector:(SEL)selector withWindow:(__unsafe_unretained NSWindow *)window returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
/**
 如果在最近的事件中按下了命令修改器键，则返回YES。
*/
- (BOOL)tfy_usedCommandModifier;
/**
 如果在最近的事件中按下了Option (Alternate)修饰符键，则返回YES。
*/
- (BOOL)tfy_usedOptionModifier;
/**
 如果在最近的事件中按下了Shift修改器键，则返回YES。
*/
- (BOOL)tfy_usedShiftModifier;
/**
 如果在最近的事件中按下了Control修饰符键，则返回YES。
*/
- (BOOL)tfy_usedControlModifier;

@end

