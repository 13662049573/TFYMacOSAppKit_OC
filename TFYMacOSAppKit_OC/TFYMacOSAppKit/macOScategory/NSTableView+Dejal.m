//
//  NSTableView+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSTableView+Dejal.h"
#import "NSAttributedString+AppKit+Dejal.h"
#import "NSString+AppKit+Dejal.h"
#import "NSImage+Dejal.h"
#import "NSWindow+Dejal.h"
#import "NSDictionary+Dejal.h"


@interface NSObject (DejalTableViewCutCopyPasteDeleteDelegate)

- (NSIndexSet *)tableView:(NSTableView *)tableView shouldCutRowIndexes:(NSIndexSet *)indexes;
- (NSIndexSet *)tableView:(NSTableView *)tableView shouldCopyRowIndexes:(NSIndexSet *)indexes;
- (NSInteger)tableView:(NSTableView *)tableView shouldPasteBeforeRow:(NSInteger)row;

- (NSString *)tableView:(NSTableView *)tableView stringValueForRow:(NSInteger)row;

@end


@interface NSObject (DejalTableViewDragDelegate)

- (NSImage *)tableView:(NSTableView *)tableView dragImageForRowsWithIndexes:(NSIndexSet *)dragRows tableColumns:(NSArray *)tableColumns event:(NSEvent *)dragEvent offset:(NSPointPointer)dragImageOffset;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSTableView (Dejal)

/**
 使用this代替在此类别中定义的协议方法中的-delegate。
*/

- (id <DejalTableViewDelegate>)tfy_delegate;
{
    return (id <DejalTableViewDelegate>)[self delegate];
}

/**
 取消选择表中的所有行。
*/

- (IBAction)selectNone:(id)sender
{
    [self deselectAll:sender];
}

/**
 返回包含所有行的索引集。
*/

- (NSIndexSet *)tfy_allRowIndexes;
{
    if ([self numberOfRows])
	    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self numberOfRows] - 1)];
    else
        return [NSIndexSet indexSet];
}

/**
 返回一个索引集，如果有选定的行，则只包括选定的行;如果没有选定，则返回所有行。
*/

- (NSIndexSet *)tfy_selectedOrAllRowIndexes;
{
    if ([self numberOfRows] == 0 || [self numberOfSelectedRows] > 0)
        return self.selectedRowIndexes;
    else
        return self.tfy_allRowIndexes;
}

/**
 返回一个索引集，如果有多个选定行，则该索引集只包括选定的行;如果没有选定行，则返回所有行。
*/

- (NSIndexSet *)tfy_multipleSelectedOrAllRowIndexes;
{
    if ([self numberOfRows] == 0 || [self numberOfSelectedRows] > 1)
        return self.selectedRowIndexes;
    else
        return self.tfy_allRowIndexes;
}

/**
 返回所有表行的行号枚举数。
*/

- (NSEnumerator *)tfy_rowEnumerator
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self numberOfRows]];
    NSInteger row;
    
    for (row = 0; row < [self numberOfRows]; row++)
        [array addObject:@(row)];
    
    return [array objectEnumerator];
}

/**
 返回选定表行的行号枚举数。替换已弃用的- seltedrowenumerator方法。
*/

- (NSEnumerator *)tfy_selectedRowsEnumerator;
{
    NSIndexSet *selectedRows = self.selectedRowIndexes;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[selectedRows count]];
    NSInteger row;
    
    for (row = 0; row < [self numberOfRows]; row++)
        if ([selectedRows containsIndex:row])
            [array addObject:@(row)];
    
    return [array objectEnumerator];
}

/**
 返回一个枚举数，如果有选定的行，则只包括选定的行;如果没有选定，则返回所有行。
*/

- (NSEnumerator *)tfy_selectedOrAllRowsEnumerator
{
    if ([self numberOfRows] == 0 || [self numberOfSelectedRows] > 0)
        return [self tfy_selectedRowsEnumerator];
    else
        return [self tfy_rowEnumerator];
}

/**
 返回一个枚举数，如果有多个选定行，则只包括选定的行;如果没有或只有一个选定行，则返回所有行。
*/

- (NSEnumerator *)tfy_multipleSelectedOrAllRowsEnumerator
{
    if ([self numberOfRows] == 0 || [self numberOfSelectedRows] > 1)
        return [self tfy_selectedRowsEnumerator];
    else
        return [self tfy_rowEnumerator];
}

/**
 选择第一行，或者同时选择任何现有的选择，或者相反。
*/

- (void)tfy_selectFirstRowExtendingSelection:(BOOL)extendSel;
{
    if ([self numberOfRows] > 0)
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:extendSel];
}

/**
 选择最后一行，或者同时选择任何现有的选择，或者相反。
*/

- (void)tfy_selectLastRowExtendingSelection:(BOOL)extendSel;
{
    if ([self numberOfRows] > 0)
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:[self numberOfRows] - 1] byExtendingSelection:extendSel];
}

/**
 选择指定的行，或者同时选择任何现有的选择。替换已弃用的-selectRow:extendingSelection:方法。
*/

- (void)tfy_selectRowIndex:(NSUInteger)rowIndex byExtendingSelection:(BOOL)extendSel;
{
    if ([self numberOfRows] > (NSInteger)rowIndex)
        [self selectRowIndexes:[NSIndexSet indexSetWithIndex:rowIndex] byExtendingSelection:extendSel];
}

/**
 编辑具有列标识符和行的单元格，必要时首先选择行。一个稍微方便一点的-editColumn:row:withEvent:select:版本。如果行超出范围或无法找到列，则不执行任何操作。
*/

- (void)tfy_editColumnWithIdentifier:(NSString *)columnIdentfier row:(NSInteger)row;
{
    NSInteger column = [self columnWithIdentifier:columnIdentfier];
    
    if (row < 0 || row >= [self numberOfRows] || column < 0)
        return;
    
    [self selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
    [self editColumn:column row:row withEvent:nil select:YES];
}

/**
 返回表中所有列的枚举数。
*/

- (NSEnumerator *)tfy_tableColumnEnumerator
{
    return [[self tableColumns] objectEnumerator];
}

/**
 返回索引表列。
*/

- (NSTableColumn *)tfy_tableColumnAtIndex:(NSUInteger)i;
{
    return [self tableColumns][i];
}

/**
 返回表中第一个可编辑列的索引，如果没有则返回NSNotFound。
*/

- (NSUInteger)tfy_indexOfFirstEditableTableColumn;
{
    NSUInteger i = 0;
    NSUInteger count = [self numberOfColumns];
    
    while (i < count && ![[self tfy_tableColumnAtIndex:i] isEditable])
        i++;
    
    return i < count ? i : NSNotFound;
}

/**
 返回表中第一个可编辑列，如果没有则返回nil。
*/

- (NSTableColumn *)tfy_firstEditableTableColumn;
{
    NSUInteger i = [self tfy_indexOfFirstEditableTableColumn];
    
    return i != NSNotFound ? [self tfy_tableColumnAtIndex:i] : nil;
}

/**
 创建具有指定属性的新文本列，并将其添加到接收器。如果您想更改任何其他属性，则会返回新列。
*/

- (NSTableColumn *)tfy_addTableColumnWithIdentifier:(NSString *)identifier title:(NSString *)title editable:(BOOL)editable resizable:(BOOL)resizable width:(CGFloat)width
{
    return [self tfy_addTableColumnWithIdentifier:identifier title:title editable:editable resizable:resizable sortable:NO ascending:YES width:width alignment:NSTextAlignmentNatural];
}

/**
 创建具有指定属性的新文本列，并将其添加到接收器。如果您想更改任何其他属性，则会返回新列。
*/

- (NSTableColumn *)tfy_addTableColumnWithIdentifier:(NSString *)identifier title:(NSString *)title editable:(BOOL)editable resizable:(BOOL)resizable sortable:(BOOL)sortable ascending:(BOOL)ascending width:(CGFloat)width alignment:(NSTextAlignment)alignment
{
    NSTableColumn *tableColumn = [[NSTableColumn alloc] initWithIdentifier:identifier];
    
    [[tableColumn headerCell] setStringValue:title];
    [[tableColumn headerCell] setAlignment:alignment];
    
    [[tableColumn dataCell] setFont:[[tableColumn headerCell] font]];
    [[tableColumn dataCell] setAlignment:alignment];
    
    [tableColumn setEditable:editable];
    [tableColumn setResizingMask:resizable ? NSTableColumnUserResizingMask : NSTableColumnNoResizing];
    
    [tableColumn setMinWidth:width < 50.0 ? width : 50.0];
    [tableColumn setMaxWidth:3000.0];
    [tableColumn setWidth:width];
    
    if (sortable && [tableColumn respondsToSelector:@selector(setSortDescriptorPrototype:)])
    {
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:identifier ascending:ascending];
        
        [tableColumn setSortDescriptorPrototype:descriptor];
    }
    
    [self addTableColumn:tableColumn];
    
    return tableColumn;
}

/**
 创建一个新的文本列，使用字典中指定的属性，键为"Identifier"， "Name"， "Width"和"Editable"。如果“Ascending”键存在，则列是可排序的。
*/

- (NSTableColumn *)tfy_addTableColumnWithColumnInfo:(NSDictionary *)columnInfo
{
    NSString *identifier = columnInfo[@"Identifier"];
    NSString *title = columnInfo[@"Name"];
    NSNumber *ascendingNum = columnInfo[@"Ascending"];
    CGFloat width = [columnInfo[@"Width"] floatValue];
    NSTextAlignment alignment = [columnInfo[@"Alignment"] integerValue];
    BOOL isEditable = [columnInfo[@"Editable"] boolValue];
    BOOL isResizable = width != 16.0;
    BOOL isSortable = ascendingNum != nil;
    BOOL isAscending = [ascendingNum boolValue];
    
    if (width < 12.0)
        width = 100.0;
    
    return [self tfy_addTableColumnWithIdentifier:identifier title:title editable:isEditable resizable:isResizable sortable:isSortable ascending:isAscending width:width alignment:alignment];
}

/**
 在字典数组中创建新的文本列，如上面的-addTableColumnsWithArrayOfColumnInfo:。如果removeAll为YES，则首先删除任何现有列。如果sizeLast为YES，则调整最后一列的大小以适应。
*/

- (void)tfy_addTableColumnsWithArrayOfColumnInfo:(NSArray *)columns removeAll:(BOOL)removeAll sizeLast:(BOOL)sizeLast
{
    if (removeAll)
        [self tfy_removeTableColumns:[self tableColumns]];
    
    NSDictionary *columnInfo = nil;
    
    for (columnInfo in columns)
    {
        [self tfy_addTableColumnWithColumnInfo:columnInfo];
    }
    
    if (sizeLast)
        [self sizeLastColumnToFit];
}

/**
 类似于-addTableColumn:，它在指定的索引处添加指定的表列。该列由接收端保留。
*/

- (void)tfy_insertTableColumn:(NSTableColumn *)aColumn atIndex:(NSUInteger)i;
{
    [self addTableColumn:aColumn];
    
    NSUInteger lastIndex = [self numberOfColumns] - 1;
    
    // Only bother to move if not already in the right place (new columns are added at the end):
    if (i < lastIndex)
        [self moveColumn:lastIndex toColumn:i];
}

/**
 给定一个NSTableColumns数组(由-tableColumns返回)，从接收器中移除它们。
*/

- (void)tfy_removeTableColumns:(NSArray *)columns
{
    // Since this would alter the columns, make a copy of the array in case it is really the actual array of columns:
    NSEnumerator *enumerator = [[columns copy] objectEnumerator];
    NSTableColumn *tableColumn;
    
    while ((tableColumn = [enumerator nextObject]))
    {
    	[self removeTableColumn:tableColumn];
    }
}

/**
 如果表还没有排序描述符，这将以升序或降序将具有指定标识符的列设置为当前排序的列。如果没有具有该标识符的表列(或为nil)，则使用第一个表列(如果有的话)。
*/

- (void)tfy_registerDefaultSortDescriptorForTableColumnWithIdentifier:(NSString *)identifier ascending:(BOOL)ascending
{
    NSTableColumn *tableColumn = [self tableColumnWithIdentifier:identifier];
    
    [self tfy_registerDefaultSortDescriptorForTableColumn:tableColumn ascending:ascending];
}

/**
 如果表还没有排序描述符，这将把指定的列设置为当前排序的列，按升序或降序排列。如果表列为nil，则使用第一个表列(如果有)。
*/

- (void)tfy_registerDefaultSortDescriptorForTableColumn:(NSTableColumn *)tableColumn ascending:(BOOL)ascending
{
    if ([self respondsToSelector:@selector(sortDescriptors)] && ![[self sortDescriptors] count])
    {
        if (!tableColumn)
        {
            NSArray *columns = [self tableColumns];
            
            if ([columns count])
                tableColumn = columns[0];
        }
        
        if (tableColumn)
        {
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:[tableColumn identifier] ascending:ascending];
            
            [self setSortDescriptors:@[descriptor]];
        }
    }
}

- (void)tfy_setHeaderImageNamed:(NSString *)imageName inTableColumnWithIdentifier:(NSString *)identifier
{
    NSTableColumn *column = [self tableColumnWithIdentifier:identifier];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"tiff"];
    NSFileWrapper *fileWrapper = [[NSFileWrapper alloc] initWithURL:url options:0 error:nil];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithFileWrapper:fileWrapper];
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attachment];

    [[column headerCell] setAttributedStringValue:string];
}

- (void)tfy_setDataImageNamed:(NSString *)imageName inTableColumnWithIdentifier:(NSString *)identifier
{
    NSTableColumn *column = [self tableColumnWithIdentifier:identifier];
    NSImage *image = [NSImage imageNamed:imageName];
    NSImageCell *cell = [[NSImageCell alloc] initImageCell:image];
    [column setDataCell:cell];
}

- (void)tfy_setHeaderAndDataImageNamed:(NSString *)imageName inTableColumnWithIdentifier:(NSString *)identifier
{
    [self tfy_setHeaderImageNamed:imageName inTableColumnWithIdentifier:identifier];
    [self tfy_setDataImageNamed:imageName inTableColumnWithIdentifier:identifier];
}

/**
 返回完整的指定字符串，如果原始字符串太长，无法放入表列，则返回被截断并添加指示符字符串的指定字符串。指示器字符串通常是一个省略号(…)。这个方法是在-tableView:objectValueForTableColumn:row:数据源方法中调用的理想方法。
*/

- (NSString *)tfy_truncatedString:(NSString *)string withIndicator:(NSString *)indicator forTableColumn:(NSTableColumn *)tableColumn
{ 
    NSCell *cell = [tableColumn dataCell];
    NSInteger desiredWidth = [cell titleRectForBounds:NSMakeRect(0, 0, [tableColumn width] - 50, [self rowHeight])].size.width;
    
    return [string tfy_truncatedStringWithIndicator:indicator forFont:[cell font] withWidth:desiredWidth];
}

/**
 重写NSView方法，允许为单个行和列设置上下文菜单。你应该在你的表委托中实现-tableView:menuForTableColumn:row:。如果没有实现，则返回默认菜单。
*/

- (NSMenu *)menuForEvent:(NSEvent *)event
{
    NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    NSInteger column = [self columnAtPoint:point];
    NSInteger row = [self rowAtPoint:point];
    
    if (column >= 0 && row >= 0 && [[self tfy_delegate] respondsToSelector:@selector(tableView:menuForTableColumn:row:)])
        return [[self tfy_delegate] tableView:self menuForTableColumn:[self tableColumns][column] row:row];
    else
        return [super menuForEvent:event];
}

/**
 如果接收者的数据源是一个字典，通过“Key”和“Value”列显示，该方法将向该字典添加一个新键，通常由“+”按钮的动作方法调用。如果需要，将数字附加到键后以使其惟一。注意，这可以也应该用绑定来代替。一旦升级了现有的使用，就删除此方法。
*/

- (void)tfy_addKey:(NSString *)key withValue:(NSString *)value toDictionary:(NSMutableDictionary *)dict;
{
    [self reloadData];
    
    NSString *composedKey = key;
    NSInteger extra = 2;
    
    if (![key length] || dict[key])
        while ((composedKey = [NSString stringWithFormat:@"%@%ld", key, extra]) && dict[composedKey])
            extra++;
    
    if (composedKey.length)
    {
        dict[composedKey] = value;
    }
    
    [self reloadData];
    
    NSInteger row = [[dict tfy_sortedKeys] indexOfObject:composedKey];
    NSInteger column = [self tfy_indexOfFirstEditableTableColumn];
    
    [self tfy_selectRowIndex:row byExtendingSelection:NO];
    
    if (column >= 0)
        [self editColumn:column row:row withEvent:nil select:YES];
}

/**
 如果接收者的数据源是一个字典，通过“Key”和“Value”列显示，此方法将从该字典中删除所选行的键，通常由“-”按钮的操作方法调用。只支持删除单行，因此不应该启用多重选择。注意，这可以也应该用绑定来代替。一旦升级了现有的使用，就删除此方法。
*/

- (void)tfy_removeSelectedKeyFromDictionary:(NSMutableDictionary *)dict;
{
    [[self window] tfy_forceEndEditingForView:self];
    
    NSInteger row = [self selectedRow];
    
    if (row == -1)
    {
        return;
    }
    
    NSString *key = [dict tfy_sortedKeys][row];
    
    if (!dict)
    {
        return;
    }
    
    [dict removeObjectForKey:key];
    
    [self reloadData];
}

/**
 
 在编辑键后调整当前编辑。
 */

- (void)tfy_reselectEditWithKey:(NSString *)key forDictionary:(NSDictionary *)dict;
{
    [self tfy_reselectEditWithKey:key forDictionary:dict column:-1];
}

/**
 在编辑键后调整当前编辑。

 字典键。
 包含该键的字典。
 包含该键字段的列。
 */

- (void)tfy_reselectEditWithKey:(NSString *)key forDictionary:(NSDictionary *)dict column:(NSInteger)column;
{
    dispatch_time_t doTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    
    dispatch_after(doTime, dispatch_get_main_queue(), ^
                   {
                       [self reloadData];
                       
                       NSInteger row = [[dict tfy_sortedKeys] indexOfObject:key];
                       NSInteger editColumn = self.editedColumn + 1;
                       
                       if (row != NSNotFound)
                       {
                           if (column >= 0)
                           {
                               editColumn = column + 1;
                           }
                           else if (editColumn < 0)
                           {
                               editColumn = [self tfy_indexOfFirstEditableTableColumn];
                           }
                           
                           [self tfy_selectRowIndex:row byExtendingSelection:NO];
                           
                           if (editColumn >= 0)
                           {
                               [self editColumn:editColumn row:row withEvent:nil select:YES];
                           }
                       }
                   });
}

/**
 返回基于视图的表视图中所有行的当前高度。目前不支持基于单元格的表视图。
*/

- (CGFloat)tfy_contentHeight;
{
    CGFloat height = 0.0;
    
    for (NSInteger row = 0; row < [self numberOfRows]; row++)
    {
        NSView *view = [self viewAtColumn:0 row:row makeIfNecessary:YES];
        
        height += view.frame.size.height + self.intercellSpacing.height;
    }
    
    return height;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSTableView (DejalTableViewCutCopyPasteDeleteDelegate)

- (NSString *)tfy_stringForIndexes:(NSIndexSet *)indexes;
{
    NSMutableString *output = [NSMutableString string];
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop)
     {
         NSString *value = [self tfy_stringValueForRow:idx];
         
         if (value.length)
         {
             [output appendString:value];
             [output appendString:@"\n"];
         }
     }];
    
    return output;
}

- (BOOL)tfy_doCopyIndexes:(NSIndexSet *)indexes;
{
    // Convert the constructed output attributed string to RTFD and a plain string:
    NSPasteboard *pboard = [NSPasteboard generalPasteboard];
    NSString *plainString = [self tfy_stringForIndexes:indexes];
    
    // Declare types:
    [pboard declareTypes:@[NSPasteboardTypeString] owner:self];
    
    // Copy values to pasteboard:
    [pboard setString:plainString forType:NSPasteboardTypeString];
    
    return YES;
}

- (IBAction)cut:(id)sender
{
    NSIndexSet *indexes = [self tfy_shouldCutRowIndexes];
    
    if (!indexes)
        return;
    
    // Only Delete if the Copy was successful:
    if ([self tfy_doCopyIndexes:indexes])
        [self tfy_deleteRowIndexes:indexes];
}

- (IBAction)copy:(id)sender
{
    NSIndexSet *indexes = [self tfy_shouldCopyRowIndexes];
    
    if (!indexes)
        return;
    
    [self tfy_doCopyIndexes:indexes];
}

- (IBAction)paste:(id)sender
{
    NSInteger row = [self tfy_shouldPasteBeforeRow];
    
    if (row < 0)
        return;
    
    NSLog(@"The -paste: method for table views is not implemented yet!");		//  log
}

- (IBAction)delete:(id)sender
{
    NSIndexSet *indexes = self.selectedRowIndexes;
    
    if ([self tfy_canDeleteRowIndexes:indexes])
    {
        [self tfy_deleteRowIndexes:indexes];
    }
}

- (BOOL)tfy_savePlainTextToURL:(NSURL *)url;
{
    NSIndexSet *indexes = [self tfy_shouldSaveRowIndexes];
    
    if (!indexes)
        return NO;
    
    NSString *plainString = [self tfy_stringForIndexes:indexes];
    
    return [plainString writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

- (BOOL)tfy_saveRichTextToURL:(NSURL *)url;
{
    NSIndexSet *indexes = [self tfy_shouldSaveRowIndexes];
    
    if (!indexes)
        return NO;
    
    NSLog(@"-saveRichTextToURL: does not work yet!");         // log
    
    return NO;
}

- (BOOL)validateMenuItem:(NSMenuItem *)item;
{
    SEL action = [item action];
    
    if (action == @selector(cut:))
        return ([self tfy_shouldCutRowIndexes] != nil);
    else if (action == @selector(copy:))
        return ([self tfy_shouldCopyRowIndexes] != nil);
    else if (action == @selector(paste:))
        return ([self tfy_shouldPasteBeforeRow] >= 0);
    else if (action == @selector(delete:))
        return ([self tfy_canDeleteRowIndexes:self.selectedRowIndexes]);
    else
        return YES;
}

/**
 如果合适，重写按键方法以检测和处理Delete键。
 */

- (void)keyDown:(NSEvent *)theEvent;
{
    if (theEvent.keyCode == 51)
    {
        [self delete:nil];
    }
    else
    {
        [super keyDown:theEvent];
    }
}

/**
 如果委托响应-tableView:shouldCutRowIndexes:，它将使用所选的行索引作为参数调用。如果这些行是可切割的，委托应该完整地返回它，或者修改它(通过创建可变副本)以删除一些行，或者如果不允许切割，则返回nil。如果没有选择，则不询问委托就返回nil。你不需要调用这个方法。
*/

- (NSIndexSet *)tfy_shouldCutRowIndexes
{
    NSIndexSet *indexes = self.selectedRowIndexes;
    
    if ([indexes count] && [[self tfy_delegate] respondsToSelector:@selector(tableView:shouldCutRowIndexes:)])
        return [[self tfy_delegate] tableView:self shouldCutRowIndexes:indexes];
    else
        return nil;
}

/**
 如果委托响应-tableView:shouldCopyRowIndexes:，它将使用所选的行索引作为参数调用。如果这些行是可复制的，委托应该完整地返回它，或者修改它(通过进行可变复制)以删除一些行，或者如果不允许复制，则返回nil。如果没有选择，则不询问委托就返回nil。
*/

- (NSIndexSet *)tfy_shouldCopyRowIndexes
{
    NSIndexSet *indexes = self.selectedRowIndexes;
    
    if ([indexes count] && [[self tfy_delegate] respondsToSelector:@selector(tableView:shouldCopyRowIndexes:)])
        return [[self tfy_delegate] tableView:self shouldCopyRowIndexes:indexes];
    else
        return nil;
}

/**
 如果委托响应-tableView:shouldPasteBeforeRow:，则将第一行作为参数调用它(如果没有选择则为0，因此它将粘贴在第一行之前)。如果在行之前粘贴是可以接受的，委托应该完整地返回它，或者返回不同的行，或者如果不允许粘贴，则返回-1。
*/

- (NSInteger)tfy_shouldPasteBeforeRow
{
    NSInteger row = [self selectedRow];
    
    if (row < 0)
        row = 0;
    
    if ([[self tfy_delegate] respondsToSelector:@selector(tableView:shouldPasteBeforeRow:)])
        return [[self tfy_delegate] tableView:self shouldPasteBeforeRow:row];
    else
        return -1;
}

/**
 如果委托响应-tableView:canDeleteRowIndexes:，它将使用所选的行索引作为参数调用。如果所有这些行都是可删除的，委托应该返回YES，如果不允许删除，则返回NO。如果没有选择，则返回no而不询问委托。
*/

- (BOOL)tfy_canDeleteRowIndexes:(NSIndexSet *)indexes;
{
    if ([indexes count] && [[self tfy_delegate] respondsToSelector:@selector(tableView:canDeleteRowIndexes:)])
    {
        return [[self tfy_delegate] tableView:self canDeleteRowIndexes:indexes];
    }
    else
    {
        return NO;
    }
}

/**
 如果委托响应-tableView:deleteRowIndexes:，它将以指定的行索引作为参数调用。然后委托应该从其数据源中删除这些行，如果需要，还可以选择先显示确认。如果它处理了删除(即使被取消或延迟)，它应该返回YES。
*/

- (BOOL)tfy_deleteRowIndexes:(NSIndexSet *)indexes;
{
    if ([indexes count] && [[self tfy_delegate] respondsToSelector:@selector(tableView:deleteRowIndexes:)])
        return [[self tfy_delegate] tableView:self deleteRowIndexes:indexes];
    else
        return NO;
}

/**
 如果委托响应-tableView:shouldSaveRowIndexes:，它将以所选的行索引作为参数调用，如果没有或只有一行被选择，则调用所有行(注意:这与上面与粘贴板相关的方法不同)。如果这些行是可保存的，委托应该完整地返回它，或者修改它(通过创建可变副本)以删除一些行，或者如果不允许保存则返回nil。如果没有行，则返回nil而不询问委托。
*/

- (NSIndexSet *)tfy_shouldSaveRowIndexes;
{
    NSIndexSet *indexes = [self tfy_multipleSelectedOrAllRowIndexes];
    
    if ([indexes count] && [[self tfy_delegate] respondsToSelector:@selector(tableView:shouldSaveRowIndexes:)])
        return [[self tfy_delegate] tableView:self shouldSaveRowIndexes:indexes];
    else
        return nil;
}

/**
 如果委托响应-tableView:stringValueForRow:，则使用指定的行调用它。委托应返回指定行的字符串表示形式。
 */

- (NSString *)tfy_stringValueForRow:(NSUInteger)row;
{
    if ([[self tfy_delegate] respondsToSelector:@selector(tableView:stringValueForRow:)])
        return [[self tfy_delegate] tableView:self stringValueForRow:row];
    else
        return nil;
}

@end

