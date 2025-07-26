//
//  TFYOutlineViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYOutlineViewChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYOutlineViewChainModel *,NSOutlineView)

@implementation TFYOutlineViewChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(outlineTableColumn, NSTableColumn*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(indentationPerLevel, CGFloat)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(indentationMarkerFollowsCell, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(autoresizesOutlineColumn, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(autosaveExpandedItems, BOOL)

- (TFYOutlineViewChainModel * _Nonnull (^)(id<NSOutlineViewDelegate>))delegateOutline {
    return ^(id<NSOutlineViewDelegate> delegateOutline)
    {
        ((NSOutlineView*)self.controlview).delegate = delegateOutline;
        return self;
    };
}

- (TFYOutlineViewChainModel * _Nonnull (^)(id<NSOutlineViewDataSource>))dataSourceOutline {
    return ^(id<NSOutlineViewDataSource> dataSourceOutline)
    {
        ((NSOutlineView*)self.controlview).dataSource = dataSourceOutline;
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSOutlineView, TFYOutlineViewChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION

