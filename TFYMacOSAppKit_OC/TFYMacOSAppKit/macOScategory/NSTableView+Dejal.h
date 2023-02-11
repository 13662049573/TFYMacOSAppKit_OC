//
//  NSTableView+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

@protocol DejalTableViewDelegate <NSTableViewDelegate>
@optional

- (NSMenu *)tableView:(NSTableView *)tableView menuForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;

- (NSIndexSet *)tableView:(NSTableView *)tableView shouldCutRowIndexes:(NSIndexSet *)indexes;
- (NSIndexSet *)tableView:(NSTableView *)tableView shouldCopyRowIndexes:(NSIndexSet *)indexes;
- (NSInteger)tableView:(NSTableView *)tableView shouldPasteBeforeRow:(NSInteger)row;
- (NSIndexSet *)tableView:(NSTableView *)tableView shouldSaveRowIndexes:(NSIndexSet *)indexes;

- (BOOL)tableView:(NSTableView *)tableView canDeleteRowIndexes:(NSIndexSet *)indexes;
- (BOOL)tableView:(NSTableView *)tableView deleteRowIndexes:(NSIndexSet *)indexes;

- (NSString *)tableView:(NSTableView *)tableView stringValueForRow:(NSInteger)row;

- (NSImage *)tableView:(NSTableView *)tableView dragImageForRowsWithIndexes:(NSIndexSet *)dragRows tableColumns:(NSArray *)tableColumns event:(NSEvent *)dragEvent offset:(NSPointPointer)dragImageOffset;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSTableView (Dejal)

- (id <DejalTableViewDelegate>)tfy_delegate;

- (IBAction)selectNone:(id)sender;
/**
 返回包含所有行的索引集。
*/
- (NSIndexSet *)tfy_allRowIndexes;
/**
 返回一个索引集，如果有选定的行，则只包括选定的行;如果没有选定，则返回所有行。
*/
- (NSIndexSet *)tfy_selectedOrAllRowIndexes;
/**
 返回一个索引集，如果有多个选定行，则该索引集只包括选定的行;如果没有选定行，则返回所有行。
*/
- (NSIndexSet *)tfy_multipleSelectedOrAllRowIndexes;
/**
 返回所有表行的行号枚举数。
*/
- (NSEnumerator *)tfy_rowEnumerator;
/**
 返回选定表行的行号枚举数。替换已弃用的- seltedrowenumerator方法。
*/

- (NSEnumerator *)tfy_selectedRowsEnumerator;
/**
 返回一个枚举数，如果有选定的行，则只包括选定的行;如果没有选定，则返回所有行。
*/
- (NSEnumerator *)tfy_selectedOrAllRowsEnumerator;
/**
 返回一个枚举数，如果有多个选定行，则只包括选定的行;如果没有或只有一个选定行，则返回所有行。
*/

- (NSEnumerator *)tfy_multipleSelectedOrAllRowsEnumerator;
/**
 选择第一行，或者同时选择任何现有的选择，或者相反。
*/
- (void)tfy_selectFirstRowExtendingSelection:(BOOL)extendSel;
/**
 选择最后一行，或者同时选择任何现有的选择，或者相反。
*/
- (void)tfy_selectLastRowExtendingSelection:(BOOL)extendSel;
/**
 选择指定的行，或者同时选择任何现有的选择。替换已弃用的-selectRow:extendingSelection:方法。
*/
- (void)tfy_selectRowIndex:(NSUInteger)rowIndex byExtendingSelection:(BOOL)extendSel;
/**
 编辑具有列标识符和行的单元格，必要时首先选择行。一个稍微方便一点的-editColumn:row:withEvent:select:版本。如果行超出范围或无法找到列，则不执行任何操作。
*/
- (void)tfy_editColumnWithIdentifier:(NSString *)columnIdentfier row:(NSInteger)row;
/**
 返回表中所有列的枚举数。
*/

- (NSEnumerator *)tfy_tableColumnEnumerator;
/**
 返回索引表列。
*/
- (NSTableColumn *)tfy_tableColumnAtIndex:(NSUInteger)i;
/**
 返回表中第一个可编辑列的索引，如果没有则返回NSNotFound。
*/
- (NSUInteger)tfy_indexOfFirstEditableTableColumn;
/**
 返回表中第一个可编辑列，如果没有则返回nil。
*/
- (NSTableColumn *)tfy_firstEditableTableColumn;
/**
 创建具有指定属性的新文本列，并将其添加到接收器。如果您想更改任何其他属性，则会返回新列。
*/
- (NSTableColumn *)tfy_addTableColumnWithIdentifier:(NSString *)identifier title:(NSString *)title editable:(BOOL)editable resizable:(BOOL)resizable width:(CGFloat)width;
/**
 创建具有指定属性的新文本列，并将其添加到接收器。如果您想更改任何其他属性，则会返回新列。
*/

- (NSTableColumn *)tfy_addTableColumnWithIdentifier:(NSString *)identifier title:(NSString *)title editable:(BOOL)editable resizable:(BOOL)resizable sortable:(BOOL)sortable ascending:(BOOL)ascending width:(CGFloat)width alignment:(NSTextAlignment)alignment;
/**
 创建一个新的文本列，使用字典中指定的属性，键为"Identifier"， "Name"， "Width"和"Editable"。如果“Ascending”键存在，则列是可排序的。
*/
- (NSTableColumn *)tfy_addTableColumnWithColumnInfo:(NSDictionary *)columnInfo;
/**
 在字典数组中创建新的文本列，如上面的-addTableColumnsWithArrayOfColumnInfo:。如果removeAll为YES，则首先删除任何现有列。如果sizeLast为YES，则调整最后一列的大小以适应。
*/
- (void)tfy_addTableColumnsWithArrayOfColumnInfo:(NSArray *)columns removeAll:(BOOL)removeAll sizeLast:(BOOL)sizeLast;
/**
 类似于-addTableColumn:，它在指定的索引处添加指定的表列。该列由接收端保留。
*/
- (void)tfy_insertTableColumn:(NSTableColumn *)aColumn atIndex:(NSUInteger)i;
/**
 给定一个NSTableColumns数组(由-tableColumns返回)，从接收器中移除它们。
*/
- (void)tfy_removeTableColumns:(NSArray *)columns;
/**
 如果表还没有排序描述符，这将以升序或降序将具有指定标识符的列设置为当前排序的列。如果没有具有该标识符的表列(或为nil)，则使用第一个表列(如果有的话)。
*/

- (void)tfy_registerDefaultSortDescriptorForTableColumnWithIdentifier:(NSString *)identifier ascending:(BOOL)ascending;
/**
 如果表还没有排序描述符，这将把指定的列设置为当前排序的列，按升序或降序排列。如果表列为nil，则使用第一个表列(如果有)。
*/
- (void)tfy_registerDefaultSortDescriptorForTableColumn:(NSTableColumn *)tableColumn ascending:(BOOL)ascending;

- (void)tfy_setHeaderImageNamed:(NSString *)imageName inTableColumnWithIdentifier:(NSString *)identifier;
- (void)tfy_setDataImageNamed:(NSString *)imageName inTableColumnWithIdentifier:(NSString *)identifier;

- (void)tfy_setHeaderAndDataImageNamed:(NSString *)imageName inTableColumnWithIdentifier:(NSString *)identifier;
/**
 返回完整的指定字符串，如果原始字符串太长，无法放入表列，则返回被截断并添加指示符字符串的指定字符串。指示器字符串通常是一个省略号(…)。这个方法是在-tableView:objectValueForTableColumn:row:数据源方法中调用的理想方法。
*/

- (NSString *)tfy_truncatedString:(NSString *)string withIndicator:(NSString *)indicator forTableColumn:(NSTableColumn *)tableColumn;
/**
 重写NSView方法，允许为单个行和列设置上下文菜单。你应该在你的表委托中实现-tableView:menuForTableColumn:row:。如果没有实现，则返回默认菜单。
*/
- (NSMenu *)menuForEvent:(NSEvent *)event;
/**
 如果接收者的数据源是一个字典，通过“Key”和“Value”列显示，该方法将向该字典添加一个新键，通常由“+”按钮的动作方法调用。如果需要，将数字附加到键后以使其惟一。注意，这可以也应该用绑定来代替。一旦升级了现有的使用，就删除此方法。
*/
- (void)tfy_addKey:(NSString *)key withValue:(NSString *)value toDictionary:(NSMutableDictionary *)dict;
/**
 如果接收者的数据源是一个字典，通过“Key”和“Value”列显示，此方法将从该字典中删除所选行的键，通常由“-”按钮的操作方法调用。只支持删除单行，因此不应该启用多重选择。注意，这可以也应该用绑定来代替。一旦升级了现有的使用，就删除此方法。
*/

- (void)tfy_removeSelectedKeyFromDictionary:(NSMutableDictionary *)dict;
/**
 
 在编辑键后调整当前编辑。
 */
- (void)tfy_reselectEditWithKey:(NSString *)key forDictionary:(NSDictionary *)dict;
/**
 在编辑键后调整当前编辑。

 字典键。
 包含该键的字典。
 包含该键字段的列。
 */
- (void)tfy_reselectEditWithKey:(NSString *)key forDictionary:(NSDictionary *)dict column:(NSInteger)column;
/**
 返回基于视图的表视图中所有行的当前高度。目前不支持基于单元格的表视图。
*/
- (CGFloat)tfy_contentHeight;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSTableView (DejalCutCopyPasteDelete)

- (IBAction)cut:(id)sender;
- (IBAction)copy:(id)sender;
- (IBAction)paste:(id)sender;
- (IBAction)delete:(id)sender;

- (BOOL)tfy_savePlainTextToURL:(NSURL *)url;
- (BOOL)tfy_saveRichTextToURL:(NSURL *)url;

- (BOOL)validateMenuItem:(NSMenuItem *)item;
/**
 如果委托响应-tableView:shouldCutRowIndexes:，它将使用所选的行索引作为参数调用。如果这些行是可切割的，委托应该完整地返回它，或者修改它(通过创建可变副本)以删除一些行，或者如果不允许切割，则返回nil。如果没有选择，则不询问委托就返回nil。你不需要调用这个方法。
*/

- (NSIndexSet *)tfy_shouldCutRowIndexes;
/**
 如果委托响应-tableView:shouldCopyRowIndexes:，它将使用所选的行索引作为参数调用。如果这些行是可复制的，委托应该完整地返回它，或者修改它(通过进行可变复制)以删除一些行，或者如果不允许复制，则返回nil。如果没有选择，则不询问委托就返回nil。
*/
- (NSIndexSet *)tfy_shouldCopyRowIndexes;
/**
 如果委托响应-tableView:shouldPasteBeforeRow:，则将第一行作为参数调用它(如果没有选择则为0，因此它将粘贴在第一行之前)。如果在行之前粘贴是可以接受的，委托应该完整地返回它，或者返回不同的行，或者如果不允许粘贴，则返回-1。
*/

- (NSInteger)tfy_shouldPasteBeforeRow;
/**
 如果委托响应-tableView:shouldSaveRowIndexes:，它将以所选的行索引作为参数调用，如果没有或只有一行被选择，则调用所有行(注意:这与上面与粘贴板相关的方法不同)。如果这些行是可保存的，委托应该完整地返回它，或者修改它(通过创建可变副本)以删除一些行，或者如果不允许保存则返回nil。如果没有行，则返回nil而不询问委托。
*/
- (NSIndexSet *)tfy_shouldSaveRowIndexes;
/**
 如果委托响应-tableView:stringValueForRow:，则使用指定的行调用它。委托应返回指定行的字符串表示形式。
 */
- (NSString *)tfy_stringValueForRow:(NSUInteger)row;
/**
 如果委托响应-tableView:canDeleteRowIndexes:，它将使用所选的行索引作为参数调用。如果所有这些行都是可删除的，委托应该返回YES，如果不允许删除，则返回NO。如果没有选择，则返回no而不询问委托。
*/
- (BOOL)tfy_canDeleteRowIndexes:(NSIndexSet *)indexes;
/**
 如果委托响应-tableView:deleteRowIndexes:，它将以指定的行索引作为参数调用。然后委托应该从其数据源中删除这些行，如果需要，还可以选择先显示确认。如果它处理了删除(即使被取消或延迟)，它应该返回YES。
*/

- (BOOL)tfy_deleteRowIndexes:(NSIndexSet *)indexes;

@end

