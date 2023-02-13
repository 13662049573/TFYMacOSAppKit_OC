//
//  TFYComboBoxChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYComboBoxChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYComboBoxChainModel *,NSComboBox)

@implementation TFYComboBoxChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(hasVerticalScroller, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(intercellSpacing, NSSize)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(itemHeight, CGFloat)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(numberOfVisibleItems, NSInteger)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(buttonBordered, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(usesDataSource, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(completes, BOOL)

- (TFYComboBoxChainModel * _Nonnull (^)(id<NSComboBoxDelegate>))delegateBox {
    return ^(id<NSComboBoxDelegate> delegateToken)
    {
        ((NSComboBox*)self.controlview).delegate = delegateToken;
        return self;
    };
}

- (TFYComboBoxChainModel * _Nonnull (^)(id<NSComboBoxDataSource>))dataSourceBox {
    return ^(id<NSComboBoxDataSource> dataSourceBox)
    {
        ((NSComboBox*)self.controlview).dataSource = dataSourceBox;
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSComboBox, TFYComboBoxChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

