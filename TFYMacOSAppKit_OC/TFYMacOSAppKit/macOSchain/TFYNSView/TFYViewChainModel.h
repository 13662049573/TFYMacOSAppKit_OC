//
//  TFYViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYViewChainModel;
@interface TFYViewChainModel : TFYBaseViewChainModel<TFYViewChainModel *>

@end
TFY_CATEGORY_EXINTERFACE(NSView, TFYViewChainModel)
NS_ASSUME_NONNULL_END
