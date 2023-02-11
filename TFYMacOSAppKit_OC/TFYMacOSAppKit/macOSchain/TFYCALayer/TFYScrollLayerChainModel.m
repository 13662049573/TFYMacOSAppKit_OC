//
//  TFYScrollLayerChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYScrollLayerChainModel.h"

#define TFY_CATEGORY_CHAIN_SCROLLLAYER_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_LAYERCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYScrollLayerChainModel *, CAScrollLayer)

@implementation TFYScrollLayerChainModel


TFY_CATEGORY_CHAIN_SCROLLLAYER_IMPLEMENTATION(scrollMode, CAScrollLayerScrollMode)

- (TFYScrollLayerChainModel * _Nonnull (^)(CGRect))scrollToRect{
    return ^ (CGRect rect){
        [self enumerateObjectsUsingBlock:^(CAScrollLayer * _Nonnull obj) {
            [obj scrollToRect:rect];
        }];
        return self;
    };
}

- (TFYScrollLayerChainModel * _Nonnull (^)(CGPoint))scrollToPoint{
    return ^ (CGPoint point){
        [self enumerateObjectsUsingBlock:^(CAScrollLayer * _Nonnull obj) {
            [obj scrollToPoint:point];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_LAYER_IMPLEMENTATION(CAScrollLayer, TFYScrollLayerChainModel)
#undef TFY_CATEGORY_CHAIN_SCROLLLAYER_IMPLEMENTATION
