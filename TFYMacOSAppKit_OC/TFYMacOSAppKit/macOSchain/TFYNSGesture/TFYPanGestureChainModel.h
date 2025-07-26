//
//  TFYPanGestureChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseGestureChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYPanGestureChainModel;
@interface TFYPanGestureChainModel : TFYBaseGestureChainModel<TFYPanGestureChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYPanGestureChainModel * (^ buttonMask) (NSUInteger buttonMask);
TFY_PROPERTY_CHAIN_READONLY TFYPanGestureChainModel * (^ numberOfTouchesRequired) (NSUInteger numberOfTouchesRequired);
TFY_PROPERTY_CHAIN_READONLY TFYPanGestureChainModel * (^ translation) (CGPoint translation,NSView *view);

@end
TFY_CATEGORY_EXINTERFACE(NSPanGestureRecognizer, TFYPanGestureChainModel)
NS_ASSUME_NONNULL_END
