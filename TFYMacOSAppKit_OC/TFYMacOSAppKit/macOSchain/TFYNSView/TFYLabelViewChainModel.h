//
//  TFYLabelViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYBaseViewChainModel.h"
#import "TFYLabel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYLabelViewChainModel;
@interface TFYLabelViewChainModel : TFYBaseViewChainModel<TFYLabelViewChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ title) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ font) (NSFont*);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ textColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ textAlignment) (NSTextAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ contentVerticalAlignment) (TFYContentVerticalAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ lineBreakMode) (NSLineBreakMode);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ attributedText) (NSAttributedString*);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ highlightedTextColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ highlighted) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ userInteractionEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYLabelViewChainModel * (^ enabled) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(TFYLabel, TFYLabelViewChainModel)
NS_ASSUME_NONNULL_END

