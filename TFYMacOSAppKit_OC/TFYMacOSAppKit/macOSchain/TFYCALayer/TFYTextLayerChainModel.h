//
//  TFYTextLayerChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import "TFYBaseLayerChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTextLayerChainModel;
@interface TFYTextLayerChainModel : TFYBaseLayerChainModel<TFYTextLayerChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ string) (id string);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ font) (CFTypeRef font);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ fontSize) (CGFloat fontSize);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ foregroundColor) (CGColorRef foregroundColor);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ wrapped) (BOOL wrapped);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ truncationMode) (CATextLayerTruncationMode truncationMode);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ alignmentMode) (CATextLayerAlignmentMode alignmentMode);
TFY_PROPERTY_CHAIN_READONLY TFYTextLayerChainModel * (^ allowsFontSubpixelQuantization) (BOOL allowsFontSubpixelQuantization);

@end
TFY_CATEGORY_EXINTERFACE(CATextLayer, TFYTextLayerChainModel)

NS_ASSUME_NONNULL_END
