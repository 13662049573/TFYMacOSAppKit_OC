//
//  TFYTableViewlChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTableViewlChainModel;
@interface TFYTableViewlChainModel : TFYBaseControlChainModel<TFYTableViewlChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ dataSource) (id <NSTableViewDataSource>);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ delegate) (id <NSTableViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ headerView) (NSTableHeaderView*);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ cornerView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ allowsColumnReordering) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ allowsColumnResizing) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ columnAutoresizingStyle) (NSTableViewColumnAutoresizingStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ gridStyleMask) (NSTableViewGridLineStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ intercellSpacing) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ usesAlternatingRowBackgroundColors) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ gridColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ rowSizeStyle) (NSTableViewRowSizeStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ rowHeight) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ doubleAction) (SEL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ sortDescriptors) (NSArray<NSSortDescriptor *> *);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ highlightedTableColumn) (NSTableColumn*);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ verticalMotionCanBeginDrag) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ allowsMultipleSelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ allowsEmptySelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ allowsColumnSelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ allowsTypeSelect) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ style) (NSTableViewStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ selectionHighlightStyle) (NSTableViewSelectionHighlightStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ draggingDestinationFeedbackStyle) (NSTableViewDraggingDestinationFeedbackStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ autosaveName) (NSTableViewAutosaveName);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ autosaveTableColumns) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ floatsGroupRows) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ rowActionsVisible) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ usesStaticContents) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ userInterfaceLayoutDirection) (NSUserInterfaceLayoutDirection);
TFY_PROPERTY_CHAIN_READONLY TFYTableViewlChainModel * (^ usesAutomaticRowHeights) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSTableView, TFYTableViewlChainModel)
NS_ASSUME_NONNULL_END
