//
//  NSAttributedString+AppKit+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSAttributedString+AppKit+Dejal.h"


@implementation NSAttributedString (DejalAppKit)

/**
 方法创建并返回一个新的带属性字符串，该字符串包含来自主包资源的图像。
 */

+ (instancetype)tfy_attributedStringWithBundleResource:(NSString *)resourceName extension:(NSString *)extension;
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:resourceName withExtension:extension];
    
    return [self tfy_attributedStringWithImageFromURL:url];
}

/**
 方法创建并返回一个新的带属性字符串，其中包含来自指定文件URL的图像。如果URL为nil或该位置没有图像，则返回nil。
*/

+ (instancetype)tfy_attributedStringWithImageFromURL:(NSURL *)fileURL;
{
    if (!fileURL)
    {
        return nil;
    }
    
    NSFileWrapper *fileWrapper = [[NSFileWrapper alloc] initWithURL:fileURL options:0 error:nil];
    
    if (!fileWrapper)
    {
        return nil;
    }
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithFileWrapper:fileWrapper];
    
    if (!attachment)
    {
        return nil;
    }
    
    return [self attributedStringWithAttachment:attachment];
}

/*
 attributedStringWithSymbolicLinkToURL:

 方法创建并返回包含指向指定URL的符号链接的带属性字符串。如果URL为nil或该位置没有文件，则返回nil。
 */

+ (instancetype)tfy_attributedStringWithSymbolicLinkToURL:(NSURL *)fileURL;
{
    if (!fileURL)
    {
        return nil;
    }
    
    NSFileWrapper *fileWrapper = [[NSFileWrapper alloc] initSymbolicLinkWithDestinationURL:fileURL];
    
    if (!fileWrapper)
    {
        return nil;
    }
    
    NSString *linkPath = [[NSTemporaryDirectory() stringByAppendingPathComponent:[NSUUID UUID].UUIDString] tfy_validatedDirectoryPath];
    
    linkPath = [linkPath stringByAppendingPathComponent:[fileWrapper preferredFilename]];
    
    NSURL *linkURL = [NSURL fileURLWithPath:linkPath];
    
    [fileWrapper writeToURL:linkURL options:0 originalContentsURL:fileURL error:nil];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithFileWrapper:fileWrapper];
    
    if (!attachment)
    {
        return nil;
    }
    
    return [self attributedStringWithAttachment:attachment];
}

/**
 从指定的RTF数据和文档属性(可以为nil)创建并返回一个自动释放的带属性字符串的方便方法。
*/

+ (instancetype)tfy_attributedStringWithRTF:(NSData *)data
{
    return [[self alloc] initWithRTF:data documentAttributes:nil];
}

/**
 从指定的RTFD数据和文档属性(可以为nil)创建并返回一个自动释放的带属性字符串的方便方法。
*/

+ (instancetype)tfy_attributedStringWithRTFD:(NSData *)data
{
    return [[self alloc] initWithRTFD:data documentAttributes:nil];
}

/**
 返回带属性字符串的RTF版本。
*/

- (NSData *)tfy_RTFValue
{
    return [self RTFFromRange:[self tfy_allRange] documentAttributes:@{}];
}

/**
 返回带属性字符串的RTFD版本。
*/

- (NSData *)tfy_RTFDValue
{
    return [self RTFDFromRange:[self tfy_allRange] documentAttributes:@{}];
}

/**
 返回一个归档的RTFD，正如NSTextView的'data'绑定所期望的那样。
*/

- (NSData *)tfy_textViewBindingsValue;
{
    return [NSKeyedArchiver archivedDataWithRootObject:[self tfy_RTFDValue] requiringSecureCoding:YES error:nil];
}

@end

