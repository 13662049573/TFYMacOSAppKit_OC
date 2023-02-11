//
//  TFYTiledLayerChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYTiledLayerChainModel.h"

#define TFY_CATEGORY_CHAIN_TILEDLAYER_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_LAYERCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTiledLayerChainModel *, CATiledLayer)

@implementation TFYTiledLayerChainModel

TFY_CATEGORY_CHAIN_TILEDLAYER_IMPLEMENTATION(levelsOfDetail, size_t)
TFY_CATEGORY_CHAIN_TILEDLAYER_IMPLEMENTATION(levelsOfDetailBias,size_t)
TFY_CATEGORY_CHAIN_TILEDLAYER_IMPLEMENTATION(tileSize,CGSize)
@end
TFY_CATEGORY_LAYER_IMPLEMENTATION(CATiledLayer, TFYTiledLayerChainModel)
#undef TFY_CATEGORY_CHAIN_TILEDLAYER_IMPLEMENTATION
