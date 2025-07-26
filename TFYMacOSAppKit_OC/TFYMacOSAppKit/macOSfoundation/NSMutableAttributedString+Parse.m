//
//  NSViewController+Hook.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSMutableAttributedString+Parse.h"
#import <AppKit/AppKit.h>
#import <CoreText/CoreText.h>

static NSString *const BEGIN_FLAG = @"[/";
static NSString *const END_FLAG   = @"]";

@implementation NSMutableAttributedString (Parse)

- (NSMutableArray *)setImageAlignment:(TFYImageAlignment)imageAlignment
                          imageMargin:(NSEdgeInsets)imageMargin
                            imageSize:(CGSize)imageSize
                                 font:(NSFont *)font
{
    NSMutableArray *images = [NSMutableArray array];
    
    // 通过递归查询出所有的图片
    [self detectImagesInString:self.string images:images imageAlignment:imageAlignment];
    
    // 替换图片
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
    
    for (TFYAttributedImageInfo *imageInfo in images) {
        
        // 从项目文本中加载图片
        NSImage *image = [NSImage imageNamed:imageInfo.imageName];
    
        // 判断图片是否存在
        if (!image) {
            continue;
        }
        
        
        if ([imageInfo.imageName isEqualToString: @"010"]) {
            imageSize = CGSizeMake(100, 100);
        }
        
        // 设置图片size
        if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
            imageInfo.imageSize = CGSizeMake(font.pointSize, font.pointSize);
        }else {
            imageInfo.imageSize = imageSize;
        }
        
        // 设置fontRef,方便设置图片位置
        imageInfo.fontRef = fontRef;
        imageInfo.imageMargin = imageMargin;
        
        // 设置类型
        if ([imageInfo.imageName rangeOfString:@".gif"].location == NSNotFound) {
            imageInfo.imageType = TFYImageNormalType;
        }else {
            imageInfo.imageType = TFYImageGIFType;
        }
        
        // 获取图片imageAttString
        NSMutableAttributedString *imageAttString = [self createImageAttributedString:imageInfo];
        
        // imageAttString替换文字AttString
        NSString *imageStr = [NSString stringWithFormat:@"%@%@%@", BEGIN_FLAG, imageInfo.imageName, END_FLAG];
        NSRange range = [self.string rangeOfString:imageStr];
        
        // 图片替换
        [self replaceCharactersInRange:range withAttributedString:imageAttString];
    }
    
    // 返回包含图片的数组
    return images;

}

// 递归查询出所有的图片
- (void)detectImagesInString:(NSString *)string
                      images:(NSMutableArray *)images
              imageAlignment:(TFYImageAlignment)imageAlignment {
    
    NSRange range1 = [string rangeOfString:BEGIN_FLAG];
    
    if (range1.location == NSNotFound) {
        return;
    }
    
    NSRange range2 = [string rangeOfString:END_FLAG options:NSCaseInsensitiveSearch range:NSMakeRange(range1.location + range1.length, string.length - range1.location - range1.length)];
    
    if (range2.location == NSNotFound) {
        return;
    }
    
    // 开始查找
    if (range1.location < range2.location) {
        NSUInteger location = range1.location + range1.length;
        NSUInteger length = range2.location - location;
        
        // 图片名
        NSString *imageName = [string substringWithRange:NSMakeRange(location, length)];
        

            // 初始化图片数据模型
        TFYAttributedImageInfo *imageInfo = [[TFYAttributedImageInfo alloc] init];
            imageInfo.imageName = imageName;
            imageInfo.imageAlignment = imageAlignment;
            
            // 添加到图片数组
            [images addObject:imageInfo];
        
        // 递归继续查询
        NSString *result = [string substringFromIndex:range2.location + range2.length];
        [self detectImagesInString:result images:images imageAlignment:imageAlignment];
    }
}

// 创建图片attString
- (NSMutableAttributedString *)createImageAttributedString:(TFYAttributedImageInfo *)imageInfo
{
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    
    // 创建CTRun回调
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(imageInfo));
    
    // 使用 0xFFFC 作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *string = [NSString stringWithCharacters:&objectReplacementChar length:1];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    
    CFRelease(runDelegate);
    
    return attString;
}

// 调整图片对齐方式
static CGFloat ascentCallback(void *ref) {
    TFYAttributedImageInfo *imageInfo = (__bridge TFYAttributedImageInfo*)ref;
    CGFloat height = attributedImageSize(imageInfo).height;
    
    CGFloat ascent = 0;
    CGFloat fontAscent  = CTFontGetAscent(imageInfo.fontRef);
    CGFloat fontDescent = CTFontGetDescent(imageInfo.fontRef);
    
    switch (imageInfo.imageAlignment){
        case TFYImageAlignmentTop:
            ascent = fontAscent;
            break;
        case TFYImageAlignmentCenter:{
            CGFloat baseLine = (fontAscent + fontDescent) / 2.0f - fontDescent;
            ascent = height / 2.0f + baseLine;
        }
            break;
        case TFYImageAlignmentBottom:
            ascent = height - fontDescent;
            break;
        default:
            break;
    }
    return ascent;
}

// 调整图片对齐方式
static CGFloat descentCallback(void *ref) {
    TFYAttributedImageInfo *imageInfo = (__bridge TFYAttributedImageInfo*)ref;
    CGFloat height = attributedImageSize(imageInfo).height;
    
    if (!height) return 0;
    CGFloat descent = 0;
    CGFloat fontAscent  = CTFontGetAscent(imageInfo.fontRef);
    CGFloat fontDescent = CTFontGetDescent(imageInfo.fontRef);
    
    switch (imageInfo.imageAlignment) {
        case TFYImageAlignmentTop:{
            descent = height - fontAscent;
            break;
        }
        case TFYImageAlignmentCenter:{
            CGFloat baseLine = (fontAscent + fontDescent) / 2.f - fontDescent;
            descent = height / 2.f - baseLine;
        }
            break;
        case TFYImageAlignmentBottom:{
            descent = fontDescent;
            break;
        }
        default:
            break;
    }
    
    return descent;
}

// 获取图片宽度
static CGFloat widthCallback(void *ref) {
    TFYAttributedImageInfo *imageInfo = (__bridge TFYAttributedImageInfo*)ref;
    return attributedImageSize(imageInfo).width;
}

// 获取图片大小
static CGSize attributedImageSize(TFYAttributedImageInfo *imageInfo) {
    return CGSizeMake(imageInfo.imageSize.width + imageInfo.imageMargin.left + imageInfo.imageMargin.right,
                      imageInfo.imageSize.height+ imageInfo.imageMargin.top  + imageInfo.imageMargin.bottom);
}

@end
