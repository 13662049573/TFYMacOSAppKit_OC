//
//  TFYScrollLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYScrollLayerChainModel;
@interface TFYScrollLayerChainModel : TFYBaseLayerChainModel<TFYScrollLayerChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYScrollLayerChainModel * (^ scrollToPoint) (CGPoint point);
TFY_PROPERTY_CHAIN_READONLY TFYScrollLayerChainModel * (^ scrollToRect) (CGRect rect);
TFY_PROPERTY_CHAIN_READONLY TFYScrollLayerChainModel * (^ scrollMode) (CAScrollLayerScrollMode scrollMode);
@end

TFY_CATEGORY_EXINTERFACE(CAScrollLayer, TFYScrollLayerChainModel)

NS_ASSUME_NONNULL_END
