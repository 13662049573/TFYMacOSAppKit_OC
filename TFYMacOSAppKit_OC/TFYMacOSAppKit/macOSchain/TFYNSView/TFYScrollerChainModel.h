//
//  TFYScrollerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYScrollerChainModel;
@interface TFYScrollerChainModel : TFYBaseControlChainModel<TFYScrollerChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYScrollerChainModel * (^ scrollerStyle) (NSScrollerStyle);
TFY_PROPERTY_CHAIN_READONLY TFYScrollerChainModel * (^ knobStyle) (NSScrollerKnobStyle);
TFY_PROPERTY_CHAIN_READONLY TFYScrollerChainModel * (^ knobProportion) (CGFloat);

@end
TFY_CATEGORY_EXINTERFACE(NSScroller, TFYScrollerChainModel)
NS_ASSUME_NONNULL_END
