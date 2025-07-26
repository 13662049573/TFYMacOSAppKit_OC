//
//  TFYComboBoxChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYTextFieldChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYComboBoxChainModel : TFYTextFieldChainModel

TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ hasVerticalScroller) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ intercellSpacing) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ itemHeight) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ numberOfVisibleItems) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ buttonBordered) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ usesDataSource) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ completes) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ delegateBox) (id<NSComboBoxDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYComboBoxChainModel * (^ dataSourceBox) (id<NSComboBoxDataSource>);

@end
TFY_CATEGORY_EXINTERFACE(NSComboBox, TFYComboBoxChainModel)
NS_ASSUME_NONNULL_END
