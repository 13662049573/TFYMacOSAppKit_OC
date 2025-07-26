//
//  TFYButton.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, TFYControlState) {
    TFYControlStateNormal       = 1 << 0,
    TFYControlStateHighlighted  = 1 << 1,
    TFYControlStateDisabled     = 1 << 2,
    TFYControlStateSelected     = 1 << 3,
    TFYControlStateHover        = 1 << 4,
};

typedef NS_ENUM(NSInteger, TFYButtonType) {
    TFYButtonTypeText = 0,   //just text
    TFYButtonType1 = 1,      //backgroud: white , text: blue, has bordColor
    TFYButtonType2 = 2,      //backgroud: blue , text: white
};


@interface TFYButton : NSButton

@property(nonatomic, assign) TFYButtonType buttonType;
@property(nonatomic, copy) void(^block)(TFYButton *sender,TFYControlState state);

@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) BOOL showHighlighted;
@property(nonatomic, assign) BOOL isAttributedTitle;

@property(nonatomic, strong) NSColor *titleColor;
@property(nonatomic, strong) NSImage *backgroundImage;

- (void)setTitle:(nullable NSString *)title forState:(TFYControlState)state;
- (void)setTitleColor:(nullable NSColor *)color forState:(TFYControlState)state;

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(TFYControlState)state;
- (void)setBackgroundImage:(nullable NSImage *)image forState:(TFYControlState)state;

- (void)setBorderColor:(nullable NSColor *)color forState:(TFYControlState)state;
- (void)setBorderWidth:(nullable NSNumber *)number forState:(TFYControlState)state;
- (void)setCornerRadius:(nullable NSNumber *)number forState:(TFYControlState)state;

- (nullable NSString *)titleForState:(TFYControlState)state;
- (nullable NSColor *)titleColorForState:(TFYControlState)state;
- (nullable NSAttributedString *)attributedStringForState:(TFYControlState)state;

- (nullable NSImage *)backgroundImageForState:(TFYControlState)state;

- (nullable NSColor *)borderColorForState:(TFYControlState)state;
- (nullable NSNumber *)borderWidthForState:(TFYControlState)state;
- (nullable NSNumber *)cornerRadiusForState:(TFYControlState)state;

///实时返回对应状态事件
- (void)stateBlock:(void(^)(TFYButton *sender, TFYControlState state))block;

@end

NS_ASSUME_NONNULL_END
