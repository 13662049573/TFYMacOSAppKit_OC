//
//  NSObject+AppKit+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSObject+AppKit+Dejal.h"


@implementation NSObject (DejalAppKit)

/**
 类似于-performSelector:withObject:withObject:，但调用模式did-end选择器标准模式中的方法。如果selector为nil，什么都不做。
*/

- (void)tfy_performSelector:(SEL)selector withWindow:(__unsafe_unretained NSWindow *)window returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (!selector)
        return;
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    [invocation setSelector:selector];
    [invocation setArgument:&window atIndex:2];
    [invocation setArgument:&returnCode atIndex:3];
    [invocation setArgument:&contextInfo atIndex:4];
    [invocation invokeWithTarget:self];
}


/**
 如果在最近的事件中按下了命令修改器键，则返回YES。
*/

- (BOOL)tfy_usedCommandModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagCommand) == NSEventModifierFlagCommand;
}

/**
 如果在最近的事件中按下了Option (Alternate)修饰符键，则返回YES。
*/

- (BOOL)tfy_usedOptionModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagOption) == NSEventModifierFlagOption;
}

/**
 如果在最近的事件中按下了Shift修改器键，则返回YES。
*/

- (BOOL)tfy_usedShiftModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagShift) == NSEventModifierFlagShift;
}

/**
 如果在最近的事件中按下了Control修饰符键，则返回YES。
*/

- (BOOL)tfy_usedControlModifier
{
    return ([[NSApp currentEvent] modifierFlags] & NSEventModifierFlagControl) == NSEventModifierFlagControl;
}

@end

