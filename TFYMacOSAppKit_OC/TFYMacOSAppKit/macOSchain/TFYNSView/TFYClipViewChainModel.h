//
//  TFYClipViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYClipViewChainModel;
@interface TFYClipViewChainModel : TFYBaseViewChainModel<TFYClipViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYClipViewChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYClipViewChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYClipViewChainModel * (^ documentView) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYClipViewChainModel * (^ documentCursor) (NSCursor*);
TFY_PROPERTY_CHAIN_READONLY TFYClipViewChainModel * (^ contentInsets) (NSEdgeInsets);
TFY_PROPERTY_CHAIN_READONLY TFYClipViewChainModel * (^ scrollToPoint) (NSPoint);

@end
TFY_CATEGORY_EXINTERFACE(NSClipView, TFYClipViewChainModel)
NS_ASSUME_NONNULL_END
