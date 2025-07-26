//
//  NSControl+Dejal.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/2.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSControl (Dejal)
#pragma mark - 改变字段字体
/**
 *  改变句中所有的字体
 *
 *   textFont 改变的字体
 */
- (void)tfy_changeFontWithTextFont:(NSFont *)textFont;
/**
 *  改变句中某些字段的字体
 *
 *   textFont 改变的字体
 *   text     改变的字段
 */
- (void)tfy_changeFontWithTextFont:(NSFont *)textFont changeText:(NSString *)text;

#pragma mark - 改变字段间距
/**
 *  改变句中所有的间距
 *
 *   textSpace 改变的间距
 */
- (void)tfy_changeSpaceWithTextSpace:(CGFloat)textSpace;
/**
 *  改变句中某些字段的间距
 *
 *   textSpace 改变的间距
 *   text      改变的字段
 */
- (void)tfy_changeSpaceWithTextSpace:(CGFloat)textSpace changeText:(NSString *)text;

#pragma mark - 改变行间距
/**
 *  改变句中所有的行间距
 *
 *   lineSpace 改变的行间距
 */
- (void)tfy_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace;
/**
 *  改变句中段落样式
 *
 *   paragraphStyle 段落样式
 */
- (void)tfy_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle;

#pragma mark - 改变字段颜色
/**
 *  改变句中所有字体颜色
 *
 *   textColor 改变的颜色
 */
- (void)tfy_changeColorWithTextColor:(NSColor *)textColor;
/**
 *  改变句中某些字段的字体颜色
 *
 *   textColor 改变的颜色
 *   text      改变的字段
 */
- (void)tfy_changeColorWithTextColor:(NSColor *)textColor changeText:(NSString *)text;

/**
 *  改变句中一些字段的字体颜色
 *
 *   textColor 改变的颜色
 *   texts     改变的字段们
 */
- (void)tfy_changeColorWithTextColor:(NSColor *)textColor changeTexts:(NSArray <NSString *>*)texts;

#pragma mark - 改变字段背景颜色
/**
 *  改变句中所有字段的背景颜色
 *
 *   bgTextColor 改变的背景颜色
 */
- (void)tfy_changeBgColorWithBgTextColor:(NSColor *)bgTextColor;
/**
 *  改变句中某些字段的背景颜色
 *
 *   bgTextColor 改变的背景颜色
 *   text        改变的字段
 */
- (void)tfy_changeBgColorWithBgTextColor:(NSColor *)bgTextColor changeText:(NSString *)text;

#pragma mark - 改变字段连笔字 value值为1或者0
/**
 *  改变句中所有字段连笔
 *
 *   textLigature 默认是1连笔 0不连笔
 */
- (void)tfy_changeLigatureWithTextLigature:(NSNumber *)textLigature;
/**
 *  改变句中某些字段连笔
 *
 *   textLigature 默认是1连笔 0不连笔
 *   text         改变的字段
 */
- (void)tfy_changeLigatureWithTextLigature:(NSNumber *)textLigature changeText:(NSString *)text;

#pragma mark - 改变字间距
/**
 *  改变所有字段间距
 *
 *   textKern 改变的间距大小
 */
- (void)tfy_changeKernWithTextKern:(NSNumber *)textKern;
/**
 *  改变句中某些字段间距
 *
 *   textKern 改变的间距大小
 *   text     改变的字段
 */
- (void)tfy_changeKernWithTextKern:(NSNumber *)textKern changeText:(NSString *)text;

#pragma mark - 改变字的删除线 textStrikethroughStyle 为NSUnderlineStyle
/**
 *  改变所有字段的删除线
 *
 *   textStrikethroughStyle 改变的删除线类型
 */
- (void)tfy_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle;
/**
 *  改变句中某些字段的删除线
 *
 *   textStrikethroughStyle 改变的删除线类型
 *   text                   改变的字段
 */
- (void)tfy_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle changeText:(NSString *)text;

#pragma mark - 改变字的删除线颜色
/**
 *  改变所有字段的删除线颜色
 *
 *   textStrikethroughColor 改变的删除线颜色
 */
- (void)tfy_changeStrikethroughColorWithTextStrikethroughColor:(NSColor *)textStrikethroughColor NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的删除线颜色
 *
 *   textStrikethroughColor 改变的删除线颜色
 *   text                   改变的字段
 */
- (void)tfy_changeStrikethroughColorWithTextStrikethroughColor:(NSColor *)textStrikethroughColor changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字的下划线 textUnderlineStyle 为NSUnderlineStyle
/**
 *  改变所有字段的下划线
 *
 *   textUnderlineStyle 改变的下划线类型
 */
- (void)tfy_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle;
/**
 *  改变句中某些字段的下划线
 *
 *   textUnderlineStyle 改变的下划线类型
 *   text               改变的字段
 */
- (void)tfy_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle changeText:(NSString *)text;

#pragma mark - 改变字的下划线颜色
/**
 *  改变所有字段的下划线颜色
 *
 *   textUnderlineColor 改变的下划线颜色
 */
- (void)tfy_changeUnderlineColorWithTextStrikethroughColor:(NSColor *)textUnderlineColor NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的下划线颜色
 *
 *   textUnderlineColor 改变的下划线颜色
 *   text               改变的字段
 */
- (void)tfy_changeUnderlineColorWithTextStrikethroughColor:(NSColor *)textUnderlineColor changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字的颜色
/**
 *  改变所有字段的颜色
 *
 *   textStrokeColor 改变的颜色
 */
- (void)tfy_changeStrokeColorWithTextStrikethroughColor:(NSColor *)textStrokeColor;
/**
 *  改变句中某些字段的描边
 *
 *   textStrokeColor 改变的颜色
 *   text            改变的字段
 */
- (void)tfy_changeStrokeColorWithTextStrikethroughColor:(NSColor *)textStrokeColor changeText:(NSString *)text;

#pragma mark - 改变字的描边
/**
 *  改变所有字段的描边
 *
 *   textStrokeWidth 改变的描边
 */
- (void)tfy_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth;
/**
 *  改变句中某些字段的描边
 *
 *   textStrokeWidth 改变的描边
 *   text            改变的字段
 */
- (void)tfy_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth changeText:(NSString *)text;

#pragma mark - 改变字的阴影
/**
 *  改变所有字段的阴影
 *
 *   textShadow 改变的阴影
 */
- (void)tfy_changeShadowWithTextShadow:(NSShadow *)textShadow;
/**
 *  改变句中某些字段的阴影
 *
 *   textShadow 改变的阴影
 *   text       改变的字段
 */
- (void)tfy_changeShadowWithTextShadow:(NSShadow *)textShadow changeText:(NSString *)text;

#pragma mark - 改变字的特殊效果
/**
 *  改变所有字段的特殊效果
 *
 *   textLink 改变的特殊效果
 */
- (void)tfy_changeTextEffectWithTextEffect:(NSString *)textEffect NS_AVAILABLE(10_10, 7_0);
/**
 *  改变句中某些字段的特殊效果
 *
 *   textEffect 改变的特殊效果
 *   text       改变的字段
 */
- (void)tfy_changeTextEffectWithTextEffect:(NSString *)textEffect changeText:(NSString *)text NS_AVAILABLE(10_10, 7_0);

#pragma mark - 改变字的文本附件
/**
 *  改变所有字段的文本附件
 *
 *   textAttachment 改变的文本附件
 */
- (void)tfy_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的文本附件
 *
 *   textAttachment 改变的文本附件
 *   text           改变的字段
 */
- (void)tfy_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字的链接
/**
 *  改变所有字段的链接
 *
 *   textLink 改变的链接
 */
- (void)tfy_changeLinkWithTextLink:(NSString *)textLink NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的链接
 *
 *   textLink 改变的链接
 *   text     改变的字段
 */
- (void)tfy_changeLinkWithTextLink:(NSString *)textLink changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字的基准线偏移 value>0坐标往上偏移 value<0坐标往下偏移
/**
 *  改变所有字段的基准线偏移
 *
 *   textBaselineOffset 改变的偏移大小
 */
- (void)tfy_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的基准线偏移
 *
 *   textBaselineOffset 改变的偏移大小
 *   text               改变的字段
 */
- (void)tfy_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字的倾斜 value>0向右倾斜 value<0向左倾斜
/**
 *  改变所有字段的倾斜
 *
 *   textObliqueness 改变的倾斜大小
 */
- (void)tfy_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的倾斜
 *
 *   textObliqueness 改变的倾斜大小
 *   text            改变的字段
 */
- (void)tfy_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字粗细 0就是不变 >0加粗 <0加细
/**
 *  改变所有字段的粗细
 *
 *   textExpansion 改变的粗细大小
 */
- (void)tfy_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion NS_AVAILABLE(10_0, 7_0);
/**
 *  改变句中某些字段的粗细
 *
 *   textExpansion 改变的粗细大小
 *   text          改变的字段
 */
- (void)tfy_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字方向 NSWritingDirection
/**
 *  设置文字书写方向
 *
 *   textWritingDirection 改变的书写方向
 *   text                 改变的字段
 */
- (void)tfy_changeWritingDirectionWithTextExpansion:(NSArray *)textWritingDirection changeText:(NSString *)text NS_AVAILABLE(10_0, 7_0);

#pragma mark - 改变字的水平或者竖直 1竖直 0水平
/**
 *  设置文字排版方向
 *
 *   textVerticalGlyphForm 改变的排版方向
 *   text                  改变的字段
 */
- (void)tfy_changeVerticalGlyphFormWithTextVerticalGlyphForm:(NSNumber *)textVerticalGlyphForm changeText:(NSString *)text;

#pragma mark - 改变字的两端对齐
/**
 *  改变字段两端对齐
 *
 *   textCTKern 改变的对齐
 */
- (void)tfy_changeCTKernWithTextCTKern:(NSNumber *)textCTKern;

#pragma mark - 首部设置图片标签
/**
 为UILabel首部设置图片标签
 text 文本
 images 标签数组
 span 标签间距
 */
-(void)tfy_changeText:(NSString *)text frontImages:(NSArray<NSImage *> *)images imageSpan:(CGFloat)span;

@end

NS_ASSUME_NONNULL_END
