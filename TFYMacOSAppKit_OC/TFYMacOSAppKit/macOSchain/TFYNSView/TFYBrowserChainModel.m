//
//  TFYBrowserChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBrowserChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYBrowserChainModel *,NSBrowser)

@implementation TFYBrowserChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(doubleAction, SEL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(cellPrototype, id)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(delegate, id<NSBrowserDelegate>)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(reusesColumns, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(hasHorizontalScroller, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(autohidesScroller, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(separatesColumns, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(titled, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(minColumnWidth, CGFloat)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(maxVisibleColumns, NSInteger)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsMultipleSelection, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsBranchSelection, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsEmptySelection, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(takesTitleFromPreviousColumn, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(sendsActionOnArrowKeys, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(pathSeparator, NSString*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(selectionIndexPath, NSIndexPath*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(selectionIndexPaths, NSArray<NSIndexPath *> *)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(lastColumn, NSInteger)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(columnResizingType, NSBrowserColumnResizingType)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(prefersAllColumnUserResizing, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(rowHeight, CGFloat)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(columnsAutosaveName, NSBrowserColumnsAutosaveName)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(allowsTypeSelect, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(backgroundColor, NSColor*)

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSBrowser, TFYBrowserChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
