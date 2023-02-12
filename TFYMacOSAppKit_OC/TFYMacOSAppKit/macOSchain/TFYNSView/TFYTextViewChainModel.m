//
//  TFYTextViewChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYTextViewChainModel.h"

#define TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTextViewChainModel *,NSTextView)

@implementation TFYTextViewChainModel

TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(textContainer, NSTextContainer*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(textContainerInset, NSSize)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(selectedRanges, NSArray<NSValue *> *)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(selectionGranularity, NSSelectionGranularity)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(selectedTextAttributes, NSDictionary*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(insertionPointColor, NSColor*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(markedTextAttributes, NSDictionary*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(linkTextAttributes, NSDictionary*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(displaysLinkToolTips, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(acceptsGlyphInfo, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(usesRuler, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(usesInspectorBar, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(continuousSpellCheckingEnabled, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(grammarCheckingEnabled, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(allowsDocumentBackgroundColorChange, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(allowsImageEditing, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(usesRolloverButtonForSelection, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(editable, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(selectable, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(richText, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(fieldEditor, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(rulerVisible, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(importsGraphics, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(drawsBackground, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(usesFontPanel, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(smartInsertDeleteEnabled, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(usesFindBar, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(incrementalSearchingEnabled, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(automaticTextCompletionEnabled, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(allowsCharacterPickerTouchBarItem, BOOL)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(typingAttributes, NSDictionary*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(defaultParagraphStyle, NSParagraphStyle*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(delegate, id<NSTextViewDelegate>)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(backgroundColor, NSColor*)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(allowedInputSourceLocales, NSArray<NSString *> *)
TFY_CATEGORY_CHAIN_TESTVIEW_IMPLEMENTATION(enabledTextCheckingTypes, NSTextCheckingTypes)

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSTextView, TFYTextViewChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION

