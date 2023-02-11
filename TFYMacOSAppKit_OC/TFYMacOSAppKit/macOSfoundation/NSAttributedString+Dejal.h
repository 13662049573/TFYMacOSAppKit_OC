//
//  NSAttributedString+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//


@interface NSAttributedString (Dejal)

+ (instancetype)tfy_attributedString;
+ (instancetype)tfy_attributedStringWithString:(NSString *)string;
+ (instancetype)tfy_attributedStringWithString:(NSString *)string attributes:(NSDictionary *)attributes;

+ (instancetype)tfy_attributedStringWithRTFString:(NSString *)rtfString;
+ (instancetype)tfy_attributedStringWithRTFData:(NSData *)rtfData;

- (NSString *)tfy_rtfString;
- (NSData *)tfy_rtfData;

- (NSRange)tfy_allRange;

- (NSAttributedString *)tfy_attributedStringWithFontSizeAdjustmentOffset:(CGFloat)offsetPoints inRange:(NSRange)range;
- (NSAttributedString *)tfy_attributedStringWithFontSizeIncrease:(BOOL)increase inRange:(NSRange)range;

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@interface NSMutableAttributedString (Dejal)

- (void)tfy_appendString:(NSString *)string withAttributes:(NSDictionary *)attributes;
- (void)tfy_insertString:(NSString *)string withAttributes:(NSDictionary *)attributes atIndex:(NSUInteger)i;

@end

