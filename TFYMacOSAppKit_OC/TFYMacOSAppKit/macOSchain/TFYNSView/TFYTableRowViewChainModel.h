//
//  TFYTableRowViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTableRowViewChainModel;
@interface TFYTableRowViewChainModel : TFYBaseViewChainModel<TFYTableRowViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ selectionHighlightStyle) (NSTableViewSelectionHighlightStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ emphasized) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ groupRowStyle) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ selected) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ previousRowSelected) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ nextRowSelected) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ floating) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ targetForDropOperation) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ draggingDestinationFeedbackStyle) (NSTableViewDraggingDestinationFeedbackStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ indentationForDropOperation) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYTableRowViewChainModel * (^ backgroundColor) (NSColor*);

@end
TFY_CATEGORY_EXINTERFACE(NSTableRowView, TFYTableRowViewChainModel)
NS_ASSUME_NONNULL_END
