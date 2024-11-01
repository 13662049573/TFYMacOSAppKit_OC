//
//  NSButton+Dejal.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/7.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "NSButton+Dejal.h"
#import <objc/message.h>
#import <time.h>

@implementation NSButton (Dejal)

/**
 返回接收者文本的颜色。
 */
- (NSColor *)tfy_textColor;
{
    NSAttributedString *attrTitle = self.attributedTitle;
    NSColor *textColor = [NSColor controlTextColor];
    
    if (attrTitle.length)
    {
        NSDictionary *attrs = [attrTitle fontAttributesInRange:NSMakeRange(0, 1)];
        
        if (attrs)
        {
            textColor = [attrs objectForKey:NSForegroundColorAttributeName];
        }
    }
    
    return textColor;
}

/**
 将接收者的文本设置为指定的颜色。
 */
- (void)tfy_setTextColor:(NSColor *)textColor;
{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedTitle];
    NSRange range = NSMakeRange(0, attrTitle.length);
    
    if (textColor)
    {
        [attrTitle addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    }
    else
    {
        [attrTitle removeAttribute:NSForegroundColorAttributeName range:range];
    }
    [attrTitle addAttribute:NSFontAttributeName value:self.font range:range];
    [attrTitle fixAttributesInRange:range];
    
    self.attributedTitle = attrTitle;
}

- (kTextAligment)tfy_textAlignment
{
    NSNumber *number = objc_getAssociatedObject(self, "textAlignment");
    return number.integerValue;
}

- (void)setTfy_textAlignment:(kTextAligment)alignment
{
    objc_setAssociatedObject(self, "textAlignment", @(alignment), OBJC_ASSOCIATION_ASSIGN);
    NSMutableAttributedString *attributedString = [self.attributedTitle mutableCopy];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    switch (alignment) {
        case kTextAlignmentLeft:
            style.alignment = NSTextAlignmentLeft;
            break;
        case kTextAlignmentRight:
            style.alignment = NSTextAlignmentRight;
            break;
        case kTextAlignmentCenter:
            style.alignment = NSTextAlignmentCenter;
            break;
        default:
            break;
    }
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.title.length)];
    self.attributedTitle = attributedString;
}

/**
 显示接收器下方的菜单。
 */
- (void)tfy_displayMenu:(NSMenu *)menu;
{
    [self tfy_displayMenu:menu withOffset:4];
}

/**
 显示接收器下方的菜单。
 */

- (void)tfy_displayMenu:(NSMenu *)menu withOffset:(CGFloat)verticalOffset;
{
    [self tfy_displayMenu:menu withHorizontalOffset:0.0 verticalOffset:verticalOffset];
}

/**
 显示接收器下方的菜单。
 
 要显示的菜单。
 horizontalOffset水平调整的偏移量。
 verticalOffset垂直调整的偏移量。
 */

- (void)tfy_displayMenu:(NSMenu *)menu withHorizontalOffset:(CGFloat)horizontalOffset verticalOffset:(CGFloat)verticalOffset;
{
    NSPoint location = self.frame.origin;
    
    location.x += horizontalOffset;
    location.y -= verticalOffset;
    
    [menu popUpMenuPositioningItem:nil atLocation:location inView:self.superview];
}

@end


// ----------------------------------------------------------------------------------------
#pragma mark -
// ----------------------------------------------------------------------------------------


@implementation NSButton (DejalRadios)

/**
 
 假设接收者是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并选择具有指定标签的单选按钮。在组中的任何无线电上调用此命令。替换-[NSMatrix selectCellWithTag:]。
 */

- (void)tfy_selectRadioWithTag:(NSInteger)tag;
{
    [self tfy_enumerateRadiosUsingBlock:^(NSButton *radio, BOOL *stop)
     {
         radio.state = radio.tag == tag;
     }];
}

/**

 假设接收者是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并返回所选单选的标签值。在组中的任何无线电上调用此命令。替换-[NSMatrix selectedTag]。
 */

- (NSInteger)tfy_selectedRadioTag;
{
    NSButton *foundRadio = [self tfy_radioPassingTest:^BOOL(NSButton *radio, BOOL *stop)
     {
         return radio.state;
     }];
    
    return foundRadio.tag;
}

/**
 如果无线电组已启用，则返回YES，如果未启用则返回NO。简单地返回接收者的状态;其他的假设都是一样的。(如果你想知道它们是否全部启用或禁用，可能最好使用-tfy_enumerateRadiosUsingBlock:来扫描组，并根据需要处理混合情况。)

 */

- (BOOL)tfy_radiosEnabled;
{
    return self.enabled;
}

/**
 将组中的所有无线电设置为启用或禁用。替换-[NSMatrix setEnabled:]。
 */

- (void)tfy_setRadiosEnabled:(BOOL)enabled;
{
    [self tfy_enumerateRadiosUsingBlock:^(NSButton *radio, BOOL *stop)
     {
         radio.enabled = enabled;
     }];
}

/**
 假设接收器是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并为每个按钮执行块，将单选按钮传递给块。返回返回YES的值，如果块在完成前请求停止，则返回nil，或者块在没有返回YES的情况下完成。在组中的任何无线电上调用此命令。

 一个以单选按钮和停止布尔引用作为参数并返回布尔值的块。
 @返回找到的单选按钮，如果没有找到，则返回nil。
 */

- (NSButton *)tfy_radioPassingTest:(BOOL (^)(NSButton *radio, BOOL *stop))predicate;
{
    for (NSButton *radio in self.superview.subviews)
    {
        // 没有可靠的方法来确定一个按钮是否实际上是单选按钮，但可以合理地假设没有非单选按钮将具有相同的动作(具有相同的动作使其成为组的成员):
        if ([radio isKindOfClass:[NSButton class]] && radio.action == self.action && predicate)
        {
            BOOL stop = NO;
            
            if (predicate(radio, &stop))
            {
                return radio;
            }
            
            if (stop)
            {
                return nil;
            }
        }
    }
    
    return nil;
}

/**
 假设接收器是一个单选按钮，在组中找到其他单选按钮(即在相同的父视图中，具有相同的操作)，并为每个按钮执行块，将单选按钮传递给块。在组中的任何无线电上调用此命令。

 一个以单选按钮和停止布尔引用作为参数并返回void的块。
 */

- (void)tfy_enumerateRadiosUsingBlock:(void (^)(NSButton *radio, BOOL *stop))block;
{
    for (NSButton *radio in self.superview.subviews)
    {
        // 没有可靠的方法来确定一个按钮是否实际上是单选按钮，但可以合理地假设没有非单选按钮将具有相同的动作(具有相同的动作使其成为组的成员):
        if ([radio isKindOfClass:[NSButton class]] && radio.action == self.action && block)
        {
            BOOL stop = NO;
            
            block(radio, &stop);
            
            if (stop)
            {
                return;
            }
        }
    }
}

@end

