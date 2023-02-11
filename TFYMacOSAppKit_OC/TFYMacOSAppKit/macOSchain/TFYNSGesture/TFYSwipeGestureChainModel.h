//
//  TFYSwipeGestureChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseGestureChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYSwipeGestureChainModel;
@interface TFYSwipeGestureChainModel : TFYBaseGestureChainModel<TFYSwipeGestureChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYSwipeGestureChainModel * (^ buttonMask) (NSUInteger buttonMask);
TFY_PROPERTY_CHAIN_READONLY TFYSwipeGestureChainModel * (^ numberOfClicksRequired) (NSInteger numberOfClicksRequired);
TFY_PROPERTY_CHAIN_READONLY TFYSwipeGestureChainModel * (^ numberOfTouchesRequired) (NSInteger numberOfTouchesRequired);

@end
TFY_CATEGORY_EXINTERFACE(NSClickGestureRecognizer, TFYSwipeGestureChainModel)

NS_ASSUME_NONNULL_END

