//
//  TFYTableCellViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYTableCellViewChainModel.h"

#define TFY_CATEGORY_CHAIN_TABLECELL_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTableCellViewChainModel *,NSTableCellView)

@implementation TFYTableCellViewChainModel

TFY_CATEGORY_CHAIN_TABLECELL_IMPLEMENTATION(objectValue, id)
TFY_CATEGORY_CHAIN_TABLECELL_IMPLEMENTATION(backgroundStyle, NSBackgroundStyle)
TFY_CATEGORY_CHAIN_TABLECELL_IMPLEMENTATION(rowSizeStyle, NSTableViewRowSizeStyle)

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSTableCellView, TFYTableCellViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
