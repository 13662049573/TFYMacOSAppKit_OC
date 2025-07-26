//
//  TFYTextChainModel.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/12.
//

#import "TFYTextChainModel.h"

#define TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(TFYMethod,TFYParaType) TFY_CATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(TFYMethod,TFYParaType, TFYTextChainModel *,NSText)

@implementation TFYTextChainModel

TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(string, NSString*)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(delegate, id<NSTextDelegate>)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(editable, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(selectable, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(richText, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(fieldEditor, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(importsGraphics, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(usesFontPanel, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(drawsBackground, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(backgroundColor, NSColor*)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(selectedRange, NSRange)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(font, NSFont*)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(textColor, NSColor*)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(alignment, NSTextAlignment)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(baseWritingDirection, NSWritingDirection)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(maxSize, NSSize)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(minSize, NSSize)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(horizontallyResizable, BOOL)
TFY_CATEGORY_CHAIN_TEST_IMPLEMENTATION(verticallyResizable, BOOL)

- (TFYTextChainModel * _Nonnull (^)(NSRange,NSString*))replaceCharactersInRange_String{
    return ^(NSRange range,NSString*string)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj replaceCharactersInRange:range withString:string];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(NSRange,NSData*))replaceCharactersInRange_RTF{
    return ^(NSRange range,NSData*rtfData)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj replaceCharactersInRange:range withRTF:rtfData];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(NSRange,NSData*))replaceCharactersInRange_RTFD{
    return ^(NSRange range,NSData*rtfdData)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj replaceCharactersInRange:range withRTFD:rtfdData];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(NSRange))scrollRangeToVisible{
    return ^(NSRange range)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj scrollRangeToVisible:range];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(NSColor*,NSRange))setTextColor_range{
    return ^(NSColor *color,NSRange range)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj setTextColor:color range:range];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(NSFont*,NSRange))setFont_range{
    return ^(NSFont *font,NSRange range)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj setFont:font range:range];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(void))sizeToFit{
    return ^()
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj sizeToFit];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))copy{
    return ^(id copy)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj copy:copy];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))copyFont{
    return ^(id copyFont)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj copyFont:copyFont];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))copyRuler{
    return ^(id copyRuler)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj copyRuler:copyRuler];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))cut{
    return ^(id cut)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj cut:cut];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))deletes{
    return ^(id delete)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj delete:delete];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))paste{
    return ^(id paste)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj paste:paste];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))pasteFont{
    return ^(id pasteFont)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj pasteFont:pasteFont];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))pasteRuler{
    return ^(id pasteRuler)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj pasteRuler:pasteRuler];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))selectAll{
    return ^(id selectAll)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj selectAll:selectAll];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))changeFont{
    return ^(id changeFont)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj changeFont:changeFont];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))alignLeft{
    return ^(id alignLeft)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj alignLeft:alignLeft];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))alignRight{
    return ^(id alignRight)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj alignRight:alignRight];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))alignCenter{
    return ^(id alignCenter)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj alignCenter:alignCenter];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))subscript{
    return ^(id subscript)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj subscript:subscript];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))superscript{
    return ^(id superscript)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj superscript:superscript];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))underline{
    return ^(id underline)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj underline:underline];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))unscript{
    return ^(id unscript)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj unscript:unscript];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))showGuessPanel{
    return ^(id showGuessPanel)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj showGuessPanel:showGuessPanel];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))checkSpelling{
    return ^(id checkSpelling)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj checkSpelling:checkSpelling];
        }];
        return self;
    };
}

- (TFYTextChainModel * _Nonnull (^)(id))toggleRuler{
    return ^(id toggleRuler)
    {
        [self enumerateObjectsUsingBlock:^(NSText * _Nonnull obj) {
            [obj toggleRuler:toggleRuler];
        }];
        return self;
    };
}

@end
TFY_CATEGORY_VIEW_IMPLEMENTATION(NSText, TFYTextChainModel)
#undef TFY_CATEGORY_CHAIN_DATEPICKER_IMPLEMENTATION
