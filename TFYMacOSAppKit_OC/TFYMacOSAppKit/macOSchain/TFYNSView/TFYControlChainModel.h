//
//  TFYControlChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYControlChainModel;
@interface TFYControlChainModel : TFYBaseViewChainModel<TFYControlChainModel *>

@end
TFY_CATEGORY_EXINTERFACE(NSControl, TFYControlChainModel)
NS_ASSUME_NONNULL_END
