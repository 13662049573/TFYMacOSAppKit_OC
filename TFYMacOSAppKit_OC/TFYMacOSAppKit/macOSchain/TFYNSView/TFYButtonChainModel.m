//
//  TFYButtonChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYButtonChainModel.h"

#define TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYButtonChainModel *,NSButton)

@implementation TFYButtonChainModel

TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(title, NSString*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(attributedTitle, NSAttributedString*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(alternateTitle, NSString*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(attributedAlternateTitle, NSAttributedString*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(hasDestructiveAction, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(sound, NSSound*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(springLoaded, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(maxAcceleratorLevel, NSInteger)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(bezelStyle, NSBezelStyle)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(bordered, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(transparent, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(showsBorderOnlyWhileMouseInside, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(image, NSImage*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(alternateImage, NSImage*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(imagePosition, NSCellImagePosition)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(imageScaling, NSImageScaling)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(imageHugsTitle, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(symbolConfiguration, NSImageSymbolConfiguration*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(bezelColor, NSColor*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(contentTintColor, NSColor*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(state, NSControlStateValue)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(allowsMixedState, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(keyEquivalent, NSString*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(keyEquivalentModifierMask, NSEventModifierFlags)

- (TFYButtonChainModel * _Nonnull (^)(NSButtonType))setButtonType{
    return ^(NSButtonType type)
    {
        [self enumerateObjectsUsingBlock:^(NSButton * _Nonnull obj) {
            [obj setButtonType:type];
        }];
        return self;
    };
}

- (TFYButtonChainModel * _Nonnull (^)(float,float))setPeriodicDelay_interval{
    return ^(float delay,float interval)
    {
        [self enumerateObjectsUsingBlock:^(NSButton * _Nonnull obj) {
            [obj setPeriodicDelay:delay interval:interval];
        }];
        return self;
    };
}

- (TFYButtonChainModel * _Nonnull (^)(float*,float*))getPeriodicDelay_interval{
    return ^(float* delay,float* interval)
    {
        [self enumerateObjectsUsingBlock:^(NSButton * _Nonnull obj) {
            [obj getPeriodicDelay:delay interval:interval];
        }];
        return self;
    };
}

- (TFYButtonChainModel * _Nonnull (^)(NSColor*))textColor{
    return ^(NSColor* color)
    {
        [self enumerateObjectsUsingBlock:^(NSButton * _Nonnull obj) {
            if (obj.title.length > 0) {
                obj.attributedTitle = [[NSAttributedString alloc] initWithString:obj.title];
            }
            obj.tfy_textColor = color;
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSButton, TFYButtonChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
