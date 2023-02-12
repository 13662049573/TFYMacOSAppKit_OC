//
//  TFYBoxChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBoxChainModel.h"

#define TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYBoxChainModel *,NSBox)

@implementation TFYBoxChainModel

TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(boxType, NSBoxType)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(titlePosition, NSTitlePosition)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(title, NSString*)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(titleFont, NSFont*)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(contentViewMargins, NSSize)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(contentView, NSView*)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(transparent, BOOL)
TFY_CATEGORY_CHAIN_BOX_IMPLEMENTATION(fillColor, NSColor*)

- (TFYBoxChainModel * _Nonnull (^)(void))sizeToFit{
    return ^()
    {
        [self enumerateObjectsUsingBlock:^(NSBox * _Nonnull obj) {
            [obj sizeToFit];
        }];
        return self;
    };
}


@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSBox, TFYBoxChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
