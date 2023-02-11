//
//  NSTextView+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface NSTextView (Dejal)
/**
 将所有文本替换为指定的纯字符串(使用当前字体等)
*/
@property (nonatomic, setter=tfy_setStringValue:) NSString *tfy_stringValue;
/**
 以带属性字符串的形式返回文本的自动释放副本。
*/
@property (nonatomic, setter=tfy_setAttributedStringValue:) NSAttributedString *tfy_attributedStringValue;
/**
 返回文本的RTF版本。
*/
@property (nonatomic, setter=tfy_setRTFValue:) NSData *tfy_RTFValue;
/**
 返回文本的RTFD版本。
*/

@property (nonatomic, setter=tfy_setRTFDValue:) NSData *tfy_RTFDValue;
/**
 返回文本视图中的字符数。
*/

- (NSInteger)tfy_length;
/**
 返回一个包含文本视图中所有字符的NSRange。
*/
- (NSRange)tfy_allRange;
/**
 在改变NSTextView的字体或前景色/背景颜色之后，调用这个函数将这些更改应用到零长度的选择(即下一个用户输入)。否则，将在旧样式中插入新的类型(有时这很有用)。
*/
- (void)tfy_setTypingAttributesToMatchView;
/**
 动作方法选择无文本;-selectAll:的反义词。在当前选择的开始处(如果有的话)创建插入点。如果没有选择，什么都不做。
*/
- (IBAction)deselectAll:(id)sender;


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------

/**
 将指定的普通字符串追加到接收器的末尾。
*/
- (void)tfy_appendStringValue:(NSString *)value;
/**
 将指定的带属性字符串追加到接收器的末尾。
*/

- (void)tfy_appendAttributedStringValue:(NSAttributedString *)value;


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------

/**
 以普通字符串的形式返回接收方所选文本的自动释放副本。
*/
- (NSString *)tfy_selectedStringValue;
/**
 以普通字符串的形式返回接收方所选文本的自动释放副本。
*/

- (NSString *)tfy_selectedOrAllStringValue;
/**
 以带属性字符串的形式返回接收方所选文本的自动释放副本。
*/
- (NSAttributedString *)tfy_selectedAttributedStringValue;
/**
 以带属性字符串的形式返回接收方所选文本的自动释放副本。
*/
- (NSAttributedString *)tfy_selectedOrAllAttributedStringValue;


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------

/**
 用最丰富的指定值替换所有文本;Any或all可以为nil。如果都无效，则清除文本。
*/
- (void)tfy_setRTFDValue:(NSData *)theRTFD orRTF:(NSData *)theRTF orAttributedString:(NSAttributedString *)attrString orString:(NSString *)string;

@end

