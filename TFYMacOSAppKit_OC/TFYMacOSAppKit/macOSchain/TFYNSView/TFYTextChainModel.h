//
//  TFYTextChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYBaseViewChainModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTextChainModel;
@interface TFYTextChainModel : TFYBaseViewChainModel<TFYTextChainModel *>

TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ string) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ delegate) (id<NSTextDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ selectable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ richText) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ fieldEditor) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ importsGraphics) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ usesFontPanel) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ selectedRange) (NSRange);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ font) (NSFont*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ textColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ alignment) (NSTextAlignment);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ baseWritingDirection) (NSWritingDirection);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ maxSize) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ minSize) (NSSize);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ horizontallyResizable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ verticallyResizable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ replaceCharactersInRange_String) (NSRange,NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ replaceCharactersInRange_RTF) (NSRange,NSData*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ replaceCharactersInRange_RTFD) (NSRange,NSData*);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ scrollRangeToVisible) (NSRange);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ setTextColor_range) (NSColor*,NSRange);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ setFont_range) (NSFont*,NSRange);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ sizeToFit) (void);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ copy) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ copyFont) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ copyRuler) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ cut) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ deletes) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ paste) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ pasteFont) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ pasteRuler) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ selectAll) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ changeFont) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ alignLeft) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ alignRight) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ alignCenter) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ subscript) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ superscript) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ underline) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ unscript) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ showGuessPanel) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ checkSpelling) (id);
TFY_PROPERTY_CHAIN_READONLY TFYTextChainModel * (^ toggleRuler) (id);

@end
TFY_CATEGORY_EXINTERFACE(NSText, TFYTextChainModel)
NS_ASSUME_NONNULL_END
