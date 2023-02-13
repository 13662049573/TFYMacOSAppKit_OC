//
//  TFYStatusBarButtonChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYStatusBarButtonChainModel.h"

#define TFY_CATEGORY_CHAIN_STATUSBAR_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYStatusBarButtonChainModel *,NSStatusBarButton)

@implementation TFYStatusBarButtonChainModel

TFY_CATEGORY_CHAIN_STATUSBAR_IMPLEMENTATION(appearsDisabled, BOOL)

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSStatusBarButton, TFYStatusBarButtonChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
