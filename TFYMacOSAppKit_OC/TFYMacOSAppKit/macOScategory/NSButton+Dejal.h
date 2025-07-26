//
//  NSButton+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//
#import <Cocoa/Cocoa.h>


typedef NS_ENUM(NSUInteger, kTextAligment) {
    kTextAlignmentLeft = 0,
    kTextAlignmentRight,
    kTextAlignmentCenter,
};

@interface NSButton (Dejal)
/**
 返回接收者文本的颜色。
 */
@property (nonatomic, strong, setter=tfy_setTextColor:) NSColor *tfy_textColor;
/**
 显示接收器下方的菜单。
 */
- (void)tfy_displayMenu:(NSMenu *)menu;
/**
 显示接收器下方的菜单。
 */
- (void)tfy_displayMenu:(NSMenu *)menu withOffset:(CGFloat)verticalOffset;
/**
 显示接收器下方的菜单。
 
 要显示的菜单。
 horizontalOffset水平调整的偏移量。
 verticalOffset垂直调整的偏移量。
 */
- (void)tfy_displayMenu:(NSMenu *)menu withHorizontalOffset:(CGFloat)horizontalOffset verticalOffset:(CGFloat)verticalOffset;

@property (nonatomic, assign) kTextAligment tfy_textAlignment;

@end


@interface NSButton (DejalRadios)
/**
 将组中的所有无线电设置为启用或禁用。替换-[NSMatrix setEnabled:]。
 */

@property (nonatomic, setter=tfy_setRadiosEnabled:) BOOL tfy_radiosEnabled;
/**
 
 假设接收者是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并选择具有指定标签的单选按钮。在组中的任何无线电上调用此命令。替换-[NSMatrix selectCellWithTag:]。
 */
- (void)tfy_selectRadioWithTag:(NSInteger)tag;
/**

 假设接收者是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并返回所选单选的标签值。在组中的任何无线电上调用此命令。替换-[NSMatrix selectedTag]。
 */
- (NSInteger)tfy_selectedRadioTag;
/**
 假设接收器是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并为每个按钮执行块，将单选按钮传递给块。返回返回YES的值，如果块在完成前请求停止，则返回nil，或者块在没有返回YES的情况下完成。在组中的任何无线电上调用此命令。

 一个以单选按钮和停止布尔引用作为参数并返回布尔值的块。
 @返回找到的单选按钮，如果没有找到，则返回nil。
 */
- (NSButton *)tfy_radioPassingTest:(BOOL (^)(NSButton *radio, BOOL *stop))predicate;
/**
 假设接收器是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并为每个按钮执行块，将单选按钮传递给块。在组中的任何无线电上调用此命令。

 一个以单选按钮和停止布尔引用作为参数并返回void的块。
 */
- (void)tfy_enumerateRadiosUsingBlock:(void (^)(NSButton *radio, BOOL *stop))block;

@end

