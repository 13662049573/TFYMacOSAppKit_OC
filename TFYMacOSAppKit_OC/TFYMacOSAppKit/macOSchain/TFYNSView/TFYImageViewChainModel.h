//
//  TFYImageViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYImageViewChainModel;
@interface TFYImageViewChainModel : TFYBaseControlChainModel<TFYImageViewChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ image) (NSImage*);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ imageAlignment) (NSImageAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ imageScaling) (NSImageScaling);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ imageFrameStyle) (NSImageFrameStyle);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ symbolConfiguration) (NSImageSymbolConfiguration*);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ contentTintColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ animates) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYImageViewChainModel * (^ allowsCutCopyPaste) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSImageView, TFYImageViewChainModel)
NS_ASSUME_NONNULL_END
