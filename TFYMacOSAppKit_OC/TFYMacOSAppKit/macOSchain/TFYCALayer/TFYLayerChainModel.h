//
//  TFYLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYLayerChainModel;
@interface TFYLayerChainModel : TFYBaseLayerChainModel<TFYLayerChainModel *>

@end
TFY_CATEGORY_EXINTERFACE(CALayer, TFYLayerChainModel)
NS_ASSUME_NONNULL_END
