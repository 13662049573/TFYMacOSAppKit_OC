//
//  NSViewController+Hook.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "TFYAttributedImageInfo.h"

@interface NSMutableAttributedString (CTFrameRef)

#pragma mark - NSRange / CFRange
NSRange NSRangeFromCFRange(CFRange range);

#pragma mark - CoreText CTLine/CTRun utils
BOOL CTRunContainsCharactersFromStringRange(CTRunRef run, NSRange range);
BOOL CTLineContainsCharactersFromStringRange(CTLineRef line, NSRange range);

CGRect CTRunGetTypographicBoundsAsRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin);
CGRect CTLineGetTypographicBoundsAsRect(CTLineRef line, CGPoint lineOrigin);
CGRect CTRunGetTypographicBoundsForLinkRect(CTLineRef line, NSRange range, CGPoint lineOrigin);
CGRect CTRunGetTypographicBoundsForImageRect(CTRunRef run, CTLineRef line, CGPoint lineOrigin, TFYAttributedImageInfo *imageData);

// 获取CTFrameRef
- (CTFrameRef)prepareFrameRefWithRect:(CGRect)rect;

// 获取label高度
- (CGFloat)boundingHeightForWidth:(CGFloat)width;

// 获取固定行数的高度
- (CGFloat)boundingHeightForWidth:(CGFloat)width
                    numberOfLines:(NSUInteger)numberOfLines;

@end
