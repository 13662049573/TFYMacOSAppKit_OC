//
//  TFYCustomizeButtonChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYButtonChainModel.h"
#import "TFYButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYCustomizeButtonChainModel : TFYButtonChainModel

TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ title_forState) (NSString*,TFYControlState);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ buttonType) (TFYButtonType);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ selected) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ showHighlighted) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ isAttributedTitle) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ titleColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ backgroundImage) (NSImage*);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ titleColor_forState) (NSColor*,TFYControlState);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ attributedTitle_forState) (NSAttributedString*,TFYControlState);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ backgroundImage_forState) (NSImage*,TFYControlState);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ borderColor_forState) (NSColor*,TFYControlState);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ borderWidth_forState) (NSNumber*,TFYControlState);
TFY_PROPERTY_CHAIN_READONLY TFYCustomizeButtonChainModel * (^ cornerRadius_forState) (NSNumber*,TFYControlState);

@end
TFY_CATEGORY_EXINTERFACE(TFYButton, TFYCustomizeButtonChainModel)
NS_ASSUME_NONNULL_END
