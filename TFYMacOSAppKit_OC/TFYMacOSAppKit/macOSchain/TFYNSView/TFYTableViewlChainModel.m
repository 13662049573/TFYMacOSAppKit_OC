//
//  TFYTableViewlChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYTableViewlChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTableViewlChainModel *,NSTableView)

@implementation TFYTableViewlChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(dataSource, id <NSTableViewDataSource>)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(delegate, id <NSTableViewDelegate>)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(headerView, NSTableHeaderView*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(cornerView, NSView*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsColumnReordering, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsColumnResizing, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(verticalMotionCanBeginDrag, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsMultipleSelection, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsEmptySelection, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsColumnSelection, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsTypeSelect, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(autosaveTableColumns, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(floatsGroupRows, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(rowActionsVisible, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(usesStaticContents, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(usesAutomaticRowHeights, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(usesAlternatingRowBackgroundColors, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(columnAutoresizingStyle, NSTableViewColumnAutoresizingStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(gridStyleMask, NSTableViewGridLineStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(intercellSpacing, NSSize)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(backgroundColor, NSColor*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(gridColor, NSColor*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(rowSizeStyle, NSTableViewRowSizeStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(rowHeight, CGFloat)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(doubleAction, SEL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(sortDescriptors, NSArray<NSSortDescriptor *> *)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(highlightedTableColumn, NSTableColumn*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(style, NSTableViewStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(selectionHighlightStyle, NSTableViewSelectionHighlightStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(draggingDestinationFeedbackStyle, NSTableViewDraggingDestinationFeedbackStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(autosaveName, NSTableViewAutosaveName)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(userInterfaceLayoutDirection, NSUserInterfaceLayoutDirection)

- (TFYTableViewlChainModel * _Nonnull (^)(NSTableColumn*))addTableColumn {
    return ^(NSTableColumn*colum)
    {
        [self enumerateObjectsUsingBlock:^(NSTableView * _Nonnull obj) {
            [obj addTableColumn:colum];
        }];
        return self;
    };
}

- (TFYTableViewlChainModel * _Nonnull (^)(NSTableColumn*))removeTableColumn {
    return ^(NSTableColumn*colum)
    {
        [self enumerateObjectsUsingBlock:^(NSTableView * _Nonnull obj) {
            [obj removeTableColumn:colum];
        }];
        return self;
    };
}

- (TFYTableViewlChainModel * _Nonnull (^)(NSInteger,NSInteger))moveColumn_toColumn {
    return ^(NSInteger oldIndex,NSInteger newIndex)
    {
        [self enumerateObjectsUsingBlock:^(NSTableView * _Nonnull obj) {
            [obj moveColumn:oldIndex toColumn:newIndex];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSTableView, TFYTableViewlChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

