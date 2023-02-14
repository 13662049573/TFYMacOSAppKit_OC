//
//  TFYEmiiterLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TFYEmiiterLayerChainModel;
@interface TFYEmiiterLayerChainModel : TFYBaseLayerChainModel<TFYEmiiterLayerChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterCells) (NSArray<CAEmitterCell *> * emitterCells);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ birthRate) (float birthRate);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ lifetime) (float lifetime);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterPosition) (CGPoint emitterPosition);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterZPosition) (CGFloat emitterZPosition);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterSize) (CGSize emitterSize);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterDepth) (CGFloat emitterDepth);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterShape) (CAEmitterLayerEmitterShape emitterShape);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ emitterMode) (CAEmitterLayerEmitterMode emitterMode);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ renderMode) (CAEmitterLayerRenderMode renderMode);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ preservesDepth) (BOOL preservesDepth);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ velocity) (float velocity);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ scale) (float scale);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ spin) (float spin);
TFY_PROPERTY_CHAIN_READONLY TFYEmiiterLayerChainModel * (^ seed) (unsigned int seed);

@end

TFY_CATEGORY_EXINTERFACE(CAEmitterLayer, TFYEmiiterLayerChainModel)

NS_ASSUME_NONNULL_END
