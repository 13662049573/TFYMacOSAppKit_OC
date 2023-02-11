//
//  NSAttributedString+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


#import "NSAttributedString+Dejal.h"
#import "NSString+Dejal.h"


@implementation NSAttributedString (Dejal)

/**
 创建并返回一个空的、自动释放的带属性字符串的方便方法。
*/

+ (instancetype)tfy_attributedString;
{
    return [[self alloc] initWithString:@""];
}

/**
 从指定的字符串创建并返回自动释放的带属性字符串的简便方法。
*/

+ (instancetype)tfy_attributedStringWithString:(NSString *)string;
{
    return [[self alloc] initWithString:string];
}

/**
 从指定的字符串和属性创建并返回自动释放的带属性字符串的简便方法。
*/

+ (instancetype)tfy_attributedStringWithString:(NSString *)string attributes:(NSDictionary *)attributes
{
    return [[self alloc] initWithString:string attributes:attributes];
}

/**
 从RTF格式的字符串中返回一个新的带属性字符串实例。

 RTF格式的字符串。
 对应的带属性字符串。
 */

+ (instancetype)tfy_attributedStringWithRTFString:(NSString *)rtfString;
{
    return [self tfy_attributedStringWithRTFData:[rtfString dataUsingEncoding:NSUTF8StringEncoding]];
}

/**
 从RTF格式的数据中返回一个新的带属性字符串实例。

 rtfData包含RTF格式的数据。
 对应的带属性字符串。
 */

+ (instancetype)tfy_attributedStringWithRTFData:(NSData *)rtfData;
{
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSRTFTextDocumentType};
    NSAttributedString *attrib = [[self alloc] initWithData:rtfData options:options documentAttributes:nil error:nil];
    
    return attrib;
}

/**
 返回一个包含接收器RTF格式表示的字符串。
 */

- (NSString *)tfy_rtfString;
{
    NSData *data = [self tfy_rtfData];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

/**
 返回包含接收器RTF格式表示的数据。
 */

- (NSData *)tfy_rtfData;
{
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSRTFTextDocumentType};
    NSData *data = [self dataFromRange:NSMakeRange(0, [self length]) documentAttributes:options error: nil];
    
    return data;
}

/**
 返回包含整个带属性字符串的范围。
*/

- (NSRange)tfy_allRange;
{
    return NSMakeRange(0, [self length]);
}

/**
 将指定范围文本中的所有文本的字体大小调整为指定的大小。

 offsetPoints一个正数来增加字体大小，或者一个负数来减少字体大小。
 要调整的范围(使用-allRange调整整个字符串)。
 @返回一个带有调整后文本的新带属性字符串。
 */

- (NSAttributedString *)tfy_attributedStringWithFontSizeAdjustmentOffset:(CGFloat)offsetPoints inRange:(NSRange)range;
{
    NSMutableAttributedString *mutie = [self mutableCopy];
    
    [mutie beginEditing];
    
    [mutie enumerateAttribute:NSFontAttributeName inRange:range options:0 usingBlock:^(id attribute, NSRange attributeRange, BOOL *stop)
     {
        if (attribute)
        {
#if TARGET_OS_IPHONE
            UIFont *oldFont = (UIFont *)attribute;
            UIFont *newFont = [oldFont fontWithSize:oldFont.pointSize + offsetPoints];
#else
            NSFont *oldFont = (NSFont *)attribute;
            NSFont *newFont = [NSFont fontWithName:oldFont.fontName size:oldFont.pointSize + offsetPoints];
#endif
            
            [mutie removeAttribute:NSFontAttributeName range:attributeRange];
            [mutie addAttribute:NSFontAttributeName value:newFont range:attributeRange];
        }
    }];
    
    [mutie endEditing];
    
    return mutie;
}

/**
 将指定范围文本中的所有文本的字体大小调整为两倍或一半。

 如果是，字体大小将增加一倍;如果否，则减半。
 要调整的范围(使用-allRange调整整个字符串)。
 @返回一个带有调整后文本的新带属性字符串。
 */

- (NSAttributedString *)tfy_attributedStringWithFontSizeIncrease:(BOOL)increase inRange:(NSRange)range;
{
    NSMutableAttributedString *mutie = [self mutableCopy];
    
    [mutie beginEditing];
    
    [mutie enumerateAttribute:NSFontAttributeName inRange:range options:0 usingBlock:^(id attribute, NSRange attributeRange, BOOL *stop)
     {
        if (attribute)
        {
            CGFloat factor = increase ? 2.0 : 0.5;
            
#if TARGET_OS_IPHONE
            UIFont *oldFont = (UIFont *)attribute;
            UIFont *newFont = [oldFont fontWithSize:oldFont.pointSize * factor];
#else
            NSFont *oldFont = (NSFont *)attribute;
            NSFont *newFont = [NSFont fontWithName:oldFont.fontName size:oldFont.pointSize * factor];
#endif
            
            [mutie removeAttribute:NSFontAttributeName range:attributeRange];
            [mutie addAttribute:NSFontAttributeName value:newFont range:attributeRange];
        }
    }];
    
    [mutie endEditing];
    
    return mutie;
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSMutableAttributedString (Dejal)

/**
 使用指定的属性将字符串追加到接收方。
*/

- (void)tfy_appendString:(NSString *)string withAttributes:(NSDictionary *)attributes;
{
    [self appendAttributedString:[[self class] tfy_attributedStringWithString:string attributes:attributes]];
}

/**
 使用指定的属性将字符串插入到接收器的索引位置。
*/

- (void)tfy_insertString:(NSString *)string withAttributes:(NSDictionary *)attributes atIndex:(NSUInteger)i;
{
    [self insertAttributedString:[[self class] tfy_attributedStringWithString:string attributes:attributes] atIndex:i];
}

@end

