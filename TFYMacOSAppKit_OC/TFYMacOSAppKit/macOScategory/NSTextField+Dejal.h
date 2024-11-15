//
//  NSTextField+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkInfo : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@end

@interface NSTextField (Dejal)

@property (nonatomic , strong) NSColor *tfy_placeholderStringColor;

/**
 如果字段的字符串值非空，即非nil和非@""则返回YES。
*/
- (BOOL)tfy_containsSomething;
/**
 执行设置带有冒号后缀的提示符标签的常见任务。
*/
- (void)tfy_setPromptLabel:(NSString *)label;
/**
 执行设置字段值的常见任务，确保该值不是nil。
*/
- (void)tfy_setFieldValue:(NSString *)value;
/**
 使用从滑块开始的范围验证字段值，并根据需要将接收器或滑块设置为该值。返回值。所有这些都可以通过绑定来完成，但这也可以，并且在Mac OS X 10.2中也可以工作。
*/

- (NSInteger)tfy_syncronizeWithIntegerSlider:(NSSlider *)slider usingFieldValue:(BOOL)isUsingField;
/**
 如果字段内容当前不适合它的框架，该方法将调整包含该字段的窗口和字段本身的大小，使其适合。窗口和字段仅垂直调整大小。此更改不需要或不影响自动调整大小的spring和struts。窗口的大小只会增加，而不会减少。如果需要调整大小则返回YES，如果已经足够大则返回NO。
*/
- (BOOL)tfy_resizeWindowVerticallyToFit;

- (void)didTapLabelAttributedText:(NSArray<LinkInfo *> *)linkInfos
                           action:(void (^)(NSString *key, NSString *value))action
       lineFragmentPadding:(CGFloat)lineFragmentPadding;
@end

NS_ASSUME_NONNULL_END
