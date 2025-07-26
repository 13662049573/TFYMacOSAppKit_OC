//
//  TFYLabelViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYLabelViewChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYLabelViewChainModel *,TFYLabel)


@implementation TFYLabelViewChainModel

- (TFYLabelViewChainModel * _Nonnull (^)(void (^ _Nonnull)(__kindof TFYLabel * _Nonnull)))actionBlock {
    return ^ (action block){
        [self enumerateObjectsUsingBlock:^(TFYLabel * _Nonnull obj) {
            [obj actionBlock:block];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(TFYLabel, TFYLabelViewChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

