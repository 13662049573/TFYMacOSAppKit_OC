//
//  TFYMagnificationChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseGestureChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYMagnificationChainModel;
@interface TFYMagnificationChainModel : TFYBaseGestureChainModel<TFYMagnificationChainModel *>
TFY_PROPERTY_CHAIN_READONLY TFYMagnificationChainModel * (^ magnification) (CGFloat magnification);
@end
TFY_CATEGORY_EXINTERFACE(NSMagnificationGestureRecognizer, TFYMagnificationChainModel)
NS_ASSUME_NONNULL_END
