//
//  TFYBaseLayerChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"
#import "TFYChainBaseModel+TFY_Tools.h"

#define TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_LAYERCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, id, CALayer)

@implementation TFYBaseLayerChainModel

- (instancetype)initWithLayer:(CALayer *)layer modelClass:(Class)modelClass {
    if (self = [super initWithModelObject:layer modelClass:modelClass]) {
        
    }
    return self;
}

TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(bounds, CGRect)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(frame, CGRect)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(position, CGPoint)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(anchorPoint, CGPoint)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(zPosition, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(anchorPointZ, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(rasterizationScale, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(transform, CATransform3D)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(affineTransform, CGAffineTransform)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(hidden, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(doubleSided, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(geometryFlipped, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(masksToBounds, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(mask, CALayer *)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(contents, id)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(contentsRect, CGRect)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(contentsGravity, CALayerContentsGravity)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(contentsScale, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(contentsCenter, CGRect)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(contentsFormat, CALayerContentsFormat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(minificationFilter, CALayerContentsFilter)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(magnificationFilter, CALayerContentsFilter)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(minificationFilterBias, float)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(opaque, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(needsDisplayOnBoundsChange, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(drawsAsynchronously, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(edgeAntialiasingMask, CAEdgeAntialiasingMask)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(allowsEdgeAntialiasing, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(backgroundColor, CGColorRef)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(cornerRadius, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(maskedCorners, CACornerMask)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(borderWidth, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(borderColor, CGColorRef)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(opacity, float)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(allowsGroupOpacity, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(compositingFilter, id)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(filters, NSArray*)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(backgroundFilters, NSArray*)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(shouldRasterize, BOOL)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(shadowColor, CGColorRef)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(shadowOpacity, float)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(shadowOffset, CGSize)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(shadowRadius, CGFloat)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(shadowPath, CGPathRef)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(name, NSString *)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(delegate, id <CALayerDelegate>)
TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION(style, NSDictionary *)

- (id  _Nonnull (^)( NSDictionary<NSString *,id<CAAction>>  * _Nonnull))actions{
    return ^ (NSDictionary<NSString *,id<CAAction>> * dic){
        [self enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj) {
            obj.actions = dic;
        }];
        return self;
    };
}

- (id (^)(CGSize shadowOffset, CGFloat shadowRadius, NSColor *shadowColor, CGFloat shadowOpacity))shadow
{
    return ^ id (CGSize shadowOffset, CGFloat shadowRadius, NSColor *shadowColor, CGFloat shadowOpacity) {
        [self enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj) {
            [obj setShadowOffset:shadowOffset];
            [obj setShadowRadius:shadowRadius];
            [obj setShadowColor:shadowColor.CGColor];
            [obj setShadowOpacity:shadowOpacity];
        }];
        
        return self;
    };
}

- (id  _Nonnull (^)(void))removeFromSuperlayer{
    return ^(){
        [self enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj) {
            [obj removeFromSuperlayer];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull))addToSuperLayer{
    return ^ (CALayer *layer){
        [self enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj) {
            [layer addSublayer:obj];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull, CALayer * _Nonnull))insertSublayerBelow{
    return ^ (CALayer *layer, CALayer *belowLayer){
        [self.layer insertSublayer:layer below:belowLayer];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull, CALayer * _Nonnull))insertSublayerAbove{
    return ^ (CALayer *layer, CALayer *above){
        [self.layer insertSublayer:layer above:above];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull, NSInteger))insertSublayerIndex{
    return ^ (CALayer *layer, NSInteger index){
        [self.layer insertSublayer:layer atIndex:(unsigned)index];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull, CALayer * _Nonnull))relpaceSublayer{
    return ^ (CALayer *oldLayer, CALayer *newLayer){
        [self enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj) {
            [obj replaceSublayer:oldLayer with:newLayer];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(CALayer * _Nonnull))setToMask{
    return ^ (CALayer *layer){
        [self enumerateObjectsUsingBlock:^(CALayer *  _Nonnull obj) {
            layer.mask = obj;
        }];
        return self;
    };
}

- (id  _Nonnull (^)(CAAnimation * _Nonnull, NSString * _Nonnull))addAnimation{
    return ^ (CAAnimation *ani, NSString *key){
        if (ani && key) {
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj) {
                [obj addAnimation:ani forKey:key];
            }];
        }
        return self;
    };
}

- (id  _Nonnull (^)(NSString * _Nonnull))removeAnimation{
    return ^ (NSString *key){
        if (key) {
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj) {
                [obj removeAnimationForKey:key];
            }];
        }
        return self;
    };
}

- (id  _Nonnull (^)(void))removeAllAnimation{
    return ^ (){
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj) {
            [obj removeAllAnimations];
        }];
        return self;
    };
}

- (id  _Nonnull (^)(TFYAssignLayerLoad _Nonnull))assignTo{
    return ^ (void (^assignTo)(id layer)){
        if (assignTo) {
            assignTo(self.layer);
        }
        assignTo = nil;
        return self;
    };
}

- (CALayer *)layer{
    return self.effectiveObjects.firstObject;
}


@end

#undef TFY_CATEGORY_CHAIN_BASELAYER_IMPLEMENTATION
