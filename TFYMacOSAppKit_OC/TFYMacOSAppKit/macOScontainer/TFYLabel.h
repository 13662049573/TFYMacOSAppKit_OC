//
//  TFYLabel.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TFYContentVerticalAlignment) {
    TFYContentVerticalAlignmentTop      = 0,
    TFYContentVerticalAlignmentCenter    = 1,
    TFYContentVerticalAlignmentBottom     = 2,
};

@interface TFYLabel : NSView

@property(nullable, nonatomic,copy)   NSString           *title; // default is nil
@property(nonatomic, strong) NSFont      *font; // default is nil (system font 17 plain)
@property(nonatomic, strong) NSColor     *textColor; // default is labelColor
@property(nonatomic, assign) NSTextAlignment    textAlignment;   // default is NSTextAlignmentLeft
/// 整体内容垂直对齐方向
@property(nonatomic, assign) TFYContentVerticalAlignment    contentVerticalAlignment;   // default is NSContentVerticalAlignmentTop

@property(nonatomic, assign)        NSLineBreakMode    lineBreakMode;   // default is NSLineBreakByWordWrapping. used for single and multiple lines of text

// the underlying attributed string drawn by the label, if set, the label ignores the properties above.
@property(nullable, nonatomic,copy)   NSAttributedString *attributedText;  // default is nil

// the 'highlight' property is used by subclasses for such things as pressed states. it's useful to make it part of the base class as a user property

@property(nullable, nonatomic,strong)       NSColor *highlightedTextColor; // default is nil
@property(nonatomic,getter=isHighlighted)   BOOL     highlighted;          // default is NO

@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;  // default is NO
@property(nonatomic,getter=isEnabled)                BOOL enabled;                 // default is YES. changes how the label is drawn

@property(nonatomic, copy) void(^mouseDownBlock)(TFYLabel *sender);
///返回事件
- (void)actionBlock:(void(^)(TFYLabel *sender))block;

@end

NS_ASSUME_NONNULL_END
