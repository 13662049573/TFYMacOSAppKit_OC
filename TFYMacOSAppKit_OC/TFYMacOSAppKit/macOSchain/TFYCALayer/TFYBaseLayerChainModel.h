//
//  TFYBaseLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import <Foundation/Foundation.h>
#import "TFYChainBaseModel.h"

#define TFY_CATEGORY_CHAIN_LAYERCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass)     TFY_CATEGORY_CHAIN_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass)

#define TFY_CATEGORY_LAYER_IMPLEMENTATION(TFYMacOSClass, modelType)\
@implementation TFYMacOSClass (EXT)\
- (modelType *)makeChain{\
    return [[modelType alloc] initWithLayer:self modelClass:[TFYMacOSClass class]];\
}\
@end

NS_ASSUME_NONNULL_BEGIN

typedef void(^TFYAssignLayerLoad)(__kindof CALayer *layer);

@interface TFYBaseLayerChainModel<__covariant  ObjectType> : TFYChainBaseModel<ObjectType>

- (instancetype)initWithLayer:(CALayer *)layer modelClass:(Class)modelClass;

TFY_PROPERTY_STRONG_READONLY __kindof CALayer * layer;

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ bounds) (CGRect bounds);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ position) (CGPoint position);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ zPosition) (CGFloat zPosition);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ anchorPoint) (CGPoint anchorPoint);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ anchorPointZ) (CGFloat anchorPointZ);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ transform) (CATransform3D transform);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ affineTransform) (CGAffineTransform affineTransform);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ frame) (CGRect frame);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ hidden) (BOOL hidden);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ doubleSided) (BOOL doubleSided);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ geometryFlipped) (BOOL geometryFlipped);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeFromSuperlayer) (void);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addToSuperLayer) (CALayer * layer);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ insertSublayerBelow) (CALayer *layer, CALayer * below);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ insertSublayerIndex) (CALayer *layer, NSInteger index);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ insertSublayerAbove) (CALayer *layer, CALayer *above);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ relpaceSublayer) (CALayer *oldLayer, CALayer *newLayer);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ setToMask) (CALayer * toLayer);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ mask) (CALayer * maskLayer);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ masksToBounds) (BOOL masksToBounds);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contents) (id contents);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentsRect) (CGRect contentsRect);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentsGravity) (CALayerContentsGravity contentsGravity);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentsScale) (CGFloat contentsScale);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentsCenter) (CGRect contentsCenter);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ contentsFormat) (CALayerContentsFormat contentsFormat) API_AVAILABLE(ios(10.0));
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ minificationFilter) (CALayerContentsFilter minificationFilter);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ magnificationFilter) (CALayerContentsFilter magnificationFilter);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ minificationFilterBias) (float minificationFilterBias);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ opaque) (BOOL opaque);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ needsDisplayOnBoundsChange) (BOOL needsDisplayOnBoundsChange);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ drawsAsynchronously) (BOOL drawsAsynchronously);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ edgeAntialiasingMask) (CAEdgeAntialiasingMask edgeAntialiasingMask);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ allowsEdgeAntialiasing) (BOOL allowsEdgeAntialiasing);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ backgroundColor) (CGColorRef backgroundColor);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ cornerRadius) (CGFloat cornerRadius);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ maskedCorners) (CACornerMask maskedCorners) API_AVAILABLE(ios(11.0));
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ borderWidth) (CGFloat borderWidth);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ borderColor) (CGColorRef borderColor);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ opacity) (float opacity);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ allowsGroupOpacity) (BOOL allowsGroupOpacity);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ compositingFilter) (id compositingFilter);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ filters) (NSArray* filters);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ backgroundFilters) (NSArray* backgroundFilters);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shouldRasterize) (BOOL shouldRasterize);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ rasterizationScale) (CGFloat rasterizationScale);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowColor) (CGColorRef shadowColor);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowOpacity) (float shadowOpacity);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowOffset) (CGSize shadowOffset);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowRadius) (CGFloat shadowRadius);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadowPath) (CGPathRef shadowPath);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ actions) (NSDictionary<NSString *, id<CAAction>> * actions);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addAnimation) (CAAnimation *animation, NSString *key);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeAnimation) (NSString * key);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeAllAnimation) (void);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ name) (NSString * name);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delegate) (id <CALayerDelegate> delegate);
TFY_PROPERTY_CHAIN_READONLY ObjectType (^ style) (NSDictionary * style);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ assignTo) (TFYAssignLayerLoad assignTo);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ shadow)(CGSize shadowOffset, CGFloat shadowRadius, NSColor *shadowColor, CGFloat shadowOpacity);

@end

NS_ASSUME_NONNULL_END
