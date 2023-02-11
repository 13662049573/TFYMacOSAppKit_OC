//
//  TFYLongPressGestureChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseGestureChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYLongPressGestureChainModel;
@interface TFYLongPressGestureChainModel : TFYBaseGestureChainModel<TFYLongPressGestureChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYLongPressGestureChainModel * (^ buttonMask) (NSUInteger buttonMask);

TFY_PROPERTY_CHAIN_READONLY TFYLongPressGestureChainModel * (^ minimumPressDuration) (NSTimeInterval minimumPressDuration);

TFY_PROPERTY_CHAIN_READONLY TFYLongPressGestureChainModel * (^ allowableMovement) (CGFloat allowableMovement);

TFY_PROPERTY_CHAIN_READONLY TFYLongPressGestureChainModel * (^ numberOfTouchesRequired) (NSInteger numberOfTouchesRequired);

@end

TFY_CATEGORY_EXINTERFACE(NSPressGestureRecognizer, TFYLongPressGestureChainModel)

NS_ASSUME_NONNULL_END
