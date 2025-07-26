//
//  TFYRuleEditorChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYRuleEditorChainModel;
@interface TFYRuleEditorChainModel : TFYBaseControlChainModel<TFYRuleEditorChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ delegate) (id<NSRuleEditorDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ formattingStringsFilename) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ formattingDictionary) (NSDictionary *);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ nestingMode) (NSRuleEditorNestingMode);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ rowHeight) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ canRemoveAllRows) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ rowClass) (Class);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ rowTypeKeyPath) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ subrowsKeyPath) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ criteriaKeyPath) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYRuleEditorChainModel * (^ displayValuesKeyPath) (NSString*);

@end
TFY_CATEGORY_EXINTERFACE(NSRuleEditor, TFYRuleEditorChainModel)
NS_ASSUME_NONNULL_END
