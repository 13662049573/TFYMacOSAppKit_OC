//
//  TFYSecureTextFieldChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import "TFYSecureTextFieldChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYSecureTextFieldChainModel *,TFYSecureTextField)

@implementation TFYSecureTextFieldChainModel

- (TFYSecureTextFieldChainModel * _Nonnull (^)(id<TFYSecureTextFieldNotifyingDelegate>))delegateCustomize {
    return ^(id<TFYSecureTextFieldNotifyingDelegate> delegateOutline)
    {
        ((TFYSecureTextField*)self.controlview).delegate = delegateOutline;
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(TFYSecureTextField, TFYSecureTextFieldChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
