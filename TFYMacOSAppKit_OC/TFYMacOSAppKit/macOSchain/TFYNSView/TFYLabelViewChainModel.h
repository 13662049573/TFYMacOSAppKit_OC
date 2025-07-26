//
//  TFYLabelViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYCustomizeTextFieldChainModel.h"
#import "TFYLabel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^TFYlabelActionBlock)(__kindof TFYLabel *sender);

@interface TFYLabelViewChainModel : TFYCustomizeTextFieldChainModel

TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ actionBlock) (TFYlabelActionBlock);

@end
TFY_CATEGORY_EXINTERFACE(TFYLabel, TFYLabelViewChainModel)
NS_ASSUME_NONNULL_END

