//
//  TFYPredicateEditorChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYPredicateEditorChainModel.h"

#define TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYPredicateEditorChainModel *,NSPredicateEditor)

@implementation TFYPredicateEditorChainModel

TFY_CATEGORY_CHAIN_UNIFICATION_IMPLEMENTATION(rowTemplates, NSArray<NSPredicateEditorRowTemplate *> *)

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSPredicateEditor, TFYPredicateEditorChainModel)
#undef TFY_CATEGORY_CHAIN_BUTTON_IMPLEMENTATION
