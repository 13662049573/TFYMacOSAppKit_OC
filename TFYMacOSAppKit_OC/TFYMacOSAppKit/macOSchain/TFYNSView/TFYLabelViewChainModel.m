//
//  TFYLabelViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/14.
//

#import "TFYLabelViewChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYLabelViewChainModel *,TFYLabel)


@implementation TFYLabelViewChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(title, NSString*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(font, NSFont*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(textColor, NSColor*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(textAlignment, NSTextAlignment)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(contentVerticalAlignment, TFYContentVerticalAlignment)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(lineBreakMode, NSLineBreakMode)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(attributedText, NSAttributedString*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(highlightedTextColor, NSColor*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(highlighted, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(userInteractionEnabled, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(enabled, BOOL)

- (TFYLabelViewChainModel * _Nonnull (^)(void (^ _Nonnull)(__kindof TFYLabel * _Nonnull)))actionBlock {
    return ^ (action block){
        [self enumerateObjectsUsingBlock:^(TFYLabel * _Nonnull obj) {
            [obj actionBlock:block];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(TFYLabel, TFYLabelViewChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

