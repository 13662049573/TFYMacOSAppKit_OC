//
//  TFYGridViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYGridViewChainModel;
@interface TFYGridViewChainModel : TFYBaseViewChainModel<TFYGridViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYGridViewChainModel * (^ xPlacement) (NSGridCellPlacement);
TFY_PROPERTY_CHAIN_READONLY TFYGridViewChainModel * (^ yPlacement) (NSGridCellPlacement);
TFY_PROPERTY_CHAIN_READONLY TFYGridViewChainModel * (^ rowAlignment) (NSGridRowAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYGridViewChainModel * (^ rowSpacing) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYGridViewChainModel * (^ columnSpacing) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYGridViewChainModel * (^ mergeCellsInHorizontalRange_vRange) (NSRange,NSRange);

@end
CG_INLINE NSGridView * gridViewWithViews(NSArray<NSArray<NSView *> *> * rows){
    return [NSGridView gridViewWithViews:rows];
}
CG_INLINE NSGridView * gridViewWithNumberOfColumns(NSInteger columnCount,NSInteger rowCount){
    return [NSGridView gridViewWithNumberOfColumns:columnCount rows:rowCount];
}
TFY_CATEGORY_EXINTERFACE(NSGridView, TFYGridViewChainModel)
NS_ASSUME_NONNULL_END
