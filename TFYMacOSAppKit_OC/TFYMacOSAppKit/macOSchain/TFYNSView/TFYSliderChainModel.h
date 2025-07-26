//
//  TFYSliderChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYSliderChainModel;
@interface TFYSliderChainModel : TFYBaseControlChainModel<TFYSliderChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ sliderType) (NSSliderType);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ minValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ maxValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ altIncrementValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ trackFillColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ vertical) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ numberOfTickMarks) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ tickMarkPosition) (NSTickMarkPosition);
TFY_PROPERTY_CHAIN_READONLY TFYSliderChainModel * (^ allowsTickMarkValuesOnly) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSSlider, TFYSliderChainModel)
NS_ASSUME_NONNULL_END
