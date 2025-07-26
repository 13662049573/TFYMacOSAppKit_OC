//
//  TFYMagnificationChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYMagnificationChainModel.h"

#define TFY_CATEGORY_CHAIN_MAGNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYMagnificationChainModel *, NSMagnificationGestureRecognizer)

@implementation TFYMagnificationChainModel
TFY_CATEGORY_CHAIN_MAGNIFICATION_IMPLEMENTATION(magnification, CGFloat)
@end
TFY_CATEGORY_GESTURE_IMPLEMENTATION(NSMagnificationGestureRecognizer, TFYMagnificationChainModel)
#undef TFY_CATEGORY_CHAIN_SWIPEGESTURE_IMPLEMENTATION
