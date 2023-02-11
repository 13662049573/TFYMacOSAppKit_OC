//
//  TFYTransFormLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTransFormLayerChainModel;
@interface TFYTransFormLayerChainModel : TFYBaseLayerChainModel<TFYTransFormLayerChainModel *>

@end
TFY_CATEGORY_EXINTERFACE(CATransformLayer, TFYTransFormLayerChainModel)
NS_ASSUME_NONNULL_END
