//
//  TFYPopUpButtonChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYPopUpButtonChainModel.h"

#define TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYPopUpButtonChainModel *,NSPopUpButton)

@implementation TFYPopUpButtonChainModel

TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(menu, NSMenu*)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(pullsDown, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(autoenablesItems, BOOL)
TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION(preferredEdge, NSRectEdge)

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSString*))addItemWithTitle{
    return ^(NSString*title)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj addItemWithTitle:title];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSArray<NSString *> *))addItemsWithTitles{
    return ^(NSArray<NSString *> *itemTitles)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj addItemsWithTitles:itemTitles];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSString*,NSInteger))insertItemWithTitle_atIndex{
    return ^(NSString*title,NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj insertItemWithTitle:title atIndex:index];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSString*))removeItemWithTitle{
    return ^(NSString*title)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj removeItemWithTitle:title];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSInteger))removeItemAtIndex{
    return ^(NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj removeItemAtIndex:index];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(void))removeAllItems{
    return ^()
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj removeAllItems];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSMenuItem*))selectItem{
    return ^(NSMenuItem*item)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj selectItem:item];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSInteger))selectItemAtIndex{
    return ^(NSInteger index)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj selectItemAtIndex:index];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSString*))selectItemWithTitle{
    return ^(NSString*title)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj selectItemWithTitle:title];
        }];
        return self;
    };
}

- (TFYPopUpButtonChainModel * _Nonnull (^)(NSString*))setTitle{
    return ^(NSString*title)
    {
        [self enumerateObjectsUsingBlock:^(NSPopUpButton * _Nonnull obj) {
            [obj setTitle:title];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSPopUpButton, TFYPopUpButtonChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
