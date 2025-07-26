//
//  TFYVisualEffectViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYVisualEffectViewChainModel;
@interface TFYVisualEffectViewChainModel : TFYBaseViewChainModel<TFYVisualEffectViewChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYVisualEffectViewChainModel * (^ material) (NSVisualEffectMaterial);
TFY_PROPERTY_CHAIN_READONLY TFYVisualEffectViewChainModel * (^ blendingMode) (NSVisualEffectBlendingMode);
TFY_PROPERTY_CHAIN_READONLY TFYVisualEffectViewChainModel * (^ state) (NSVisualEffectState);
TFY_PROPERTY_CHAIN_READONLY TFYVisualEffectViewChainModel * (^ emphasized) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSVisualEffectView, TFYVisualEffectViewChainModel)
NS_ASSUME_NONNULL_END
