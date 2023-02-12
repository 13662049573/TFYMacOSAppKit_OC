//
//  TFYGridViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYGridViewChainModel.h"

#define TFY_CATEGORY_CHAIN_GRID_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYGridViewChainModel *,NSGridView)

@implementation TFYGridViewChainModel

TFY_CATEGORY_CHAIN_GRID_IMPLEMENTATION(xPlacement, NSGridCellPlacement)
TFY_CATEGORY_CHAIN_GRID_IMPLEMENTATION(yPlacement, NSGridCellPlacement)
TFY_CATEGORY_CHAIN_GRID_IMPLEMENTATION(rowAlignment, NSGridRowAlignment)
TFY_CATEGORY_CHAIN_GRID_IMPLEMENTATION(rowSpacing, CGFloat)
TFY_CATEGORY_CHAIN_GRID_IMPLEMENTATION(columnSpacing, CGFloat)

- (TFYGridViewChainModel * _Nonnull (^)(NSRange,NSRange))mergeCellsInHorizontalRange_vRange{
    return ^(NSRange hRange,NSRange vRange)
    {
        [self enumerateObjectsUsingBlock:^(NSGridView * _Nonnull obj) {
            [obj mergeCellsInHorizontalRange:hRange verticalRange:vRange];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSGridView, TFYGridViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION

