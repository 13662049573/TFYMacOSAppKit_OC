//
//  TFYGradientLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYGradientLayerChainModel;
@interface TFYGradientLayerChainModel : TFYBaseLayerChainModel<TFYGradientLayerChainModel *>
TFY_PROPERTY_CHAIN_READONLY TFYGradientLayerChainModel * (^ colors) (NSArray * colors);
TFY_PROPERTY_CHAIN_READONLY TFYGradientLayerChainModel * (^ locations) (NSArray<NSNumber *> * locations);
TFY_PROPERTY_CHAIN_READONLY TFYGradientLayerChainModel * (^ startPoint) (CGPoint startPoint);
TFY_PROPERTY_CHAIN_READONLY TFYGradientLayerChainModel * (^ endPoint) (CGPoint endPoint);
@end
TFY_CATEGORY_EXINTERFACE(CAGradientLayer, TFYGradientLayerChainModel)
NS_ASSUME_NONNULL_END
