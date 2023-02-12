//
//  TFYProgressIndicatorViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYProgressIndicatorViewChainModel;
@interface TFYProgressIndicatorViewChainModel : TFYBaseViewChainModel<TFYProgressIndicatorViewChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ indeterminate) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ bezeled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ controlTint) (NSControlTint);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ controlSize) (NSControlSize);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ doubleValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ minValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ maxValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ usesThreadedAnimation) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ style) (NSProgressIndicatorStyle);
TFY_PROPERTY_CHAIN_READONLY TFYProgressIndicatorViewChainModel * (^ displayedWhenStopped) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSProgressIndicator, TFYProgressIndicatorViewChainModel)
NS_ASSUME_NONNULL_END
