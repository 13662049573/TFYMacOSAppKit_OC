//
//  TFYPopUpButtonChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYButtonChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYPopUpButtonChainModel : TFYButtonChainModel

TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ menu) (NSMenu*);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ pullsDown) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ autoenablesItems) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ preferredEdge) (NSRectEdge);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ addItemWithTitle) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ addItemsWithTitles) (NSArray<NSString *> *);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ insertItemWithTitle_atIndex) (NSString*,NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ removeItemWithTitle) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ removeItemAtIndex) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ removeAllItems) (void);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ selectItem) (NSMenuItem*);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ selectItemAtIndex) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ selectItemWithTitle) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYPopUpButtonChainModel * (^ setTitle) (NSString*);

@end
TFY_CATEGORY_EXINTERFACE(NSPopUpButton, TFYPopUpButtonChainModel)
NS_ASSUME_NONNULL_END
