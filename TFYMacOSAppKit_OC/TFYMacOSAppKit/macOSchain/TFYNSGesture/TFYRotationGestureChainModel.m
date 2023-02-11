//
//  TFYRotationGestureChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYRotationGestureChainModel.h"

#define TFY_CATEGORY_CHAIN_ROTAGESTURE_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYRotationGestureChainModel *, NSRotationGestureRecognizer)

@implementation TFYRotationGestureChainModel

TFY_CATEGORY_CHAIN_ROTAGESTURE_IMPLEMENTATION(rotation, CGFloat)
TFY_CATEGORY_CHAIN_ROTAGESTURE_IMPLEMENTATION(rotationInDegrees, CGFloat)

@end
TFY_CATEGORY_GESTURE_IMPLEMENTATION(NSRotationGestureRecognizer, TFYRotationGestureChainModel)
#undef TFY_CATEGORY_CHAIN_ROTAGESTURE_IMPLEMENTATION
