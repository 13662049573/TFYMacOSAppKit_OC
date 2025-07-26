//
//  TFYSearchFieldChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYSearchFieldChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYSearchFieldChainModel *,NSSearchField)

@implementation TFYSearchFieldChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(recentSearches, NSArray<NSString *> *)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(recentsAutosaveName, NSSearchFieldRecentsAutosaveName)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(searchMenuTemplate, NSMenu*)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(sendsWholeSearchString, BOOL)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(maximumRecents, NSInteger)
TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(sendsSearchStringImmediately, BOOL)

- (TFYSearchFieldChainModel * _Nonnull (^)(id<NSSearchFieldDelegate>))delegateSearch {
    return ^(id<NSSearchFieldDelegate> delegateSearch)
    {
        ((NSSearchField*)self.controlview).delegate = delegateSearch;
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSSearchField, TFYSearchFieldChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
