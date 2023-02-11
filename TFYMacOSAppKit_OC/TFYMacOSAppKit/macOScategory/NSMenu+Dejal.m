//
//  NSMenu+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSMenu+Dejal.h"


@implementation NSMenu (Dejal)

/**
 向菜单中添加分隔符项。
*/
- (void)tfy_addSeparatorItem;
{
    [self addItem:[NSMenuItem separatorItem]];
}

/**
 类似于-addItemWithTitle:action:keyEquivalent:，但也允许指定目标对象。如果不需要，对应的键应该是@""，而不是nil，尽管nil也被这些类别接受。
*/
- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString target:(id)target action:(SEL)aSelector
                   keyEquivalent:(NSString *)keyEquiv
{
    return [self tfy_addItemWithTitle:aString target:target action:aSelector keyEquivalent:keyEquiv icon:nil];
}

/**
 类似于-addItemWithTitle:action:keyEquivalent:，但也允许指定目标对象。它允许设置所表示的对象和/或标记，而不是键等价。
*/
- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString target:(id)target action:(SEL)aSelector representedObject:(id)object tag:(NSInteger)tag;
{
    return [self tfy_addItemWithTitle:aString target:target action:aSelector keyEquivalent:@"" modifierMask:0 icon:nil representedObject:object tag:tag];
}

/**
 类似于-addItemWithTitle:target:action:keyEquivalent:，但也允许指定图标图像。如果不需要，对应的键应该是@""，而不是nil，尽管nil也被这些类别接受。
*/

- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString target:(id)target action:(SEL)aSelector
                   keyEquivalent:(NSString *)keyEquiv icon:(NSImage *)icon
{
    return [self tfy_addItemWithTitle:aString target:target action:aSelector keyEquivalent:keyEquiv icon:icon representedObject:nil];
}

/**
 类似于-addItemWithTitle:target:action:keyEquivalent:icon:，但也允许指定一个表示的对象。如果不需要，对应的键应该是@""，而不是nil，尽管nil也被这些类别接受。
*/

- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString target:(id)target action:(SEL)aSelector
                   keyEquivalent:(NSString *)keyEquiv icon:(NSImage *)icon representedObject:(id)object
{
    return [self tfy_addItemWithTitle:aString target:target action:aSelector keyEquivalent:keyEquiv modifierMask:0 icon:icon representedObject:object tag:0];
}

/**
 类似于-addItemWithTitle:target:action:keyEquivalent:icon:，但也允许指定一个表示的对象。如果不需要，对应的键应该是@""，而不是nil，尽管nil也被这些类别接受。
*/
- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString target:(id)target action:(SEL)aSelector
                   keyEquivalent:(NSString *)keyEquiv modifierMask:(NSUInteger)modifierMask icon:(NSImage *)icon representedObject:(id)object
{
    return [self tfy_addItemWithTitle:aString target:target action:aSelector keyEquivalent:keyEquiv modifierMask:modifierMask icon:icon representedObject:object tag:0];
}

/**
 类似于-addItemWithTitle:target:action:keyEquivalent:icon: representtedobject:，但也允许指定修饰符掩码;如果为零，表示掩码没有改变。如果不需要，对应的键应该是@""，而不是nil，尽管nil也被这些类别接受。
*/

- (NSMenuItem *)tfy_addItemWithTitle:(NSString *)aString target:(id)target action:(SEL)aSelector
                   keyEquivalent:(NSString *)keyEquiv modifierMask:(NSUInteger)modifierMask icon:(NSImage *)icon representedObject:(id)object tag:(NSInteger)tag;
{
    if (!keyEquiv)
        keyEquiv = @"";
    
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:aString action:aSelector keyEquivalent:keyEquiv];
    
    if (modifierMask)
        [item setKeyEquivalentModifierMask:modifierMask];
    
    [item setTarget:target];
    [item setImage:icon];
    [item setRepresentedObject:object];
    [item setTag:tag];
    
    [self addItem:item];
    
    return item;
}

/**
 根据菜单项的目标和操作移除菜单项。返回它的菜单项索引，以防相邻的项(例如分隔符)也需要删除。
*/

- (NSInteger)tfy_removeItemWithTarget:(id)target andAction:(SEL)action;
{
    NSInteger itemIndex = [self indexOfItemWithTarget:target andAction:action];
    
    if (itemIndex >= 0)
        [self removeItemAtIndex:itemIndex];
    
    return itemIndex;
}

/**
 基于目标和操作移除所有菜单项。
 */

- (void)tfy_removeItemsWithTarget:(id)target andAction:(SEL)action;
{
    NSInteger itemIndex = -1;
    
    do
    {
        itemIndex = [self indexOfItemWithTarget:target andAction:action];
        
        if (itemIndex >= 0)
        {
            [self removeItemAtIndex:itemIndex];
        }
    }
    while (itemIndex >= 0);
}

/**
 返回接收器中具有指定操作和目标的第一个菜单项的索引。

 target被设置为接收器菜单项的目标对象。
 标识操作方法的选择器。如果actionSelector为NULL，则返回接收器中目标为anObject的第一个菜单项。
 @返回菜单项，如果菜单中没有这样的菜单项，则为nil。
 */

- (NSMenuItem *)tfy_itemWithTarget:(id)target andAction:(SEL)action;
{
    NSInteger idx = [self indexOfItemWithTarget:target andAction:action];
    
    if (idx >= 0)
    {
        return [self itemAtIndex:idx];
    }
    else
    {
        return nil;
    }
}

/**
 返回带有给定目标、操作和标记值(如果有的话)的接收器中的菜单项。

 target被设置为接收器菜单项的目标对象。
 标识操作方法的选择器。
 菜单项标签值。
 @返回找到的菜单项，如果不匹配则为nil。
 */

- (NSMenuItem *)tfy_itemWithTarget:(id)target action:(SEL)action tag:(NSInteger)tag;
{
    for (NSMenuItem *menuItem in self.itemArray)
    {
        if (menuItem.target == target && menuItem.action == action && menuItem.tag == tag)
        {
            return menuItem;
        }
    }
    
    return nil;
}

/**
 使用给定的目标和操作切换接收器中所有菜单项的状态，以便只检查与指定标记值匹配的项，不检查与其他标记值匹配的项。

 target被设置为接收器菜单项的目标对象。
 标识操作方法的选择器。
 菜单项标签值。
 */

- (void)tfy_setCheckedItemForTarget:(id)target andAction:(SEL)action withTag:(NSInteger)tag;
{
    for (NSMenuItem *menuItem in self.itemArray)
    {
        if (menuItem.target == target && menuItem.action == action)
        {
            menuItem.state = menuItem.tag == tag;
        }
    }
}

@end


@implementation NSMenuItem (Dejal)

/**
 返回具有给定标题和其他设置的新菜单项实例。也许有点傻，但必须指定一个空的(不是nil)键等效物是恼人的，但块是有趣的。

 菜单项的标题。
 一个可选的块，用于在新项目上设置额外的属性。传递nil只设置标题。
 一个新的菜单项实例。
 */

+ (instancetype)tfy_menuItemWithTitle:(NSString *)title settings:(void (^)(NSMenuItem *item))block;
{
    NSMenuItem *menuItem = [[self alloc] initWithTitle:title action:nil keyEquivalent:@""];
    
    if (block)
    {
        block(menuItem);
    }
    
    return menuItem;
}

@end

