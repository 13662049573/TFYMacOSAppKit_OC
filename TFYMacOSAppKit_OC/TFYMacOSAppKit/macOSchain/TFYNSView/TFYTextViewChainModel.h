//
//  TFYTextViewChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYTextChainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYTextViewChainModel : TFYTextChainModel

TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ textContainer) (NSTextContainer*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ textContainerInset) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ selectedRanges) (NSArray<NSValue *> *);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ selectionGranularity) (NSSelectionGranularity);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ selectedTextAttributes) (NSDictionary*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ insertionPointColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ markedTextAttributes) (NSDictionary*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ linkTextAttributes) (NSDictionary*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ displaysLinkToolTips) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ acceptsGlyphInfo) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ usesRuler) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ usesInspectorBar) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ continuousSpellCheckingEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ grammarCheckingEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ typingAttributes) (NSDictionary*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ allowsDocumentBackgroundColorChange) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ defaultParagraphStyle) (NSParagraphStyle*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ allowsImageEditing) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ usesRolloverButtonForSelection) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ delegateView) (id<NSTextViewDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ selectable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ richText) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ fieldEditor) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ rulerVisible) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ importsGraphics) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ usesFontPanel) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ allowedInputSourceLocales) (NSArray<NSString *> *);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ smartInsertDeleteEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ enabledTextCheckingTypes) (NSTextCheckingTypes);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ usesFindPanel) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ usesFindBar) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ incrementalSearchingEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ automaticTextCompletionEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextViewChainModel * (^ allowsCharacterPickerTouchBarItem) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSTextView, TFYTextViewChainModel)
NS_ASSUME_NONNULL_END
