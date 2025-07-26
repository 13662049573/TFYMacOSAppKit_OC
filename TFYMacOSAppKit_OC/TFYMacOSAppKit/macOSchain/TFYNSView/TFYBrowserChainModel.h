//
//  TFYBrowserChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYBrowserChainModel;
@interface TFYBrowserChainModel : TFYBaseControlChainModel<TFYBrowserChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ doubleAction) (SEL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ cellPrototype) (id);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ delegate) (id<NSBrowserDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ reusesColumns) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ hasHorizontalScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ autohidesScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ separatesColumns) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ titled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ minColumnWidth) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ maxVisibleColumns) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ allowsMultipleSelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ allowsBranchSelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ allowsEmptySelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ takesTitleFromPreviousColumn) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ sendsActionOnArrowKeys) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ pathSeparator) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ selectionIndexPath) (NSIndexPath*);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ selectionIndexPaths) (NSArray<NSIndexPath *> *);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ lastColumn) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ columnResizingType) (NSBrowserColumnResizingType);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ prefersAllColumnUserResizing) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ rowHeight) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ columnsAutosaveName) (NSBrowserColumnsAutosaveName);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ allowsTypeSelect) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBrowserChainModel * (^ backgroundColor) (NSColor*);

@end
TFY_CATEGORY_EXINTERFACE(NSBrowser, TFYBrowserChainModel)
NS_ASSUME_NONNULL_END
