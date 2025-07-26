//
//  TFYSearchFieldChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYTextFieldChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYSearchFieldChainModel : TFYTextFieldChainModel

TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ recentSearches) (NSArray<NSString *> *);
TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ recentsAutosaveName) (NSSearchFieldRecentsAutosaveName);
TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ searchMenuTemplate) (NSMenu*);
TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ sendsWholeSearchString) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ maximumRecents) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ sendsSearchStringImmediately) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYSearchFieldChainModel * (^ delegateSearch) (id<NSSearchFieldDelegate>);

@end
TFY_CATEGORY_EXINTERFACE(NSSearchField, TFYSearchFieldChainModel)
NS_ASSUME_NONNULL_END
