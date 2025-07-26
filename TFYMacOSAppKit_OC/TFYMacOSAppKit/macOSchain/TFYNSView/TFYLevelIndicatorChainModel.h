//
//  TFYLevelIndicatorChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYLevelIndicatorChainModel;
@interface TFYLevelIndicatorChainModel : TFYBaseControlChainModel<TFYLevelIndicatorChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ levelIndicatorStyle) (NSLevelIndicatorStyle);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ minValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ maxValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ warningValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ criticalValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ tickMarkPosition) (NSTickMarkPosition);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ numberOfTickMarks) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ numberOfMajorTickMarks) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ drawsTieredCapacityLevels) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ placeholderVisibility) (NSLevelIndicatorPlaceholderVisibility);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ ratingImage) (NSImage*);
TFY_PROPERTY_CHAIN_READONLY TFYLevelIndicatorChainModel * (^ ratingPlaceholderImage) (NSImage*);

@end
TFY_CATEGORY_EXINTERFACE(NSLevelIndicator, TFYLevelIndicatorChainModel)
NS_ASSUME_NONNULL_END
