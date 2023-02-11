//
//  NSColor+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSColor (Dejal)

@property(class, nonatomic, strong, readonly) NSColor *tfy_lightBlue;
@property(class, nonatomic, strong, readonly) NSColor *tfy_lightOrange;
@property(class, nonatomic, strong, readonly) NSColor *tfy_lightGreen;
@property(class, nonatomic, strong, readonly) NSColor *tfy_line;

+ (NSColor *)tfy_hexValue:(NSInteger)rgbValue alpha:(CGFloat)alpha;

+ (NSColor *)tfy_colorWithHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
