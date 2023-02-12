//
//  TFYTabViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYTabViewChainModel.h"

#define TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTabViewChainModel *,NSTabView)

@implementation TFYTabViewChainModel

TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(font, NSFont*)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(tabViewType, NSTabViewType)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(tabPosition, NSTabPosition)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(tabViewBorderType, NSTabViewBorderType)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(tabViewItems, NSArray<__kindof NSTabViewItem *> *)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(allowsTruncatedLabels, BOOL)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(drawsBackground, BOOL)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(controlSize, NSControlSize)
TFY_CATEGORY_CHAIN_TABVIEW_IMPLEMENTATION(delegate, id<NSTabViewDelegate>)

- (TFYTabViewChainModel * _Nonnull (^)(NSTabViewItem*))selectTabViewItem{
    return ^(NSTabViewItem*tabViewItem)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectTabViewItem:tabViewItem];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(NSInteger))selectTabViewItemAtIndex{
    return ^(NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectTabViewItemAtIndex:index];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(id))selectTabViewItemWithIdentifier{
    return ^(id identifier)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectTabViewItemWithIdentifier:identifier];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(id))takeSelectedTabViewItemFromSender{
    return ^(id sender)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj takeSelectedTabViewItemFromSender:sender];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(id))selectFirstTabViewItem{
    return ^(id sender)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectFirstTabViewItem:sender];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(id))selectLastTabViewItem{
    return ^(id sender)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectLastTabViewItem:sender];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(id))selectNextTabViewItem{
    return ^(id sender)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectNextTabViewItem:sender];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(id))selectPreviousTabViewItem {
    return ^(id sender)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj selectPreviousTabViewItem:sender];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(NSTabViewItem*))addTabViewItem{
    return ^(NSTabViewItem*tabViewItem)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj addTabViewItem:tabViewItem];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(NSTabViewItem*,NSInteger))insertTabViewItem_atIndex{
    return ^(NSTabViewItem*tabViewItem,NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj insertTabViewItem:tabViewItem atIndex:index];
        }];
        return self;
    };
}

- (TFYTabViewChainModel * _Nonnull (^)(NSTabViewItem*))removeTabViewItem{
    return ^(NSTabViewItem*tabViewItem)
    {
        [self enumerateObjectsUsingBlock:^(NSTabView * _Nonnull obj) {
            [obj removeTabViewItem:tabViewItem];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSTabView, TFYTabViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
