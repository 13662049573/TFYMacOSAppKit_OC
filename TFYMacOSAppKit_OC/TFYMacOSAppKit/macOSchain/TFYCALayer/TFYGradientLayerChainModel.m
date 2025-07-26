//
//  TFYGradientLayerChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYGradientLayerChainModel.h"

#define TFY_CATEGORY_CHAIN_GRADIENTLAYER_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_LAYERCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYGradientLayerChainModel *, CAGradientLayer)
@implementation TFYGradientLayerChainModel

TFY_CATEGORY_CHAIN_GRADIENTLAYER_IMPLEMENTATION(locations, NSArray<NSNumber *> *)
TFY_CATEGORY_CHAIN_GRADIENTLAYER_IMPLEMENTATION(startPoint, CGPoint)
TFY_CATEGORY_CHAIN_GRADIENTLAYER_IMPLEMENTATION(endPoint, CGPoint)


- (TFYGradientLayerChainModel * _Nonnull (^)(NSArray * _Nonnull))colors{
    return ^ (NSArray *colors){
        NSMutableArray *bridgeColors = [NSMutableArray array];
        for (id color in colors) {
            if ([color isKindOfClass:[NSColor class]]) {
                [bridgeColors addObject:(__bridge id)[color CGColor]];
            }else{
                [bridgeColors addObject:color];
            }
        }
        [self enumerateObjectsUsingBlock:^(CAGradientLayer * _Nonnull obj) {
            [obj setColors:bridgeColors];
        }];
        return self;
    };
}
@end
TFY_CATEGORY_LAYER_IMPLEMENTATION(CAGradientLayer, TFYGradientLayerChainModel)
#undef TFY_CATEGORY_CHAIN_GRADIENTLAYER_IMPLEMENTATION
