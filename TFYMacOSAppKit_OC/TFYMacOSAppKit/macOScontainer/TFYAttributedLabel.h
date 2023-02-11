//
//  TFYAttributedLabel.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TFYAttributedImageInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface TFYAttributedLabel : NSView

@property (nonatomic, strong) NSFont *font;             //!< 字体
@property (nonatomic, strong) NSColor *textColor;       //!< 文本颜色

@property (nonatomic, assign)  CGFloat          lineSpacing;      //!<  行间距
@property (nonatomic, assign)  CGFloat          paragraphSpacing; //!<  段间距

@property (nonatomic, assign)  CTTextAlignment  textAlignment;     // 文字排版样式
@property (nonatomic, assign)  CTLineBreakMode  lineBreakMode;     // LineBreakMode

@property (nonatomic, assign)  TFYImageAlignment imageAlignment;    // 图片相对于文字的排版样式
@property (nonatomic, assign)  NSEdgeInsets     imageMargin;       // 图片与文字之间的间距

@property (nonatomic, assign)  NSUInteger       numberOfLines;     // 行数
@property (nonatomic, assign)  CGSize           imageSize;         // 图片size，针对文本中所有的图片

@property (nonatomic, strong) NSMutableAttributedString *attributedString;

//普通文本
@property(nonatomic , copy)NSString *text;
//大小
- (CGSize)sizeThatFits:(CGSize)size;

//属性文本
- (void)setAttributedText:(NSAttributedString *)attributedText;

@end

NS_ASSUME_NONNULL_END
