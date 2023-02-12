//
//  TFYSplitViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYSplitViewChainModel.h"

#define TFY_CATEGORY_CHAIN_SPLIT_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYSplitViewChainModel *,NSSplitView)

@implementation TFYSplitViewChainModel

TFY_CATEGORY_CHAIN_SPLIT_IMPLEMENTATION(vertical, BOOL)
TFY_CATEGORY_CHAIN_SPLIT_IMPLEMENTATION(dividerStyle, NSSplitViewDividerStyle)
TFY_CATEGORY_CHAIN_SPLIT_IMPLEMENTATION(autosaveName, NSSplitViewAutosaveName)
TFY_CATEGORY_CHAIN_SPLIT_IMPLEMENTATION(delegate, id<NSSplitViewDelegate>)
TFY_CATEGORY_CHAIN_SPLIT_IMPLEMENTATION(arrangesAllSubviews, BOOL)

- (TFYSplitViewChainModel * _Nonnull (^)(NSRect))drawDividerInRect{
    return ^(NSRect rect)
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj drawDividerInRect:rect];
        }];
        return self;
    };
}

- (TFYSplitViewChainModel * _Nonnull (^)(void))adjustSubviews{
    return ^()
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj adjustSubviews];
        }];
        return self;
    };
}

- (TFYSplitViewChainModel * _Nonnull (^)(CGFloat,NSInteger))setPosition_Index{
    return ^(CGFloat position,NSInteger dividerIndex)
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj setPosition:position ofDividerAtIndex:dividerIndex];
        }];
        return self;
    };
}

- (TFYSplitViewChainModel * _Nonnull (^)(NSLayoutPriority,NSInteger))setHoldingPriority_forIndex{
    return ^(NSLayoutPriority priority,NSInteger subviewIndex)
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj setHoldingPriority:priority forSubviewAtIndex:subviewIndex];
        }];
        return self;
    };
}

- (TFYSplitViewChainModel * _Nonnull (^)(NSView*))addArrangedSubview {
    return ^(NSView *view)
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj addArrangedSubview:view];
        }];
        return self;
    };
}

- (TFYSplitViewChainModel * _Nonnull (^)(NSView*,NSInteger))insertArrangedSubview_atIndex{
    return ^(NSView *view,NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj insertArrangedSubview:view atIndex:index];
        }];
        return self;
    };
}

- (TFYSplitViewChainModel * _Nonnull (^)(NSView*))removeArrangedSubview {
    return ^(NSView *view)
    {
        [self enumerateObjectsUsingBlock:^(NSSplitView * _Nonnull obj) {
            [obj removeArrangedSubview:view];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSSplitView, TFYSplitViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
