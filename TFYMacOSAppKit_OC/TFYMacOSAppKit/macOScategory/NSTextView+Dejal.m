//
//  NSTextView+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import "NSTextView+Dejal.h"
#import "NSAttributedString+Dejal.h"


@implementation NSTextView (Dejal)

/**
 返回文本视图中的字符数。
*/

- (NSInteger)tfy_length
{
    return [[self string] length];
}

/**
 返回一个包含文本视图中所有字符的NSRange。
*/

- (NSRange)tfy_allRange
{
    return NSMakeRange(0, [self tfy_length]);
}

/**
 在改变NSTextView的字体或前景色/背景颜色之后，调用这个函数将这些更改应用到零长度的选择(即下一个用户输入)。否则，将在旧样式中插入新的类型(有时这很有用)。
*/

- (void)tfy_setTypingAttributesToMatchView;
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    attributes[NSFontAttributeName] = [self font];
    attributes[NSForegroundColorAttributeName] = [self textColor];
    attributes[NSBackgroundColorAttributeName] = [self backgroundColor];
    
    [self setTypingAttributes:attributes];
}

/**
 动作方法选择无文本;-selectAll:的反义词。在当前选择的开始处(如果有的话)创建插入点。如果没有选择，什么都不做。
*/

- (IBAction)deselectAll:(id)sender;
{
    NSRange range = [self selectedRange];
    
    if (range.length == 0)
        return;
    
    range.length = 0;
    
    [self setSelectedRange:range];
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 将指定的普通字符串追加到接收器的末尾。
*/

- (void)tfy_appendStringValue:(NSString *)value
{
    [[self textStorage] appendAttributedString:[NSAttributedString tfy_attributedStringWithString:value]];
}

/**
 将指定的带属性字符串追加到接收器的末尾。
*/

- (void)tfy_appendAttributedStringValue:(NSAttributedString *)value
{
    [[self textStorage] appendAttributedString:value];
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 以普通字符串的形式返回接收方所选文本的自动释放副本。
*/

- (NSString *)tfy_selectedStringValue
{
    NSRange range = [self selectedRange];
    
    if (range.length == 0)
        return @"";
    else
        return [[self string] substringWithRange:range];
}

/**
 以普通字符串的形式返回接收方所选文本的自动释放副本。
*/

- (NSString *)tfy_selectedOrAllStringValue
{
    NSRange range = [self selectedRange];
    
    if (range.length == 0)
        return [self tfy_stringValue];
    else
        return [[self string] substringWithRange:range];
}

/**
 以带属性字符串的形式返回接收方所选文本的自动释放副本。
*/

- (NSAttributedString *)tfy_selectedAttributedStringValue
{
    NSRange range = [self selectedRange];
    
    if (range.length == 0)
        return [NSAttributedString tfy_attributedString];
    else
        return [[self textStorage] attributedSubstringFromRange:range];
}

/**
 以带属性字符串的形式返回接收方所选文本的自动释放副本。
*/

- (NSAttributedString *)tfy_selectedOrAllAttributedStringValue
{
    NSRange range = [self selectedRange];
    
    if (range.length == 0)
        return [self tfy_attributedStringValue];
    else
        return [[self textStorage] attributedSubstringFromRange:range];
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 以普通字符串的形式返回文本的自动释放副本;请参见非复制版本的标准-string方法。
*/

- (NSString *)tfy_stringValue
{
    return [[self string] copy];
}

/**
 以带属性字符串的形式返回文本的自动释放副本。
*/

- (NSAttributedString *)tfy_attributedStringValue
{
    return [[self textStorage] copy];
}

/**
 返回文本的RTF版本。
*/

- (NSData *)tfy_RTFValue
{
    NSAttributedString *text = [self tfy_attributedStringValue];
    
    return [text RTFFromRange:NSMakeRange(0, [text length]) documentAttributes:@{}];
}

/**
 返回文本的RTFD版本。
*/

- (NSData *)tfy_RTFDValue
{
    NSAttributedString *text = [self tfy_attributedStringValue];
    
    return [text RTFDFromRange:NSMakeRange(0, [text length]) documentAttributes:@{}];
}


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


/**
 将所有文本替换为指定的纯字符串(使用当前字体等)
*/

- (void)tfy_setStringValue:(NSString *)value
{
    if (value)
        [self replaceCharactersInRange:[self tfy_allRange] withString:value];
}

/**
 将所有文本替换为指定的带属性字符串。
*/

- (void)tfy_setAttributedStringValue:(NSAttributedString *)value
{
    if (value)
        [[self textStorage] replaceCharactersInRange:[self tfy_allRange] withAttributedString:[value copy]];
}

/**
 将所有文本替换为指定的RTF数据。
*/

- (void)tfy_setRTFValue:(NSData *)value
{
    [self replaceCharactersInRange:[self tfy_allRange] withRTF:value];
}

/**
 将所有文本替换为指定的RTFD数据。
*/

- (void)tfy_setRTFDValue:(NSData *)value
{
    [self replaceCharactersInRange:[self tfy_allRange] withRTFD:value];
}


/**
 用最丰富的指定值替换所有文本;Any或all可以为nil。如果都无效，则清除文本。
*/

- (void)tfy_setRTFDValue:(NSData *)theRTFD orRTF:(NSData *)theRTF orAttributedString:(NSAttributedString *)attrString orString:(NSString *)string
{
    if ([theRTFD length])
        [self tfy_setRTFDValue:theRTFD];
    else if ([theRTF length])
        [self tfy_setRTFValue:theRTF];
    else if ([attrString length])
        [self tfy_setAttributedStringValue:attrString];
    else if (string)
        [self tfy_setStringValue:string];
    else
        [self tfy_setStringValue:@""];
}

@end

