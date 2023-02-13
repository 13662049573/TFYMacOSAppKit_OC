//
//  TFYSegmentedControlChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYSegmentedControlChainModel;
@interface TFYSegmentedControlChainModel : TFYBaseControlChainModel<TFYSegmentedControlChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ segmentCount) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ selectedSegment) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ segmentStyle) (NSSegmentStyle);
TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ springLoaded) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ trackingMode) (NSSegmentSwitchTracking);
TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ selectedSegmentBezelColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYSegmentedControlChainModel * (^ segmentDistribution) (NSSegmentDistribution);

@end
TFY_CATEGORY_EXINTERFACE(NSSegmentedControl, TFYSegmentedControlChainModel)
NS_ASSUME_NONNULL_END
