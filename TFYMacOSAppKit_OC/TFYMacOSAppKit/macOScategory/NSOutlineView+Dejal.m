//
//  NSOutlineView+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


#import "NSOutlineView+Dejal.h"
#import "NSTableView+Dejal.h"


@implementation NSOutlineView (Dejal)

/**
 使用this代替在此类别中定义的协议方法中的-delegate。
*/

- (id <DejalOutlineViewDelegate>)tfy_delegate;
{
    return (id <DejalOutlineViewDelegate>)[self delegate];
}

/**
 返回选定行(如果有多个则返回第一个选定行)的对象。
*/

- (id)tfy_selectedItem
{
    return [self itemAtRow:[self selectedRow]];
}

/**
 返回一个包含所选行对象的数组，如果没有选择且传递YES，则返回所有行对象。
*/

- (NSArray *)tfy_selectedOrAllItems:(BOOL)allIfNoneSelected
{
    NSMutableArray *items = [NSMutableArray array];
    NSEnumerator *enumerator;
    NSNumber *selRow = nil;

    if (allIfNoneSelected)
        enumerator = [self tfy_selectedOrAllRowsEnumerator];
    else
        enumerator = [self tfy_selectedRowsEnumerator];
    
    while ((selRow = [enumerator nextObject]))
    {
        id item = [self itemAtRow:[selRow integerValue]];
        
        if (item)
            [items addObject:item];
    }

    return items;
}

/**
 为数组中的对象选择行，可选地扩展任何现有选择。
*/

- (void)tfy_selectItems:(NSArray *)items byExtendingSelection:(BOOL)extendSel;
{
    NSMutableIndexSet *indexes = [NSMutableIndexSet new];
    
    for (id item in items)
    {
        NSInteger row = [self rowForItem:item];

        if (row >= 0)
        {
            [indexes addIndex:row];
        }
    }
    
    [self selectRowIndexes:indexes byExtendingSelection:extendSel];
}

/**
 重写NSView方法，允许为单个行和列设置上下文菜单。你应该在你的大纲委托中实现-outlineView:menuForTableColumn:byItem:。如果没有实现，则返回默认菜单。
*/

- (NSMenu *)tfy_menuForEvent:(NSEvent *)event
{
    NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    NSInteger column = [self columnAtPoint:point];
    NSInteger row = [self rowAtPoint:point];
    id item = [self itemAtRow:row];
    
    if (column >= 0 && item && [[self delegate] respondsToSelector:@selector(outlineView:menuForTableColumn:byItem:)])
        return [[self tfy_delegate] outlineView:self menuForTableColumn:[self tableColumns][column] byItem:item];
    else
        return [super menuForEvent:event];
}

@end

