//
//  TFYStackViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYStackViewChainModel.h"

#define TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYStackViewChainModel *,NSStackView)

@implementation TFYStackViewChainModel

TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(delegate, id<NSStackViewDelegate>)
TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(orientation, NSUserInterfaceLayoutOrientation)
TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(alignment, NSLayoutAttribute)
TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(edgeInsets, NSEdgeInsets)
TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(distribution, NSStackViewDistribution)
TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(spacing, CGFloat)
TFY_CATEGORY_CHAIN_STACK_IMPLEMENTATION(detachesHiddenViews, BOOL)

- (TFYStackViewChainModel * _Nonnull (^)(CGFloat,NSView*))setCustomSpacing_afterView{
    return ^(CGFloat spacing,NSView *view)
    {
        [self enumerateObjectsUsingBlock:^(NSStackView * _Nonnull obj) {
            [obj setCustomSpacing:spacing afterView:view];
        }];
        return self;
    };
}

- (TFYStackViewChainModel * _Nonnull (^)(NSView*))addArrangedSubview{
    return ^(NSView *view)
    {
        [self enumerateObjectsUsingBlock:^(NSStackView * _Nonnull obj) {
            [obj addArrangedSubview:view];
        }];
        return self;
    };
}

- (TFYStackViewChainModel * _Nonnull (^)(NSView*,NSInteger))insertArrangedSubview_atIndex{
    return ^(NSView *view,NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSStackView * _Nonnull obj) {
            [obj insertArrangedSubview:view atIndex:index];
        }];
        return self;
    };
}

- (TFYStackViewChainModel * _Nonnull (^)(NSView*))removeArrangedSubview{
    return ^(NSView *view)
    {
        [self enumerateObjectsUsingBlock:^(NSStackView * _Nonnull obj) {
            [obj removeArrangedSubview:view];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSStackView, TFYStackViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION

