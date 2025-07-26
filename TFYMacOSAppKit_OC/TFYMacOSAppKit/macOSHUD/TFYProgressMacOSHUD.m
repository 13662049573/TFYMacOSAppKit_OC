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

@interface TFYProgressMacOSHUD ()

@property (nonatomic, strong, readwrite) NSView *containerView;
@property (nonatomic, strong, readwrite) NSTextField *statusLabel;
@property (nonatomic, strong, readwrite) TFYProgressIndicator *activityIndicator;
@property (nonatomic, strong, readwrite) TFYProgressView *progressView;
@property (nonatomic, strong, readwrite) NSImageView *customImageView;
@property (nonatomic, strong) TFYLayoutManager *layoutManager;
@property (nonatomic, strong) TFYThemeManager *themeManager;
@property (nonatomic, strong) TFYAnimationEnhancer *animation;
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
    self.animation = [[TFYAnimationEnhancer alloc] init];
    
    // 创建器视图
    self.containerView = [[NSView alloc] init];
    [self addSubview:self.containerView];
    
    // 创建子视图
    [self setupSubviews];
    
    // 设置初始状态
    [self setupInitialState];
    
    // 设置布局
    [self.layoutManager setupHUDConstraints:self];
    [self.layoutManager setupConstraintsForHUD:self];
    [self.layoutManager setupAdaptiveLayoutForHUD:self];
    [self.layoutManager setupSubviewsConstraints:self];
}

- (void)setupSubviews {
    // 活动指示器（加载圈）
    self.activityIndicator = [[TFYProgressIndicator alloc] init];
    [self.containerView addSubview:self.activityIndicator];
    
    self.progressView = [[TFYProgressView alloc] initWithStyle:TFYProgressViewStyleRing];
    [self.containerView addSubview:self.progressView];
    
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
}

#pragma mark - 显示控制

- (void)show {
    self.hidden = NO;
    self.alphaValue = 1.0;
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
    self.progressView.progress = progress;
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
}

#pragma mark - 初始状态设置方法

- (void)setupInitialState {
    [self.themeManager applyThemeToHUD:self];
    
    // 隐藏所有指示器
    [self hideAllIndicators];
    
    // 设置初始状态
    self.hidden = YES;
    self.alphaValue = 0.0;
}

#pragma mark - 隐藏所有指示器的方法

- (void)hideAllIndicators {
    [self.activityIndicator stopAnimation];
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
            [self.activityIndicator startAnimation];
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
        [hud hideAfterDelay:2.0];
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
        [hud hideAfterDelay:2.0];
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
        [hud.activityIndicator startAnimation];
        
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

+ (void)showImage:(NSImage *)image status:(NSString *)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        TFYProgressMacOSHUD *hud = [self sharedHUD];
        hud.mode = TFYHUDModeCustomView;
        [hud showImage:image status:status];
        [hud hideAfterDelay:2.0];
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
    [[NSColor greenColor] setStroke];
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

