//
//  TFYOutlineViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYTableViewlChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYOutlineViewChainModel : TFYTableViewlChainModel

TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ delegateOutline) (id <NSOutlineViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ dataSourceOutline) (id <NSOutlineViewDataSource>);
TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ outlineTableColumn) (NSTableColumn*);
TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ indentationPerLevel) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ indentationMarkerFollowsCell) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ autoresizesOutlineColumn) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYOutlineViewChainModel * (^ autosaveExpandedItems) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSOutlineView, TFYOutlineViewChainModel)
NS_ASSUME_NONNULL_END
