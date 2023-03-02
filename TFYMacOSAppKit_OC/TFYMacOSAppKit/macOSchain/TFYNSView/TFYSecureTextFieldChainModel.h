//
//  TFYSecureTextFieldChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import "TFYTextFieldChainModel.h"
#import "TFYSecureTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYSecureTextFieldChainModel : TFYTextFieldChainModel

TFY_PROPERTY_CHAIN_READONLY TFYSecureTextFieldChainModel * (^ delegateCustomize) (id <TFYSecureTextFieldNotifyingDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYSecureTextFieldChainModel * (^ isTextAlignmentVerticalCenter) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSecureTextFieldChainModel * (^ Xcursor) (CGFloat);

@end
TFY_CATEGORY_EXINTERFACE(TFYSecureTextField, TFYSecureTextFieldChainModel)
NS_ASSUME_NONNULL_END
