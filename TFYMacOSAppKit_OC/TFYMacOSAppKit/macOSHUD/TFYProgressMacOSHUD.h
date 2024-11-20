//
//  TFYProgressMacOSHUD.h
//  AegisMacOsCommany
//
//  Created by apple on 2024/11/18.
//  Copyright © 2024 Aegis. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TFYAnimationEnhancer.h"
#import "TFYGestureHandler.h"
#import "TFYLayoutManager.h"
#import "TFYThemeManager.h"
#import "TFYProgressView.h"
#import "TFYProgressIndicator.h"

NS_ASSUME_NONNULL_BEGIN

// HUD显示模式
typedef NS_ENUM(NSInteger, TFYHUDMode) {
    TFYHUDModeIndeterminate,     // 不确定进度模式(转圈)
    TFYHUDModeDeterminate,       // 确定进度模式(进度条)
    TFYHUDModeText,             // 纯文本模式
    TFYHUDModeCustomView,       // 自定义视图模式
    TFYHUDModeLoading           // 加载模式
};

@interface TFYProgressMacOSHUD : NSView
// 基本属性
@property (nonatomic, strong, readonly) NSView *containerView;
@property (nonatomic, strong, readonly) NSTextField *statusLabel;
@property (nonatomic, strong, readonly) TFYProgressIndicator *activityIndicator;
@property (nonatomic, strong, readonly) TFYProgressView *progressView;
@property (nonatomic, strong, readonly) NSImageView *customImageView;
@property (nonatomic, assign) TFYHUDMode mode;

// 便捷方法
+ (instancetype)showHUDAddedTo:(NSView *)view;
+ (BOOL)hideHUDForView:(NSView *)view;
+ (NSArray *)allHUDsForView:(NSView *)view;

// 添加便捷提示方法
+ (void)showSuccess:(NSString *)status;
+ (void)showError:(NSString *)status;
+ (void)showInfo:(NSString *)status;
+ (void)showMessage:(NSString *)status;
+ (void)showLoading:(NSString *)status;
+ (void)showProgress:(float)progress status:(nullable NSString *)status;
+ (void)showImage:(NSImage *)image status:(NSString *)status;

// 隐藏方法
+ (void)hideHUD;
+ (void)hideHUDAfterDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
