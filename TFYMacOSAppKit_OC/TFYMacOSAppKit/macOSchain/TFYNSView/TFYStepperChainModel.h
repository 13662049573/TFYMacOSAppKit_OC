//
//  TFYStepperChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYStepperChainModel;
@interface TFYStepperChainModel : TFYBaseControlChainModel<TFYStepperChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYStepperChainModel * (^ minValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYStepperChainModel * (^ maxValue) (double);
TFY_PROPERTY_CHAIN_READONLY TFYStepperChainModel * (^ increment) (double);
TFY_PROPERTY_CHAIN_READONLY TFYStepperChainModel * (^ valueWraps) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYStepperChainModel * (^ autorepeat) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSStepper, TFYStepperChainModel)
NS_ASSUME_NONNULL_END
