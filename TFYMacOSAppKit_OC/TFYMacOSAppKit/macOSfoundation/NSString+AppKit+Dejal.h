//
//  NSString+AppKit+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSString+Dejal.h"
#import <Cocoa/Cocoa.h>

@interface NSString (DejalAppKit)

- (CGFloat)tfy_widthWithFont:(NSFont *)font;

- (NSString *)tfy_truncatedStringWithIndicator:(NSString *)indicator forFont:(NSFont *)font withWidth:(NSUInteger)desiredWidth trimLeft:(BOOL)trimLeft;
- (NSString *)tfy_truncatedStringWithIndicator:(NSString *)indicator forFont:(NSFont *)font withWidth:(NSUInteger)desiredWidth;

- (NSString *)tfy_stringByReplacingHTMLEntities;

+ (NSString *)tfy_stringWithPoint:(NSPoint)point;
- (NSPoint)tfy_pointValue;

+ (NSString *)tfy_stringWithColor:(NSColor *)color;
- (NSColor *)tfy_color;

@end

