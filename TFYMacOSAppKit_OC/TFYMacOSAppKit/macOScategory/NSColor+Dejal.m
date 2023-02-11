//
//  NSColor+Dejal.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSColor+Dejal.h"

@implementation NSColor (Dejal)

+ (CGFloat)tfy_colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (NSColor *)tfy_colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self tfy_colorComponentFrom: colorString start: 0 length: 1];
            green = [self tfy_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self tfy_colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self tfy_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self tfy_colorComponentFrom: colorString start: 1 length: 1];
            green = [self tfy_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self tfy_colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self tfy_colorComponentFrom: colorString start: 0 length: 2];
            green = [self tfy_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self tfy_colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self tfy_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self tfy_colorComponentFrom: colorString start: 2 length: 2];
            green = [self tfy_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self tfy_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return nil;
    }
    return [NSColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (NSColor *)tfy_lightBlue{
    return [NSColor tfy_hexValue:0x29B5FE alpha:1];
}

+ (NSColor *)tfy_lightOrange{
    return [NSColor tfy_hexValue:0xFFBB50 alpha:1];
}

+ (NSColor *)tfy_lightGreen{
    return [NSColor tfy_hexValue:0x1AC756 alpha:1];
}

+ (NSColor *)tfy_line{
    return [NSColor tfy_hexValue:0xe4e4e4 alpha:1];
}

+ (NSColor *)tfy_hexValue:(NSInteger)rgbValue alpha:(CGFloat)alpha {
    return [NSColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                            alpha:alpha];
}


@end
