//
//  TFYSwitchChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYSwitchChainModel;
@interface TFYSwitchChainModel : TFYBaseControlChainModel<TFYSwitchChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYSwitchChainModel * (^ state) (NSControlStateValue);

@end
TFY_CATEGORY_EXINTERFACE(NSSwitch, TFYSwitchChainModel)
NS_ASSUME_NONNULL_END
