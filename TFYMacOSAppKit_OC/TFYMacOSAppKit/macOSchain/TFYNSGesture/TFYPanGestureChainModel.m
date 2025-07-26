//
//  TFYPanGestureChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYPanGestureChainModel.h"

#define TFY_CATEGORY_CHAIN_PANGESTURE_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYPanGestureChainModel *, NSPanGestureRecognizer)

@implementation TFYPanGestureChainModel

TFY_CATEGORY_CHAIN_PANGESTURE_IMPLEMENTATION(buttonMask, NSUInteger)
TFY_CATEGORY_CHAIN_PANGESTURE_IMPLEMENTATION(numberOfTouchesRequired, NSUInteger)

- (TFYPanGestureChainModel * _Nonnull (^)(CGPoint, NSView * _Nonnull))translation{
    return ^ (CGPoint translation, NSView *view){
        [self enumerateObjectsUsingBlock:^(NSPanGestureRecognizer * _Nonnull obj) {
            [obj setTranslation:translation inView:view];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_GESTURE_IMPLEMENTATION(NSPanGestureRecognizer, TFYPanGestureChainModel)
#undef TFY_CATEGORY_CHAIN_PANGESTURE_IMPLEMENTATION
