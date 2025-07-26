//
//  TFYLongPressGestureChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYLongPressGestureChainModel.h"

#define TFY_CATEGORY_CHAIN_LONGGESTURE_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYLongPressGestureChainModel *, NSPressGestureRecognizer)

@implementation TFYLongPressGestureChainModel

TFY_CATEGORY_CHAIN_LONGGESTURE_IMPLEMENTATION(buttonMask, NSUInteger)
TFY_CATEGORY_CHAIN_LONGGESTURE_IMPLEMENTATION(minimumPressDuration, NSTimeInterval)
TFY_CATEGORY_CHAIN_LONGGESTURE_IMPLEMENTATION(allowableMovement, CGFloat)
TFY_CATEGORY_CHAIN_LONGGESTURE_IMPLEMENTATION(numberOfTouchesRequired, NSInteger)

@end

TFY_CATEGORY_GESTURE_IMPLEMENTATION(NSPressGestureRecognizer, TFYLongPressGestureChainModel)

#undef TFY_CATEGORY_CHAIN_LONGGESTURE_IMPLEMENTATION
