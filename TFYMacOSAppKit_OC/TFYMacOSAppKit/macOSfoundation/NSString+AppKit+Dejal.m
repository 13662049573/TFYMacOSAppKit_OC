//
//  NSString+AppKit+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSString+AppKit+Dejal.h"
#import "NSDictionary+AppKit+Dejal.h"


@implementation NSString (DejalAppKit)

/**
 计算指定字体的接收器宽度的方便方法。

 要使用的字体。传递nil来使用系统字体。
 @返回该字体的接收器宽度。
 */

- (CGFloat)tfy_widthWithFont:(NSFont *)font;
{
    if (!font)
        font = [NSFont systemFontOfSize:0.0];
    
    return [self sizeWithAttributes:@{@"NSFontAttributeName" : font}].width;
}

/**
 返回完整的指定字符串，如果原始字符串太长，无法满足所需的宽度，则返回被截断的指示符字符串。指示器字符串通常是一个省略号(…);传递nil将默认为这个。字符串按照请求在左边或右边进行修剪。
*/

- (NSString *)tfy_truncatedStringWithIndicator:(NSString *)indicator forFont:(NSFont *)font withWidth:(NSUInteger)desiredWidth trimLeft:(BOOL)trimLeft
{
    if (!indicator)
        indicator = @"...";
    
    NSString *returnedString;
    NSDictionary *attributes = @{@"NSFontAttributeName": font};
    NSUInteger indicatorWidth = [indicator sizeWithAttributes:attributes].width;
    
    // 假设我们的字符串适合:
    if ([self sizeWithAttributes:attributes].width <= desiredWidth)
    {
        returnedString = [NSString stringWithString:self];
    }
    else
    {
        // 进行二分搜索，直到我们尽可能紧密地匹配:
        BOOL exactFit = NO;
        NSUInteger numChars = [self length] / 2;
        NSUInteger i = numChars;
        NSString *choppedString;
        
        // 首先分配这个字符串来处理病理情况:
        if (trimLeft)
            choppedString = [self tfy_right:i];
        else
            choppedString = [self tfy_left:i];
        
        while ((numChars > 1) && !exactFit)
        { 
            NSUInteger thisWidth = [choppedString sizeWithAttributes:attributes].width + indicatorWidth;
            numChars /= 2;
            
            if (thisWidth < desiredWidth)
                i += numChars;
            else if (thisWidth > desiredWidth)
                i -= numChars;
            else
                exactFit = YES;
            
            if (trimLeft)
                choppedString = [self tfy_right:i];
            else
                choppedString = [self tfy_left:i];
        }
        
        if (trimLeft)
            returnedString = [indicator stringByAppendingString:choppedString];
        else
            returnedString = [choppedString stringByAppendingString:indicator];
    }
    
    return returnedString;
}

/**
 返回完整的指定字符串，如果原始字符串太长，无法满足所需的宽度，则返回被截断的指示符字符串。指示器字符串通常是一个省略号(…);传递nil将默认为这个。
*/

- (NSString *)tfy_truncatedStringWithIndicator:(NSString *)indicator forFont:(NSFont *)font withWidth:(NSUInteger)desiredWidth
{
    return [self tfy_truncatedStringWithIndicator:indicator forFont:font withWidth:desiredWidth trimLeft:NO];
}

/**
 给定一个包含“&”和“&copy;”等HTML实体的字符串，返回解码后的等效内容，即将“&”转换为“&”，等等。如果字符串中没有HTML实体，则返回接收方。
*/

- (NSString *)tfy_stringByReplacingHTMLEntities;
{
    if ([self containsString:@"&"])
    {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSAttributedString *attrib = [[NSAttributedString alloc] initWithHTML:data documentAttributes:nil];
        
        return [attrib string];
    }
    else
        return self;
}

+ (NSString *)tfy_stringWithPoint:(NSPoint)point
{
    return [self stringWithFormat:@"%f, %f", point.x, point.y];
}

- (NSPoint)tfy_pointValue
{
    NSArray<NSString*> *components = [self componentsSeparatedByString:@", "];
    NSPoint point = NSZeroPoint;
    
    point.x = [components[0] floatValue];
    point.y = [components[1] floatValue];
    
    return point;
}

/**
 给定一个颜色，返回编码为字符串的颜色，这样它就可以添加到默认值中，等等。
*/

+ (NSString *)tfy_stringWithColor:(NSColor *)color
{
    CGFloat r, g, b, a;

    [[color colorUsingColorSpace:NSColorSpace.sRGBColorSpace] getRed:&r green:&g blue:&b alpha:&a];

    if (a == 1.0)
        return [self stringWithFormat:@"%g %g %g", r, g, b];
    else
        return [self stringWithFormat:@"%g %g %g %g", r, g, b, a];
}

/**
 从接收器的编码值返回一个NSColor，这个编码必须是由-stringWithColor编码的。
*/

- (NSColor *)tfy_color
{
    NSArray<NSString*> *values = [self componentsSeparatedByString:@" "];
    
    if ([values count] < 3)
        return [NSColor grayColor];
    else if ([values count] == 3)
        return [NSColor colorWithCalibratedRed:[values[0] floatValue] green:[values[1] floatValue] blue:[values[2] floatValue] alpha:1.0];
    else
        return [NSColor colorWithCalibratedRed:[values[0] floatValue] green:[values[1] floatValue] blue:[values[2] floatValue] alpha:[values[3] floatValue]];
}

@end

