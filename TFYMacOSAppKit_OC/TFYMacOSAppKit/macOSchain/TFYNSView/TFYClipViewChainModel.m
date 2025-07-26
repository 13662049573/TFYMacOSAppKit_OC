//
//  TFYClipViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYClipViewChainModel.h"

#define TFY_CATEGORY_CHAIN_CLIPVIEW_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYClipViewChainModel *,NSClipView)

@implementation TFYClipViewChainModel

TFY_CATEGORY_CHAIN_CLIPVIEW_IMPLEMENTATION(backgroundColor, NSColor*)
TFY_CATEGORY_CHAIN_CLIPVIEW_IMPLEMENTATION(drawsBackground, BOOL)
TFY_CATEGORY_CHAIN_CLIPVIEW_IMPLEMENTATION(documentView, NSView*)
TFY_CATEGORY_CHAIN_CLIPVIEW_IMPLEMENTATION(documentCursor, NSCursor*)
TFY_CATEGORY_CHAIN_CLIPVIEW_IMPLEMENTATION(contentInsets, NSEdgeInsets)

- (TFYClipViewChainModel * _Nonnull (^)(NSPoint))scrollToPoint{
    return ^(NSPoint newOrigin)
    {
        [self enumerateObjectsUsingBlock:^(NSClipView * _Nonnull obj) {
            [obj scrollToPoint:newOrigin];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSClipView, TFYClipViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
