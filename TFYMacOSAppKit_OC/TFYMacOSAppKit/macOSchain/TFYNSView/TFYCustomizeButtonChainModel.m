//
//  TFYCustomizeButtonChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYCustomizeButtonChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYCustomizeButtonChainModel *,TFYButton)


@implementation TFYCustomizeButtonChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(buttonType, TFYButtonType)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(selected, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(showHighlighted, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(isAttributedTitle, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(titleColor, NSColor*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(backgroundImage, NSImage*)


- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSString*,TFYControlState))title_forState{
    return ^(NSString* title,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setTitle:title forState:state];
        }];
        return self;
    };
}

- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSColor*,TFYControlState))titleColor_forState{
    return ^(NSColor* color,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setTitleColor:color forState:state];
        }];
        return self;
    };
}

- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSAttributedString*,TFYControlState))attributedTitle_forState{
    return ^(NSAttributedString* attrString,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setAttributedTitle:attrString forState:state];
        }];
        return self;
    };
}

- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSImage*,TFYControlState))backgroundImage_forState{
    return ^(NSImage* image,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setBackgroundImage:image forState:state];
        }];
        return self;
    };
}

- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSColor*,TFYControlState))borderColor_forState {
    return ^(NSColor* color,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setBorderColor:color forState:state];
        }];
        return self;
    };
}

- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSNumber*,TFYControlState))borderWidth_forState{
    return ^(NSNumber* title,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setBorderWidth:title forState:state];
        }];
        return self;
    };
}

- (TFYCustomizeButtonChainModel * _Nonnull (^)(NSNumber*,TFYControlState))cornerRadius_forState{
    return ^(NSNumber* title,TFYControlState state)
    {
        [self enumerateObjectsUsingBlock:^(TFYButton * _Nonnull obj) {
            [obj setCornerRadius:title forState:state];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(TFYButton, TFYCustomizeButtonChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

