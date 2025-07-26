//
//  TFYRotationGestureChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseGestureChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYRotationGestureChainModel;
@interface TFYRotationGestureChainModel : TFYBaseGestureChainModel<TFYRotationGestureChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYRotationGestureChainModel * (^ rotation) (CGFloat rotation);
TFY_PROPERTY_CHAIN_READONLY TFYRotationGestureChainModel * (^ rotationInDegrees) (CGFloat rotationInDegrees);
@end
TFY_CATEGORY_EXINTERFACE(NSRotationGestureRecognizer, TFYRotationGestureChainModel)

NS_ASSUME_NONNULL_END

