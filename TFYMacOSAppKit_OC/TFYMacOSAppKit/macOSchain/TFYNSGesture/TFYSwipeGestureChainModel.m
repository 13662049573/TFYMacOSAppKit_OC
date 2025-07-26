//
//  TFYSwipeGestureChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYSwipeGestureChainModel.h"

#define TFY_CATEGORY_CHAIN_SWIPEGESTURE_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_GESTURECLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYSwipeGestureChainModel *, NSClickGestureRecognizer)

@implementation TFYSwipeGestureChainModel

TFY_CATEGORY_CHAIN_SWIPEGESTURE_IMPLEMENTATION(buttonMask, NSUInteger)
TFY_CATEGORY_CHAIN_SWIPEGESTURE_IMPLEMENTATION(numberOfClicksRequired, NSInteger)
TFY_CATEGORY_CHAIN_SWIPEGESTURE_IMPLEMENTATION(numberOfTouchesRequired, NSInteger)

@end
TFY_CATEGORY_GESTURE_IMPLEMENTATION(NSClickGestureRecognizer, TFYSwipeGestureChainModel)
#undef TFY_CATEGORY_CHAIN_SWIPEGESTURE_IMPLEMENTATION


