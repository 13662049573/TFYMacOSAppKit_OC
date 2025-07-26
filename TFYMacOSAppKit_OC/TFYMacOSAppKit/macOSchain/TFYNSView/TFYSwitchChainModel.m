//
//  TFYSwitchChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYSwitchChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYSwitchChainModel *,NSSwitch)
@implementation TFYSwitchChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(state, NSControlStateValue)

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSSwitch, TFYSwitchChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
