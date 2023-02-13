//
//  TFYButtonChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYButtonChainModel;
@interface TFYButtonChainModel : TFYBaseControlChainModel<TFYButtonChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ title) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ attributedTitle) (NSAttributedString*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ alternateTitle) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ attributedAlternateTitle) (NSAttributedString*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ hasDestructiveAction) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ sound) (NSSound*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ springLoaded) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ maxAcceleratorLevel) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ bezelStyle) (NSBezelStyle);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ bordered) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ transparent) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ showsBorderOnlyWhileMouseInside) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ image) (NSImage*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ alternateImage) (NSImage*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ imagePosition) (NSCellImagePosition);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ imageScaling) (NSImageScaling);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ imageHugsTitle) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ symbolConfiguration) (NSImageSymbolConfiguration*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ bezelColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ contentTintColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ state) (NSControlStateValue);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ allowsMixedState) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ keyEquivalent) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ keyEquivalentModifierMask) (NSEventModifierFlags);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ setButtonType) (NSButtonType);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ setPeriodicDelay_interval) (float,float);
TFY_PROPERTY_CHAIN_READONLY TFYButtonChainModel * (^ getPeriodicDelay_interval) (float*,float*);

@end
TFY_CATEGORY_EXINTERFACE(NSButton, TFYButtonChainModel)
NS_ASSUME_NONNULL_END
