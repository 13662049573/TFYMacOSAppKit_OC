//
//  TFYTiledLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTiledLayerChainModel;
@interface TFYTiledLayerChainModel : TFYBaseLayerChainModel<TFYTiledLayerChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYTiledLayerChainModel * (^ levelsOfDetail) (size_t levelsOfDetail);
TFY_PROPERTY_CHAIN_READONLY TFYTiledLayerChainModel * (^ levelsOfDetailBias) (size_t levelsOfDetailBias);
TFY_PROPERTY_CHAIN_READONLY TFYTiledLayerChainModel * (^ tileSize) (CGSize tileSize);
@end

TFY_CATEGORY_EXINTERFACE(CATiledLayer, TFYTiledLayerChainModel)

NS_ASSUME_NONNULL_END
