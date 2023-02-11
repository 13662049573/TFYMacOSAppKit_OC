//
//  NSViewController+Hook.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString (Config)

// 设置颜色
- (void)setTextColor:(NSColor *)color;
- (void)setTextColor:(NSColor *)color range:(NSRange)range;

// 设置字体
- (void)setFont:(NSFont *)font;
- (void)setFont:(NSFont *)font range:(NSRange)range;

// 设置下划线
- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier;
- (void)setUnderlineStyle:(CTUnderlineStyle)style
                 modifier:(CTUnderlineStyleModifiers)modifier
                    range:(NSRange)range;

// 设置属性
- (NSMutableAttributedString *)setAttributedsWithLineSpacing:(CGFloat)lineSpacing
                                            paragraphSpacing:(CGFloat)paragraphSpacing
                                               textAlignment:(CTTextAlignment)textAlignment
                                               lineBreakMode:(CTLineBreakMode)lineBreakMode;

@end

