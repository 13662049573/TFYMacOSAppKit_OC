//
//  TFYTabViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTabViewChainModel;
@interface TFYTabViewChainModel : TFYBaseViewChainModel<TFYTabViewChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ font) (NSFont*);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ tabViewType) (NSTabViewType);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ tabPosition) (NSTabPosition);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ tabViewBorderType) (NSTabViewBorderType);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ tabViewItems) (NSArray<__kindof NSTabViewItem *> *);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ allowsTruncatedLabels) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ controlSize) (NSControlSize);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ delegate) (id<NSTabViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectTabViewItem) (NSTabViewItem*);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectTabViewItemAtIndex) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectTabViewItemWithIdentifier) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ takeSelectedTabViewItemFromSender) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectFirstTabViewItem) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectLastTabViewItem) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectNextTabViewItem) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ selectPreviousTabViewItem) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ addTabViewItem) (NSTabViewItem*);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ insertTabViewItem_atIndex) (NSTabViewItem*,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYTabViewChainModel * (^ removeTabViewItem) (NSTabViewItem*);

@end
TFY_CATEGORY_EXINTERFACE(NSTabView, TFYTabViewChainModel)
NS_ASSUME_NONNULL_END
