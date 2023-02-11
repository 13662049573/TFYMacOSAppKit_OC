//
//  TFYBaseGestureChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseGestureChainModel.h"
#import "TFYChainBaseModel+TFY_Tools.h"
#import "NSGestureRecognizer+TFY_Tools.h"

#define TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, id, NSGestureRecognizer)

@implementation TFYBaseGestureChainModel

- (instancetype)initWithGesture:(NSGestureRecognizer *)gesture modelClass:(nonnull Class)modelClass{
    if (self = [super initWithModelObject:gesture modelClass:modelClass]) {
        
    }
    return self;
}

TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(delegate, id<NSGestureRecognizerDelegate>)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(enabled, BOOL)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(delaysPrimaryMouseButtonEvents, BOOL)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(delaysOtherMouseButtonEvents, BOOL)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(delaysKeyEvents, BOOL)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(delaysMagnificationEvents, BOOL)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(delaysRotationEvents, BOOL)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(pressureConfiguration, NSPressureConfiguration*)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(target, id)
TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION(action, SEL)


- (id  _Nonnull (^)(id _Nonnull, SEL _Nonnull))addTarget{
    return ^ (id target, SEL action){
        if (target && action) {
            [self enumerateObjectsUsingBlock:^(NSGestureRecognizer * _Nonnull obj) {
                obj.target = target;
                obj.action = action;
            }];
        }
        return self;
    };
}

- (id  _Nonnull (^)(NSView * _Nonnull))addToSuperView {
    return ^ (NSView *superView){
        if (superView) {
            [self enumerateObjectsUsingBlock:^(NSGestureRecognizer * _Nonnull obj) {
                [superView addGestureRecognizer:obj];
            }];
        }
        return self;
    };
}

- (NSGestureRecognizer *)gesture{
    return self.effectiveObjects.firstObject;
}

- (id  _Nonnull (^)(id _Nonnull, SEL _Nonnull))removeTarget{
    return ^ (id target, SEL action){
        if (target) {
            [self enumerateObjectsUsingBlock:^(NSGestureRecognizer  *_Nonnull obj) {
                obj.target = target;
                obj.action = action;
            }];
        }
        return self;
    };
}

- (id  _Nonnull (^)(void (^ _Nonnull)(id _Nonnull)))addTargetBlock{
    return ^ (GestureTargetAction action){
        if (action) {
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj) {
                [obj tfy_addTargetBlock:action];
            }];
        }
        return self;
    };
}

- (id  _Nonnull (^)(void (^ _Nonnull)(id _Nonnull), NSString * _Nonnull))addTargetBlockWithTag{
    return ^ (GestureTargetAction action, NSString *tag){
        if (action) {
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj) {
                [obj tfy_addTargetBlock:action tag:tag];
            }];
        }
        return self;
    };
}

- (id  _Nonnull (^)(NSString * _Nonnull))removeTargetBlockWithTag{
    return ^ (NSString *tag){
        if (tag) {
            [self enumerateObjectsUsingBlock:^(id  _Nonnull obj) {
                [obj tfy_removeTargetBlockByTag:tag];
            }];
            
        }
        return self;
    };
}

- (id  _Nonnull (^)(void))removeAllTargetBlock{
    return ^(){
        [self enumerateObjectsUsingBlock:^(NSGestureRecognizer * _Nonnull obj) {
            [obj tfy_removeAllTargetBlock];
        }];
        return self;
    };
}

@end

#undef TFY_CATEGORY_CHAIN_GESTURE_IMPLEMENTATION

