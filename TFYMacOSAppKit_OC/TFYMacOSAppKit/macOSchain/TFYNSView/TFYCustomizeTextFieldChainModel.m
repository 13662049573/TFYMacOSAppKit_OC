//
//  TFYCustomizeTextFieldChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYCustomizeTextFieldChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYCustomizeTextFieldChainModel *,TFYTextField)

@implementation TFYCustomizeTextFieldChainModel

- (TFYCustomizeTextFieldChainModel * _Nonnull (^)(id<TFYTextFieldNotifyingDelegate>))delegateCustomize {
    return ^(id<TFYTextFieldNotifyingDelegate> delegateOutline)
    {
        ((TFYTextField*)self.controlview).delegate = delegateOutline;
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(TFYTextField, TFYCustomizeTextFieldChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
