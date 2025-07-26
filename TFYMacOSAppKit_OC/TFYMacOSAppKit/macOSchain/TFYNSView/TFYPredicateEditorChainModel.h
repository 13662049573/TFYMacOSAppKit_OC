//
//  TFYPredicateEditorChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYRuleEditorChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYPredicateEditorChainModel : TFYRuleEditorChainModel

TFY_PROPERTY_CHAIN_READONLY TFYPredicateEditorChainModel * (^ rowTemplates) (NSArray<NSPredicateEditorRowTemplate *> *);

@end
TFY_CATEGORY_EXINTERFACE(NSPredicateEditor, TFYPredicateEditorChainModel)
NS_ASSUME_NONNULL_END
