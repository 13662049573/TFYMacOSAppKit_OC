//
//  TFYAttributedLabel.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "TFYAttributedLabel.h"
#import "NSMutableAttributedString+Config.h"
#import "NSMutableAttributedString+Parse.h"
#import "NSMutableAttributedString+CTFrameRef.h"

static NSString* const kEllipsesCharacter = @"\u2026";

@implementation TFYAttributedLabel
{
    NSMutableArray *_images;
    CTFrameRef _frameRef;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSettings];
    }
    return self;
}

- (void)configSettings {
    _lineSpacing       = 4.f;
    _paragraphSpacing  = 3.f;
    
    _imageSize         = CGSizeZero;
    _imageMargin       = NSEdgeInsetsMake(0, 1, 0, 1);
    _font              = [NSFont systemFontOfSize:14.f weight:NSFontWeightRegular];
    _textColor         = [NSColor blackColor];
    
    _textAlignment     = kCTTextAlignmentLeft;
    _lineBreakMode     = kCTLineBreakByWordWrapping | kCTLineBreakByCharWrapping;
    _imageAlignment    = TFYImageAlignmentBottom;
    
    _images = [NSMutableArray array];
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (!_attributedString) {
        return;
    }
    
    // 1.获取图形上下文
    CGContextRef context =  (CGContextRef) [[NSGraphicsContext currentContext] CGContext];
    
    // 2.获取CTFrameRef
    _frameRef = [_attributedString prepareFrameRefWithRect:dirtyRect];
        
    // 4.绘制文字
    [self drawText:context];
    
    // 5.绘制图片
    [self drawImages];
}


#pragma mark -
#pragma mark 计算文本的大小
- (CGSize)sizeThatFits:(CGSize)size
{
    if (!_attributedString) {
        return CGSizeZero;
    }
    // _numberOfLines行情况下文字的高度
    CGFloat height = [_attributedString boundingHeightForWidth:size.width
                                                 numberOfLines:_numberOfLines];
    return CGSizeMake(size.width, height);
}

// 获取当前需要展示的行数
- (NSUInteger)currentNumberOfLines {
    
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    return _numberOfLines > 0 ? MIN(_numberOfLines, lineCount) : lineCount;
}

#pragma mark -
#pragma mark 设置属性文本
- (void)setText:(NSString *)text
{
    NSAttributedString *attributedText = [self attributedString:text];
    [self setAttributedText:attributedText];
}

// 配置属性文本样式
- (NSMutableAttributedString *)attributedString:(NSString *)text {
    return [self attributedString:text font:_font textColor:_textColor];
}

- (NSMutableAttributedString *)attributedString:(NSString *)text
                                           font:(NSFont *)font
                                      textColor:(NSColor *)textColor {
    if (!text && !text.length) {
        return nil;
    }
    
    // 初始化NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString setFont:font];
    [attributedString setTextColor:textColor];
    
    return attributedString;
}

// 处理图片，并设置属性文本版式
- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    
    _images = [_attributedString setImageAlignment:_imageAlignment imageMargin:_imageMargin imageSize:_imageSize font:_font];
    
    [_attributedString setAttributedsWithLineSpacing:_lineSpacing
                                    paragraphSpacing:_paragraphSpacing
                                       textAlignment:_textAlignment
                                       lineBreakMode:_lineBreakMode];
    
    [self.layer setNeedsDisplay];
}

#pragma mark -
#pragma mark 绘制内容

- (void)drawText:(CGContextRef)context{
    CGPathRef path = CTFrameGetPath(_frameRef);
    CGRect rect = CGPathGetBoundingBox(path);
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    
    NSInteger numberOfLines = [self currentNumberOfLines];
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, numberOfLines), lineOrigins);
    NSAttributedString *attributedString = [_attributedString mutableCopy];
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        lineOrigin.y =  self.frame.size.height + (lineOrigin.y - rect.size.height);
        
        CGContextSetTextPosition(context, lineOrigin.x, lineOrigin.y);
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        BOOL shouldDrawLine = YES;
        
        if (lineIndex == numberOfLines - 1) {
            CFRange lastLineRange = CTLineGetStringRange(line);
            
            if (lastLineRange.location + lastLineRange.length < (CFIndex)attributedString.length) {
                CTLineTruncationType truncationType = kCTLineTruncationEnd;
                NSUInteger truncationAttributePosition = lastLineRange.location + lastLineRange.length - 1;
                
                NSDictionary *tokenAttributes = [attributedString attributesAtIndex:truncationAttributePosition
                                                                     effectiveRange:NULL];
                NSMutableAttributedString *tokenString = [[NSMutableAttributedString alloc] initWithString:kEllipsesCharacter
                                                                                                attributes:tokenAttributes];
                
                CTLineRef truncationToken = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)tokenString);
                
                NSMutableAttributedString *truncationString = [[attributedString attributedSubstringFromRange:NSMakeRange(lastLineRange.location, lastLineRange.length)] mutableCopy];
                
                if (lastLineRange.length > 0) {
                    unichar lastCharacter = [[truncationString string] characterAtIndex:lastLineRange.length - 1];
                    if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:lastCharacter]) {
                        [truncationString deleteCharactersInRange:NSMakeRange(lastLineRange.length - 1, 1)];
                    }
                }
                [truncationString appendAttributedString:tokenString];
                
                // 替换
                CTLineRef truncationLine = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)truncationString);
                CTLineRef truncatedLine = CTLineCreateTruncatedLine(truncationLine, self.frame.size.width, truncationType, truncationToken);
                if (!truncatedLine) {
                    truncatedLine = CFRetain(truncationToken);
                }
                CFRelease(truncationLine);
                CFRelease(truncationToken);
                
                CTLineDraw(truncatedLine, context);
                NSUInteger truncatedCount =  CTLineGetGlyphCount(truncatedLine);
                
                // 获取当前显示的文字
                NSMutableAttributedString *showString = [[attributedString attributedSubstringFromRange:NSMakeRange(0, lastLineRange.location + truncatedCount - tokenString.length)] mutableCopy];
                [showString appendAttributedString:tokenString];
                
                // 获取绘制后的新属性
                _frameRef = [showString prepareFrameRefWithRect:self.frame];
                
                CFRelease(truncatedLine);
                
                shouldDrawLine = NO;
            }
        }
        
        if (shouldDrawLine) {
            CTLineDraw(line, context);
        }
    }
}

- (void)drawImages {
    if (!_frameRef) {
        return;
    }
    
    CGContextRef context = (CGContextRef )[[NSGraphicsContext currentContext] CGContext];
    
    CFArrayRef lines = CTFrameGetLines(_frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(_frameRef, CFRangeMake(0, 0), lineOrigins);
    NSInteger numberOfLines =  [self currentNumberOfLines];
    
    for (CFIndex index = 0; index < numberOfLines; index++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, index);
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CFIndex runCount = CFArrayGetCount(runs);
        CGPoint lineOrigin = lineOrigins[index];
        
        for (CFIndex idx = 0; idx < runCount; idx++) {
            CTRunRef run = CFArrayGetValueAtIndex(runs, idx);
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (nil == delegate) {
                continue;
            }
            TFYAttributedImageInfo *imageInfo = (TFYAttributedImageInfo *)CTRunDelegateGetRefCon(delegate);
            // 获取将要展示图片的frame
            CGRect nrect = CTRunGetTypographicBoundsForImageRect(run, line, lineOrigin, imageInfo);
            
            CGRect rect = CGRectMake(nrect.origin.x, self.frame.size.height - nrect.origin.y - nrect.size.height, nrect.size.width, nrect.size.height);
            
            
            
            if (index == numberOfLines - 1 && idx >= runCount - 2 && _lineBreakMode == kCTLineBreakByTruncatingTail) {
                //最后行最后的2个CTRun需要做额外判断
                CGFloat attachmentWidth = CGRectGetWidth(rect);
                const CGFloat kMinEllipsesWidth = attachmentWidth;
                if (CGRectGetWidth(self.bounds) - CGRectGetMinX(rect) - attachmentWidth <  kMinEllipsesWidth) {
                    continue;
                }
            }
            
            NSLog(@"%@",imageInfo.imageName);
            
            // 绘制图片
            if (imageInfo.imageType == TFYImageNormalType) {
                
                NSImage *image = [NSImage imageNamed:imageInfo.imageName];
                NSRect imageRect = NSMakeRect(0, 0, imageInfo.imageSize.width, imageInfo.imageSize.height);
                
                CGImageRef ref = [image CGImageForProposedRect:&imageRect context:[NSGraphicsContext currentContext] hints:nil];
                
                rect = CGRectMake(nrect.origin.x, self.frame.size.height - nrect.origin.y, nrect.size.width, nrect.size.height);
                NSLog(@"%@",NSStringFromRect(rect));
                CGContextDrawImage(context, nrect, ref);
            }
            else if (imageInfo.imageType == TFYImageGIFType ) {
                
                CGRect frame = CGRectMake(rect.origin.x,
                                          self.bounds.size.height - rect.origin.y - rect.size.height,
                                          rect.size.width,
                                          rect.size.height);
                
                NSLog(@"%@",NSStringFromRect(frame));
                
                NSImageView *imageView = [[NSImageView alloc] init];
                imageView.animates = YES;
                imageView.canDrawSubviewsIntoLayer = YES;
                
                NSImage *image = [NSImage imageNamed:imageInfo.imageName];
                
                if (image) {
                    imageView.image = image;
                }else{
                    NSImage *gifImage = [[NSImage alloc] initWithContentsOfFile:imageInfo.imagePath];
                    imageView.image = gifImage;
                }
                
                [self addSubview:imageView];
                [imageView setFrame:frame];
            }
            else {
                NSLog(@"view类型的");
            }
        }
    }
}

@end
