//
//  TFYTextFieldChainModel.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "TFYBaseControlChainModel.h"
#import "NSTextField+Dejal.h"

NS_ASSUME_NONNULL_BEGIN
@class TFYTextFieldChainModel;
@interface TFYTextFieldChainModel : TFYBaseControlChainModel<TFYTextFieldChainModel*>

TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ placeholderString) (NSString*);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ placeholderStringColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ placeholderAttributedString) (NSAttributedString*);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ backgroundColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ drawsBackground) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ textColor) (NSColor*);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ bordered) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ bezeled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ editable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ selectable) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ delegate) (id<NSTextFieldDelegate>);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ bezelStyle) (NSTextFieldBezelStyle);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ preferredMaxLayoutWidth) (CGFloat);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ maximumNumberOfLines) (NSInteger);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ allowsDefaultTighteningForTruncation) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ lineBreakStrategy) (NSLineBreakStrategy);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ automaticTextCompletionEnabled) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ allowsCharacterPickerTouchBarItem) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ allowsEditingTextAttributes) (BOOL);
TFY_PROPERTY_CHAIN_READONLY TFYTextFieldChainModel * (^ importsGraphics) (BOOL);

@end
TFY_CATEGORY_EXINTERFACE(NSTextField, TFYTextFieldChainModel)
NS_ASSUME_NONNULL_END
