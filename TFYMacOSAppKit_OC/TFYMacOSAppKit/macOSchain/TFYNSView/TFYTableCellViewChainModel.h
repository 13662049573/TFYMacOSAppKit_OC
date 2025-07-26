//
//  TFYTableCellViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTableCellViewChainModel;
@interface TFYTableCellViewChainModel : TFYBaseViewChainModel<TFYTableCellViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYTableCellViewChainModel * (^ objectValue) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTableCellViewChainModel * (^ backgroundStyle) (NSBackgroundStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTableCellViewChainModel * (^ rowSizeStyle) (NSTableViewRowSizeStyle);

@end
TFY_CATEGORY_EXINTERFACE(NSTableCellView, TFYTableCellViewChainModel)
NS_ASSUME_NONNULL_END
