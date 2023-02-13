//
//  TFYStatusBarButtonChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYButtonChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYStatusBarButtonChainModel : TFYBaseControlChainModel
TFY_PROPERTY_CHAIN_READONLY TFYStatusBarButtonChainModel * (^ appearsDisabled) (BOOL);
@end
TFY_CATEGORY_EXINTERFACE(NSStatusBarButton, TFYStatusBarButtonChainModel)
NS_ASSUME_NONNULL_END
