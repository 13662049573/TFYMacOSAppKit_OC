//
//  TFYProgressMacOSHUD.m
//  AegisMacOsCommany
//
//  Created by apple on 2024/11/18.
//  Copyright © 2024 Aegis. All rights reserved.
//

#import "TFYProgressMacOSHUD.h"
#import "TFYLayoutManager.h"
#import "TFYThemeManager.h"
#import "TFYPerformanceMonitor.h"
#import "TFYAnimationController.h"

@interface TFYProgressMacOSHUD ()

@property (nonatomic, strong, readwrite) NSView *containerView;
@property (nonatomic, strong, readwrite) NSTextField *statusLabel;
@property (nonatomic, strong, readwrite) NSProgressIndicator *activityIndicator;
@property (nonatomic, strong, readwrite) NSProgressIndicator *progressView;
@property (nonatomic, strong, readwrite) NSImageView *customImageView;
@property (nonatomic, strong) TFYLayoutManager *layoutManager;
@property (nonatomic, strong) TFYThemeManager *themeManager;
@property (nonatomic, strong) TFYAnimationController *animationController;
@property (nonatomic, strong) NSTimer *hideTimer;

@end

@implementation TFYProgressMacOSHUD

#pragma mark - 初始化方法
+ (TFYProgressMacOSHUD *)sharedHUD {
    static TFYProgressMacOSHUD *sharedHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSWindow *mainWindow = [NSApplication sharedApplication].mainWindow;
        if (mainWindow) {
            NSView *contentView = mainWindow.contentView;
            contentView.wantsLayer = YES;
            
            // 创建HUD
            sharedHUD = [[TFYProgressMacOSHUD alloc] initWithFrame:contentView.bounds];
            sharedHUD.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            
            // 设置HUD背景为透明
            sharedHUD.wantsLayer = YES;
            sharedHUD.layer.backgroundColor = [NSColor clearColor].CGColor;
            
            // 添加到父视图
            [contentView addSubview:sharedHUD];
            
            // 设置约束
            sharedHUD.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                [sharedHUD.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor],
                [sharedHUD.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor],
                [sharedHUD.topAnchor constraintEqualToAnchor:contentView.topAnchor],
                [sharedHUD.bottomAnchor constraintEqualToAnchor:contentView.bottomAnchor]
            ]];
            
            sharedHUD.hidden = YES;
        }
    });
    return sharedHUD;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    // 初始化管理器
    self.layoutManager = [[TFYLayoutManager alloc] init];
    self.themeManager = [[TFYThemeManager alloc] init];
    self.animationController = [[TFYAnimationController alloc] init];
    
    // 创建半透明背景视图（蒙版）
    NSView *backgroundView = [[NSView alloc] init];
    backgroundView.wantsLayer = YES;
    backgroundView.layer.backgroundColor = [[NSColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:backgroundView];
    
    // 设置背景视图约束
    [NSLayoutConstraint activateConstraints:@[
        [backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [backgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    
    // 创建器视图
    NSVisualEffectView *containerView = [[NSVisualEffectView alloc] init];
    containerView.wantsLayer = YES;
    containerView.material = NSVisualEffectMaterialHUDWindow;
    containerView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    containerView.state = NSVisualEffectStateActive;
    containerView.layer.cornerRadius = 10.0;
    containerView.layer.masksToBounds = YES;
    self.containerView = containerView;
    [self addSubview:containerView];
    
    // 创建子视图
    [self setupSubviews];
    
    // 设置初始状态
    [self setupInitialState];
    
    // 设置布局
    [self.layoutManager setupConstraintsForHUD:self];
    [self.layoutManager setupAdaptiveLayoutForHUD:self];
    [self.layoutManager setupSubviewsConstraints:self];
}

- (void)setupSubviews {
    // 活动指示器（加载圈）
    self.activityIndicator = [[NSProgressIndicator alloc] init];
    self.activityIndicator.style = NSProgressIndicatorStyleSpinning;
    self.activityIndicator.controlSize = NSControlSizeRegular;
    self.activityIndicator.indeterminate = YES;
    self.activityIndicator.usesThreadedAnimation = YES;
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.wantsLayer = YES;
    self.activityIndicator.layer.backgroundColor = [NSColor clearColor].CGColor;
    self.activityIndicator.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
    [self.containerView addSubview:self.activityIndicator];
    
    // 状态标签
    self.statusLabel = [[NSTextField alloc] init];
    self.statusLabel.bezeled = NO;
    self.statusLabel.editable = NO;
    self.statusLabel.drawsBackground = NO;
    self.statusLabel.alignment = NSTextAlignmentCenter;
    self.statusLabel.textColor = [NSColor whiteColor];
    self.statusLabel.font = [NSFont systemFontOfSize:14];
    self.statusLabel.cell.wraps = YES;
    self.statusLabel.cell.scrollable = NO;
    self.statusLabel.maximumNumberOfLines = 0;
    self.statusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.statusLabel.preferredMaxLayoutWidth = 200;
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.statusLabel];
    
    // 自定义图片视图
    self.customImageView = [[NSImageView alloc] init];
    self.customImageView.imageScaling = NSImageScaleProportionallyDown;
    self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.customImageView];
    
    // 设置customImageView的约束
    [NSLayoutConstraint activateConstraints:@[
        [self.customImageView.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor],
        [self.customImageView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:20],
        [self.customImageView.widthAnchor constraintEqualToConstant:32],
        [self.customImageView.heightAnchor constraintEqualToConstant:32]
    ]];
    
    // 如果状态标签存在，添加与customImageView的约束
    if (self.statusLabel) {
        [NSLayoutConstraint activateConstraints:@[
            [self.statusLabel.topAnchor constraintEqualToAnchor:self.customImageView.bottomAnchor constant:12]
        ]];
    }
    
    // 设置容器视图约束
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        // 容器视图居中
        [self.containerView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.containerView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        
        // 容器视图最小尺寸
        [self.containerView.widthAnchor constraintGreaterThanOrEqualToConstant:120],
        [self.containerView.heightAnchor constraintGreaterThanOrEqualToConstant:120],
        
        // 容器视图内边距
        [self.containerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.leadingAnchor constant:40],
        [self.containerView.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-40]
    ]];
    
    // 设置活动指示器约束
    [NSLayoutConstraint activateConstraints:@[
        [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor],
        [self.activityIndicator.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:20],
        [self.activityIndicator.widthAnchor constraintEqualToConstant:32],
        [self.activityIndicator.heightAnchor constraintEqualToConstant:32]
    ]];
    
    // 设置状态标签约束
    [NSLayoutConstraint activateConstraints:@[
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.activityIndicator.bottomAnchor constant:12],
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:16],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-16],
        [self.statusLabel.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:-16]
    ]];
}

#pragma mark - 显示控制

- (void)show {
    self.hidden = NO;
    self.alphaValue = 1.0;
    // 应用主题
    [self.themeManager applyThemeToHUD:self];
    // 确保视图在最上层
    if (self.superview) {
        [self.superview addSubview:self positioned:NSWindowAbove relativeTo:nil];
    }
}

- (void)hide {
    self.hidden = YES;
    self.alphaValue = 0.0;
}

- (void)hideAfterDelay:(NSTimeInterval)delay {
    [self.hideTimer invalidate];
    self.hideTimer = [NSTimer scheduledTimerWithTimeInterval:delay
                                                    target:self
                                                  selector:@selector(hide)
                                                  userInfo:nil
                                                   repeats:NO];
}

#pragma mark - 状态更新

- (void)showStatus:(NSString *)status {
    self.statusLabel.stringValue = status ?: @"";
    self.statusLabel.hidden = NO;
    [self show];
}

- (void)showProgress:(float)progress {
    [self showProgress:progress status:nil];
}

- (void)showProgress:(float)progress status:(NSString *)status {
    self.mode = TFYHUDModeDeterminate;
    self.progressView.doubleValue = progress;
    self.statusLabel.stringValue = status ?: @"";
    [self show];
}

- (void)showImage:(NSImage *)image status:(NSString *)status {
    self.mode = TFYHUDModeCustomView;
    self.customImageView.image = image;
    self.statusLabel.stringValue = status ?: @"";
    [self show];
}

- (void)showCustomView:(NSView *)customView status:(NSString *)status {
    self.mode = TFYHUDModeCustomView;
    [self.customImageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (customView) {
        [self.customImageView addSubview:customView];
    }
    self.statusLabel.stringValue = status ?: @"";
    [self show];
}

#pragma mark - 动画

- (CAAnimation *)fadeInAnimation {
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0;
    fadeIn.toValue = @1.0;
    fadeIn.duration = 0.2;
    fadeIn.fillMode = kCAFillModeForwards;
    fadeIn.removedOnCompletion = NO;
    return fadeIn;
}

- (CAAnimation *)fadeOutAnimation {
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.fromValue = @1.0;
    fadeOut.toValue = @0.0;
    fadeOut.duration = 0.2;
    fadeOut.fillMode = kCAFillModeForwards;
    fadeOut.removedOnCompletion = NO;
    return fadeOut;
}

#pragma mark - 便方法

+ (instancetype)showHUDAddedTo:(NSView *)view {
    TFYProgressMacOSHUD *hud = [[self alloc] initWithFrame:view.bounds];
    [view addSubview:hud];
    [hud show];
    return hud;
}

+ (BOOL)hideHUDForView:(NSView *)view {
    NSArray *huds = [self allHUDsForView:view];
    for (TFYProgressMacOSHUD *hud in huds) {
        [hud hide];
    }
    return huds.count > 0;
}

+ (NSArray *)allHUDsForView:(NSView *)view {
    NSMutableArray *huds = [NSMutableArray array];
    for (NSView *subview in view.subviews) {
        if ([subview isKindOfClass:[self class]]) {
            [huds addObject:subview];
        }
    }
    return huds;
}

#pragma mark - 清理

- (void)dealloc {
    [self.hideTimer invalidate];
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始状态设置方法

- (void)setupInitialState {
    // 设置HUD为透明
    self.layer.backgroundColor = [NSColor clearColor].CGColor;
    
    // 设置状态标签的颜色
    self.statusLabel.textColor = [NSColor labelColor];
    
    // 设置活动指示器
    self.activityIndicator.controlSize = NSControlSizeRegular;
    self.activityIndicator.style = NSProgressIndicatorStyleSpinning;
    
    // 隐藏所有指示器
    [self hideAllIndicators];
    
    // 设置初始状态
    self.hidden = YES;
    self.alphaValue = 0.0;
}

- (void)systemAppearanceDidChange:(NSNotification *)notification {
    // 系统外观改变时更新视图
    [self updateAppearance];
}

- (void)updateAppearance {
    // 更新状态标签颜色
    self.statusLabel.textColor = [NSColor labelColor];
    
    // 更新容器视图外观
    NSVisualEffectView *containerView = (NSVisualEffectView *)self.containerView;
    containerView.material = NSVisualEffectMaterialHUDWindow;
    
    // 确保活动指示器背景透明
    self.activityIndicator.layer.backgroundColor = [NSColor clearColor].CGColor;
    self.activityIndicator.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
}

#pragma mark - 隐藏所有指示器的方法

- (void)hideAllIndicators {
    [self.activityIndicator stopAnimation:nil];
    self.activityIndicator.hidden = YES;
    self.progressView.hidden = YES;
    self.customImageView.hidden = YES;
    self.statusLabel.hidden = YES;
}

#pragma mark - 修改 setMode 方法

- (void)setMode:(TFYHUDMode)mode {
    _mode = mode;
    
    [self hideAllIndicators];
    
    switch (mode) {
        case TFYHUDModeIndeterminate:
        case TFYHUDModeLoading:
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimation:nil];
            self.statusLabel.hidden = NO;
            break;
            
        case TFYHUDModeText:
            self.statusLabel.hidden = NO;
            break;
            
        case TFYHUDModeDeterminate:
            self.progressView.hidden = NO;
            self.statusLabel.hidden = NO;
            break;
            
        case TFYHUDModeCustomView:
            self.customImageView.hidden = NO;
            self.statusLabel.hidden = NO;
            break;
    }
}


+ (void)showSuccess:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        if (!hud) return;
        
        hud.mode = TFYHUDModeCustomView;
        hud.customImageView.image = [self createSuccessImage];
        hud.customImageView.hidden = NO;
        hud.statusLabel.stringValue = status ?: @"";
        hud.statusLabel.hidden = NO;
        
        [hud show];
        [hud hideAfterDelay:2.0];
    });
}

+ (void)showError:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        hud.mode = TFYHUDModeCustomView;
        
        // 创建错误图标
        NSImage *errorImage = [NSImage imageNamed:@"error"]; // 确保有这个图片资源
        if (!errorImage) {
            // 如果没有图片资源，创建一个默认的叉号图标
            errorImage = [self createErrorImage];
        }
        
        [hud showImage:errorImage status:status];
        [hud hideAfterDelay:3.0];
    });
}

+ (void)showInfo:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        hud.mode = TFYHUDModeCustomView;
        
        // 创建信息图标
        NSImage *infoImage = [NSImage imageNamed:@"info"]; // 确保有这个图片资源
        if (!infoImage) {
            // 如果没有图片资源，创建一个默认的信息图标
            infoImage = [self createInfoImage];
        }
        
        [hud showImage:infoImage status:status];
        [hud hideAfterDelay:3.0];
    });
}

+ (void)showMessage:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        if (!hud) return;
        
        hud.mode = TFYHUDModeText;
        hud.hidden = NO;
        hud.alphaValue = 1.0;
        [hud showStatus:status];
        [hud hideAfterDelay:2.0];
    });
}

+ (void)showLoading:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        if (!hud) return;
        
        hud.mode = TFYHUDModeLoading;
        hud.hidden = NO;
        hud.alphaValue = 1.0;
        
        // 显示加载圈
        hud.activityIndicator.hidden = NO;
        [hud.activityIndicator startAnimation:nil];
        
        // 显示状态文本
        hud.statusLabel.stringValue = status ?: @"";
        hud.statusLabel.hidden = NO;
        
        // 确保视图在最上层
        if (hud.superview) {
            [hud.superview addSubview:hud positioned:NSWindowAbove relativeTo:nil];
        }
    });
}

+ (void)showProgress:(float)progress status:(nullable NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        hud.mode = TFYHUDModeDeterminate;
        [hud showProgress:progress status:status];
    });
}

#pragma mark - 隐藏方法

+ (void)hideHUD {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self sharedHUD] hide];
    });
}

+ (void)hideHUDAfterDelay:(NSTimeInterval)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self sharedHUD] hideAfterDelay:delay];
    });
}

#pragma mark - 辅助方法：创建默认图标

+ (NSImage *)createSuccessImage {
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(32, 32)];
    [image lockFocus];
    
    // 设置抗锯齿
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [[NSGraphicsContext currentContext] setShouldAntialias:YES];
    
    // 创建对勾路径 - 修改绘制点的顺序和位置
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(8, 16)];      // 起点（左侧）
    [path lineToPoint:NSMakePoint(14, 12)];     // 中间点（底部）
    [path lineToPoint:NSMakePoint(24, 22)];     // 终点（顶部）
    
    // 设置线条属性
    path.lineWidth = 2.5;
    path.lineCapStyle = NSLineCapStyleRound;
    path.lineJoinStyle = NSLineJoinStyleRound;
    
    // 设置颜色并绘制
    [[NSColor whiteColor] setStroke];
    [path stroke];
    
    [image unlockFocus];
    
    // 确保图片不会被缓存
    [image setTemplate:NO];
    [image setCacheMode:NSImageCacheNever];
    
    return image;
}

+ (NSImage *)createErrorImage {
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(32, 32)];
    [image lockFocus];
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(8, 8)];
    [path lineToPoint:NSMakePoint(24, 24)];
    [path moveToPoint:NSMakePoint(24, 8)];
    [path lineToPoint:NSMakePoint(8, 24)];
    
    [[NSColor redColor] set];
    path.lineWidth = 2;
    [path stroke];
    
    [image unlockFocus];
    return image;
}

+ (NSImage *)createInfoImage {
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(32, 32)];
    [image lockFocus];
    
    NSBezierPath *circlePath = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(14, 20, 4, 4)];
    NSBezierPath *linePath = [NSBezierPath bezierPath];
    [linePath moveToPoint:NSMakePoint(16, 8)];
    [linePath lineToPoint:NSMakePoint(16, 16)];
    
    [[NSColor redColor] set];
    [circlePath fill];
    linePath.lineWidth = 2;
    [linePath stroke];
    
    [image unlockFocus];
    return image;
}

@end

