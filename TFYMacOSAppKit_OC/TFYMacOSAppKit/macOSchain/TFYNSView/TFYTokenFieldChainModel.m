//
//  TFYTokenFieldChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYTokenFieldChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTokenFieldChainModel *,NSTokenField)

@implementation TFYTokenFieldChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(tokenStyle, NSTokenStyle)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(completionDelay, NSTimeInterval)

- (TFYTokenFieldChainModel * _Nonnull (^)(id<NSTokenFieldDelegate>))delegateToken {
    return ^(id<NSTokenFieldDelegate> delegateToken)
    {
        ((NSTokenField*)self.controlview).delegate = delegateToken;
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSTokenField, TFYTokenFieldChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

