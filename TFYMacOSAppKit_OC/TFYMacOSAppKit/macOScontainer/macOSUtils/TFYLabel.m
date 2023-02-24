//
//  TFYLabel.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "TFYLabel.h"

@implementation TFYLabel

- (BOOL)isFlipped{
    return true;
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self uilayout];
    }
    return self;
}

- (void)uilayout {
    self.enabled = true;
    self.userInteractionEnabled = false;
    
    self.wantsLayer = true;
    self.font = [NSFont systemFontOfSize:14 weight:NSFontWeightLight];
    self.textColor = NSColor.labelColor;
    self.textAlignment = NSTextAlignmentLeft;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentVerticalAlignment = TFYContentVerticalAlignmentCenter;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGFloat padding = 8.0;
    if (self.enabled == false) {
        if (!self.title) {
            return;
        }
        NSColor *textColor = NSColor.lightGrayColor;
        [self drawString:self.title textColor:textColor padding:padding];
        return;
    }
    
    if (self.attributedText) {
        [self drawAttributedString:self.attributedText padding:padding];

    } else {
        if (!self.title) {
            return;
        }
        NSColor *textColor = self.isHighlighted ? self.highlightedTextColor : self.textColor;
        [self drawString:self.title textColor:textColor padding:padding];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.attributedText = [[NSAttributedString alloc] initWithString:title];
}

- (void)mouseDown:(NSEvent *)event{
    if (self.mouseDownBlock) {
        self.mouseDownBlock(self);
    }
}

- (void)actionBlock:(void(^)(TFYLabel *sender))block{
    if (self.isUserInteractionEnabled == false) {
        return;
    }
    self.mouseDownBlock = block;
}

#pragma mark -funtions
- (void)drawAttributedString:(NSAttributedString *)attributedString padding:(CGFloat)padding{
    CGSize maxSize = CGSizeMake(self.bounds.size.width - padding*2, CGFLOAT_MAX);
    CGSize size = [attributedString boundingRectWithSize:maxSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil].size;

    CGFloat gapX = padding + (maxSize.width - size.width)/2;
    CGFloat gapY = (CGRectGetHeight(self.bounds) - size.height)/2;

    CGRect contentRect = NSMakeRect(floorf(gapX), floorf(gapY), size.width, size.height);

    switch (self.contentVerticalAlignment) {
        case TFYContentVerticalAlignmentCenter:
            break;
        case TFYContentVerticalAlignmentBottom:
            gapY *= 2;
            break;
        default:
            gapY = 0;
            break;
    }
    if (self.textAlignment == NSTextAlignmentLeft) {
        gapX = size.width < maxSize.width ? 0 : gapX;
    } else if (self.textAlignment == NSTextAlignmentRight) {
        gapX = size.width < maxSize.width ? gapX*2 : 0;
    }
    contentRect = NSMakeRect(floorf(gapX), floorf(gapY), size.width, size.height);
    [attributedString drawInRect:contentRect];
}

- (void)drawString:(NSString *)string textColor:(NSColor *)textColor padding:(CGFloat)padding{
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle.defaultParagraphStyle mutableCopy];
    paraStyle.alignment = self.textAlignment;
    paraStyle.lineBreakMode = self.lineBreakMode;

    NSDictionary *attrDic = @{NSParagraphStyleAttributeName: paraStyle,
                              NSForegroundColorAttributeName: textColor,
                              NSFontAttributeName: self.font,
                            };
    
    NSAttributedString *attString = [[NSAttributedString alloc]initWithString:string attributes:attrDic];
    [self drawAttributedString:attString padding:padding];
    
}

#pragma mark - 改变字段字体
- (void)tfy_changeFontWithTextFont:(NSFont *)textFont
{
    [self tfy_changeFontWithTextFont:textFont changeText:self.title];
}
- (void)tfy_changeFontWithTextFont:(NSFont *)textFont changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSFontAttributeName value:textFont range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段间距
- (void)tfy_changeSpaceWithTextSpace:(CGFloat)textSpace
{
    [self tfy_changeSpaceWithTextSpace:textSpace changeText:self.title];
}
- (void)tfy_changeSpaceWithTextSpace:(CGFloat)textSpace changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:(id)kCTKernAttributeName value:@(textSpace) range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变行间距
- (void)tfy_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:textLineSpace];
    [paragraphStyle setAlignment:self.textAlignment];
    [self tfy_changeParagraphStyleWithTextParagraphStyle:paragraphStyle];
}
#pragma mark - 段落样式
- (void)tfy_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.title length])];
    [self setAttributedText:attributedString];
}

#pragma mark - 改变字段颜色
- (void)tfy_changeColorWithTextColor:(NSColor *)textColor
{
    [self tfy_changeColorWithTextColor:textColor changeText:self.title];
}
- (void)tfy_changeColorWithTextColor:(NSColor *)textColor changeText:(NSString *)text
{
    [self tfy_changeColorWithTextColor:textColor changeTexts:@[text]];
}

- (void)tfy_changeColorWithTextColor:(NSColor *)textColor changeTexts:(NSArray <NSString *>*)texts
{
    for(NSString *markContent in texts) {
        NSMutableAttributedString *textAttrString = [self.attributedText mutableCopy];
        //查找关键字并进行标注变色
        NSRange range = [self.title rangeOfString: markContent options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
        while (range.location != NSNotFound) {
            [textAttrString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
            range = [self.title rangeOfString: markContent
                                                options: NSCaseInsensitiveSearch | NSRegularExpressionSearch
                                                  range: NSMakeRange(range.location + range.length, self.title.length - (range.location + range.length))];
        }
        self.attributedText = textAttrString;
    }
}

#pragma mark - 改变字段背景颜色
- (void)tfy_changeBgColorWithBgTextColor:(NSColor *)bgTextColor
{
    [self tfy_changeBgColorWithBgTextColor:bgTextColor changeText:self.title];
}
- (void)tfy_changeBgColorWithBgTextColor:(NSColor *)bgTextColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSBackgroundColorAttributeName value:bgTextColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段连笔字 value值为1或者0
- (void)tfy_changeLigatureWithTextLigature:(NSNumber *)textLigature
{
    [self tfy_changeLigatureWithTextLigature:textLigature changeText:self.title];
}
- (void)tfy_changeLigatureWithTextLigature:(NSNumber *)textLigature changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSLigatureAttributeName value:textLigature range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字间距
- (void)tfy_changeKernWithTextKern:(NSNumber *)textKern
{
    [self tfy_changeKernWithTextKern:textKern changeText:self.title];
}
- (void)tfy_changeKernWithTextKern:(NSNumber *)textKern changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSKernAttributeName value:textKern range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线 textStrikethroughStyle 为NSUnderlineStyle
- (void)tfy_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle
{
    [self tfy_changeStrikethroughStyleWithTextStrikethroughStyle:textStrikethroughStyle changeText:self.title];
}
- (void)tfy_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:textStrikethroughStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线颜色
- (void)tfy_changeStrikethroughColorWithTextStrikethroughColor:(NSColor *)textStrikethroughColor
{
    [self tfy_changeStrikethroughColorWithTextStrikethroughColor:textStrikethroughColor changeText:self.title];
}
- (void)tfy_changeStrikethroughColorWithTextStrikethroughColor:(NSColor *)textStrikethroughColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughColorAttributeName value:textStrikethroughColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的下划线 textUnderlineStyle 为NSUnderlineStyle
- (void)tfy_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle
{
    [self tfy_changeUnderlineStyleWithTextStrikethroughStyle:textUnderlineStyle changeText:self.title];
}
- (void)tfy_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:textUnderlineStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的下划线颜色
- (void)tfy_changeUnderlineColorWithTextStrikethroughColor:(NSColor *)textUnderlineColor
{
    [self tfy_changeUnderlineColorWithTextStrikethroughColor:textUnderlineColor changeText:self.title];
}
- (void)tfy_changeUnderlineColorWithTextStrikethroughColor:(NSColor *)textUnderlineColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSUnderlineColorAttributeName value:textUnderlineColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的颜色
- (void)tfy_changeStrokeColorWithTextStrikethroughColor:(NSColor *)textStrokeColor
{
    [self tfy_changeStrokeColorWithTextStrikethroughColor:textStrokeColor changeText:self.title];
}
- (void)tfy_changeStrokeColorWithTextStrikethroughColor:(NSColor *)textStrokeColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrokeColorAttributeName value:textStrokeColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的描边
- (void)tfy_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth
{
    [self tfy_changeStrokeWidthWithTextStrikethroughWidth:textStrokeWidth changeText:self.title];
}
- (void)tfy_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrokeWidthAttributeName value:textStrokeWidth range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的阴影
- (void)tfy_changeShadowWithTextShadow:(NSShadow *)textShadow
{
    [self tfy_changeShadowWithTextShadow:textShadow changeText:self.title];
}
- (void)tfy_changeShadowWithTextShadow:(NSShadow *)textShadow changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSShadowAttributeName value:textShadow range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的特殊效果
- (void)tfy_changeTextEffectWithTextEffect:(NSString *)textEffect
{
    [self tfy_changeTextEffectWithTextEffect:textEffect changeText:self.title];
}
- (void)tfy_changeTextEffectWithTextEffect:(NSString *)textEffect changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSTextEffectAttributeName value:textEffect range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的文本附件
- (void)tfy_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment
{
    [self tfy_changeAttachmentWithTextAttachment:textAttachment changeText:self.title];
}
- (void)tfy_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSAttachmentAttributeName value:textAttachment range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的链接
- (void)tfy_changeLinkWithTextLink:(NSString *)textLink
{
    [self tfy_changeLinkWithTextLink:textLink changeText:self.title];
}
- (void)tfy_changeLinkWithTextLink:(NSString *)textLink changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSLinkAttributeName value:textLink range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的基准线偏移 value>0坐标往上偏移 value<0坐标往下偏移
- (void)tfy_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset
{
    [self tfy_changeBaselineOffsetWithTextBaselineOffset:textBaselineOffset changeText:self.title];
}
- (void)tfy_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSBaselineOffsetAttributeName value:textBaselineOffset range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的倾斜 value>0向右倾斜 value<0向左倾斜
- (void)tfy_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness
{
    [self tfy_changeObliquenessWithTextObliqueness:textObliqueness changeText:self.title];
}
- (void)tfy_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSObliquenessAttributeName value:textObliqueness range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字粗细 0就是不变 >0加粗 <0加细
- (void)tfy_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion
{
    [self tfy_changeExpansionsWithTextExpansion:textExpansion changeText:self.title];
}
- (void)tfy_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSExpansionAttributeName value:textExpansion range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字方向 NSWritingDirection
- (void)tfy_changeWritingDirectionWithTextExpansion:(NSArray *)textWritingDirection changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSWritingDirectionAttributeName value:textWritingDirection range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的水平或者竖直 1竖直 0水平
- (void)tfy_changeVerticalGlyphFormWithTextVerticalGlyphForm:(NSNumber *)textVerticalGlyphForm changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.title rangeOfString:text options:NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSVerticalGlyphFormAttributeName value:textVerticalGlyphForm range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的两端对齐
- (void)tfy_changeCTKernWithTextCTKern:(NSNumber *)textCTKern
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attributedString addAttribute:(id)kCTKernAttributeName value:textCTKern range:NSMakeRange(0, self.title.length-1)];
    self.attributedText = attributedString;
}

/**
 为UILabel首部设置图片标签
 text 文本
 images 标签数组
 span 标签间距
 */
-(void)tfy_changeText:(NSString *)text frontImages:(NSArray<NSImage *> *)images imageSpan:(CGFloat)span
{
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    
    for (NSImage *img in images) {//遍历添加标签
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        //计算图片大小，与文字同高，按比例设置宽度
        CGFloat imgH = self.font.pointSize;
        CGFloat imgW = (img.size.width / img.size.height) * imgH;
        //计算文字padding-top ，使图片垂直居中
        CGFloat textPaddingTop = (self.font.capHeight - self.font.pointSize) / 2;
        attach.bounds = CGRectMake(0, -textPaddingTop , imgW, imgH);
        
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        [textAttrStr appendAttributedString:imgStr];
        //标签后添加空格
        [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    
    //设置显示文本
    [textAttrStr appendAttributedString:[[NSAttributedString alloc]initWithString:text]];
    //设置间距
    if (span != 0) {
        [textAttrStr addAttribute:NSKernAttributeName value:@(span) range:NSMakeRange(0, images.count * 2/*由于图片也会占用一个单位长度,所以带上空格数量，需要 *2 */)];
    }
    
    self.attributedText = textAttrStr;
}


@end
