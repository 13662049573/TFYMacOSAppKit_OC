//
//  TFYSplitViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYSplitViewChainModel;
@interface TFYSplitViewChainModel : TFYBaseViewChainModel<TFYSplitViewChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ vertical) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ dividerStyle) (NSSplitViewDividerStyle);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ autosaveName) (NSSplitViewAutosaveName);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ delegate) (id<NSSplitViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ drawDividerInRect) (NSRect);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ adjustSubviews) (void);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ setPosition_Index) (CGFloat,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ setHoldingPriority_forIndex) (NSLayoutPriority,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ arrangesAllSubviews) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ addArrangedSubview) (NSView*);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ insertArrangedSubview_atIndex) (NSView*,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSplitViewChainModel * (^ removeArrangedSubview) (NSView*);

@end
TFY_CATEGORY_EXINTERFACE(NSSplitView, TFYSplitViewChainModel)
NS_ASSUME_NONNULL_END
