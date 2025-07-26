//
//  TFYBoxChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYBoxChainModel;
@interface TFYBoxChainModel : TFYBaseViewChainModel<TFYBoxChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ boxType) (NSBoxType);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ titlePosition) (NSTitlePosition);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ title) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ titleFont) (NSFont*);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ contentViewMargins) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ contentView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ transparent) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ fillColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYBoxChainModel * (^ sizeToFit) (void);

@end
TFY_CATEGORY_EXINTERFACE(NSBox, TFYBoxChainModel)
NS_ASSUME_NONNULL_END
