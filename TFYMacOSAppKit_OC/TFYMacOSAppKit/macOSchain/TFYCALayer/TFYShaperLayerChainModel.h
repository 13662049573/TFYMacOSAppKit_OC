//
//  TFYShaperLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYShaperLayerChainModel;
@interface TFYShaperLayerChainModel : TFYBaseLayerChainModel<TFYShaperLayerChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ path) (CGPathRef path);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ fillColor) (CGColorRef fillColor);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ fillRule) (CAShapeLayerFillRule fillRule);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ strokeColor) (CGColorRef strokeColor);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ strokeStart) (CGFloat strokeStart);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ strokeEnd) (CGFloat strokeEnd);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ lineWidth) (CGFloat lineWidth);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ miterLimit) (CGFloat miterLimit);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ lineCap) (CAShapeLayerLineCap lineCap);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ lineJoin) (CAShapeLayerLineJoin lineJoin);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ lineDashPhase) (CGFloat lineDashPhase);
TFY_PROPERTY_CHAIN_READONLY TFYShaperLayerChainModel * (^ lineDashPattern) (NSArray<NSNumber *> * lineDashPattern);
@end

TFY_CATEGORY_EXINTERFACE(CAShapeLayer, TFYShaperLayerChainModel)

NS_ASSUME_NONNULL_END
