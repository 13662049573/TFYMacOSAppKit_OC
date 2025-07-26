//
//  TFYCustomizeTextFieldChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYTextFieldChainModel.h"
#import "TFYTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYCustomizeTextFieldChainModel : TFYTextFieldChainModel

TFY_PROPERTY_CHAIN_READONLY TFYCustomizeTextFieldChainModel * (^ delegateCustomize) (id <TFYTextFieldNotifyingDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeTextFieldChainModel * (^ isTextAlignmentVerticalCenter) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeTextFieldChainModel * (^ Xcursor) (CGFloat);

@end
TFY_CATEGORY_EXINTERFACE(TFYTextField, TFYCustomizeTextFieldChainModel)
NS_ASSUME_NONNULL_END
