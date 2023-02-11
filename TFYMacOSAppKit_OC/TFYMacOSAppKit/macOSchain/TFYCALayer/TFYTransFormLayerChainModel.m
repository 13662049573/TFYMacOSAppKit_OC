//
//  TFYTransFormLayerChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYTransFormLayerChainModel.h"

#define TFY_CATEGORY_CHAIN_TRANSFORMLAYER_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_LAYERCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTransFormLayerChainModel *, CATransformLayer)

@implementation TFYTransFormLayerChainModel

@end
TFY_CATEGORY_LAYER_IMPLEMENTATION(CATransformLayer, TFYTransFormLayerChainModel)
#undef TFY_CATEGORY_CHAIN_TRANSFORMLAYER_IMPLEMENTATION
