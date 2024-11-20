
//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

// 进度条样式
typedef NS_ENUM(NSInteger, TFYProgressViewStyle) {
    TFYProgressViewStyleRing,     // 圆形样式
    TFYProgressViewStyleHorizontal,   // 水平样式
};

@interface TFYProgressView : NSView

// 基本属性
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) TFYProgressViewStyle style;
@property (nonatomic, strong) NSColor *progressColor;
@property (nonatomic, strong) NSColor *trackColor;
@property (nonatomic, assign) CGFloat lineWidth;

// 动画相关
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

// 初始化方法
- (instancetype)initWithStyle:(TFYProgressViewStyle)style;

// 进度控制
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated completion:(nullable void(^)(void))completion;

// 样式配置
- (void)setStyle:(TFYProgressViewStyle)style animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END 
