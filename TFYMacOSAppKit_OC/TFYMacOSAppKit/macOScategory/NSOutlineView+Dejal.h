//
//  NSOutlineView+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


#import <Cocoa/Cocoa.h>


@protocol DejalOutlineViewDelegate <NSOutlineViewDelegate>
@optional

- (NSMenu *)outlineView:(NSOutlineView *)olv menuForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;

@end

@interface NSOutlineView (Dejal)
/**
 使用this代替在此类别中定义的协议方法中的-delegate。
*/
- (id <DejalOutlineViewDelegate>)tfy_delegate;
/**
 返回选定行(如果有多个则返回第一个选定行)的对象。
*/

- (id)tfy_selectedItem;
/**
 返回一个包含所选行对象的数组，如果没有选择且传递YES，则返回所有行对象。
*/
- (NSArray *)tfy_selectedOrAllItems:(BOOL)allIfNoneSelected;
/**
 为数组中的对象选择行，可选地扩展任何现有选择。
*/
- (void)tfy_selectItems:(NSArray *)items byExtendingSelection:(BOOL)extendSel;
/**
 重写NSView方法，允许为单个行和列设置上下文菜单。你应该在你的大纲委托中实现-outlineView:menuForTableColumn:byItem:。如果没有实现，则返回默认菜单。
*/
- (NSMenu *)tfy_menuForEvent:(NSEvent *)event;

@end

