//
//  TFYBaseGestureChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYChainBaseModel.h"

#define TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass) TFY_CATEGORY_CHAIN_IMPLEMENTATION(TFYMethod,TFYParaType, TFYModelType, TFYPropertyClass)

#define TFY_CATEGORY_GESTURE_IMPLEMENTATION(TFYMacOSClass, modelType)\
@implementation TFYMacOSClass (EXT)\
- (modelType *)makeChain{\
    return [[modelType alloc] initWithGesture:self modelClass:[TFYMacOSClass class]];\
}\
@end

NS_ASSUME_NONNULL_BEGIN

@interface TFYBaseGestureChainModel<__covariant  ObjectType> : TFYChainBaseModel<ObjectType>

- (instancetype)initWithGesture:(NSGestureRecognizer *)gesture modelClass:(Class)modelClass;

TFY_PROPERTY_STRONG_READONLY __kindof NSGestureRecognizer * gesture;

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delegate) (id<NSGestureRecognizerDelegate> delegate);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ enabled) (BOOL enabled);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delaysPrimaryMouseButtonEvents) (BOOL delaysPrimaryMouseButtonEvents);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delaysOtherMouseButtonEvents) (BOOL delaysOtherMouseButtonEvents);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delaysKeyEvents) (BOOL delaysKeyEvents);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delaysMagnificationEvents) (BOOL delaysMagnificationEvents);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ delaysRotationEvents) (BOOL delaysRotationEvents);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ pressureConfiguration) (NSPressureConfiguration *pressureConfiguration);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ target) (id);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ action) (SEL action);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addTarget) (id target, SEL action);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addToSuperView) (NSView *view);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeTarget) (id target, SEL action);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addTargetBlock) (void (^) (id gesture));

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ addTargetBlockWithTag) (void (^) (id gesture), NSString *tag);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeTargetBlockWithTag) (NSString *tag);

TFY_PROPERTY_CHAIN_READONLY ObjectType (^ removeAllTargetBlock)(void);

@end

NS_ASSUME_NONNULL_END
