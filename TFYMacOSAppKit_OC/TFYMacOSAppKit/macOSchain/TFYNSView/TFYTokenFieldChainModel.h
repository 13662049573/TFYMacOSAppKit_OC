//
//  TFYTokenFieldChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYTextFieldChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYTokenFieldChainModel : TFYTextFieldChainModel

TFY_PROPERTY_CHAIN_READONLY TFYTokenFieldChainModel * (^ delegateToken) (id<NSTokenFieldDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYTokenFieldChainModel * (^ tokenStyle) (NSTokenStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTokenFieldChainModel * (^ completionDelay) (NSTimeInterval);

@end
TFY_CATEGORY_EXINTERFACE(NSTokenField, TFYTokenFieldChainModel)
NS_ASSUME_NONNULL_END
