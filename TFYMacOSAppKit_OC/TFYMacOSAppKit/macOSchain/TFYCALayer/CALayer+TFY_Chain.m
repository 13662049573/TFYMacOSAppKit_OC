//
//  CALayer+TFY_Chain.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "CALayer+TFY_Chain.h"

#define TFY_CATEGORY_ADDSUBLAYER(method, ModelClass, LayerClass)\
- (ModelClass * _Nonnull (^)(void))method{\
return ^ (){\
LayerClass *layer = [LayerClass layer];\
ModelClass *chainModel = [[ModelClass alloc] initWithLayer:layer modelClass:[LayerClass class]];\
[self addSublayer:layer];\
return chainModel;\
};\
}

@implementation CALayer (TFY_Chain)

TFY_CATEGORY_ADDSUBLAYER(addLayer, TFYLayerChainModel, CALayer)
TFY_CATEGORY_ADDSUBLAYER(addShaperLayer, TFYShaperLayerChainModel, CAShapeLayer)
TFY_CATEGORY_ADDSUBLAYER(addEmiiterLayer, TFYEmiiterLayerChainModel, CAEmitterLayer)
TFY_CATEGORY_ADDSUBLAYER(addScrollLayer, TFYScrollLayerChainModel, CAScrollLayer)
TFY_CATEGORY_ADDSUBLAYER(addTextLayer, TFYTextLayerChainModel, CATextLayer)
TFY_CATEGORY_ADDSUBLAYER(addTiledLayer, TFYTiledLayerChainModel, CATiledLayer)
TFY_CATEGORY_ADDSUBLAYER(addTransFormLayer, TFYTransFormLayerChainModel, CATransformLayer)
TFY_CATEGORY_ADDSUBLAYER(addGradientLayer, TFYGradientLayerChainModel, CAGradientLayer)
TFY_CATEGORY_ADDSUBLAYER(addReplicatorLayer, TFYReplicatorLayerChainModel, CAReplicatorLayer)
@end
#undef TFY_CATEGORY_ADDSUBLAYER
