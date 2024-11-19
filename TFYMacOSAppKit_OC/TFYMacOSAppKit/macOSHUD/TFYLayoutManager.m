#import "TFYLayoutManager.h"
#import "TFYProgressMacOSHUD.h"

@interface TFYLayoutManager ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TFYLayoutBlock> *layouts;
@property (nonatomic, weak) TFYProgressMacOSHUD *currentHUD;
@property (nonatomic, weak) NSView *currentContainer;
@property (nonatomic, strong) NSMutableArray *activeConstraints;
@property (nonatomic, assign) BOOL isUpdatingLayout;
@property (nonatomic, assign) BOOL isSettingConstraints;

@end

@implementation TFYLayoutManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _layouts = [NSMutableDictionary dictionary];
        _activeConstraints = [NSMutableArray array];
        [self setupDefaultLayouts];
    }
    return self;
}

#pragma mark - Layout Registration

- (void)registerLayout:(TFYLayoutBlock)layout forMode:(NSInteger)mode {
    if (!layout) return;
    self.layouts[@(mode)] = [layout copy];
}

- (void)applyLayoutForMode:(NSInteger)mode toHUD:(TFYProgressMacOSHUD *)hud {
    if (!hud) return;
    TFYLayoutBlock layout = self.layouts[@(mode)];
    if (layout) {
        layout(hud);
    }
}

- (void)removeLayoutForMode:(NSInteger)mode {
    [self.layouts removeObjectForKey:@(mode)];
}

- (void)setupDefaultLayouts {
    // 移除基于frame的布局方式，改用约束
    [self registerLayout:^(TFYProgressMacOSHUD *hud) {
        // 所有模式都使用约束布局
        [self setupHUDConstraints:hud];
    } forMode:TFYHUDModeIndeterminate];
    
    // 其他模式也使用相同的基础约束
    [self registerLayout:^(TFYProgressMacOSHUD *hud) {
        [self setupHUDConstraints:hud];
    } forMode:TFYHUDModeDeterminate];
    
    [self registerLayout:^(TFYProgressMacOSHUD *hud) {
        [self setupHUDConstraints:hud];
    } forMode:TFYHUDModeText];
    
    [self registerLayout:^(TFYProgressMacOSHUD *hud) {
        [self setupHUDConstraints:hud];
    } forMode:TFYHUDModeCustomView];
}

- (void)setupHUDConstraints:(TFYProgressMacOSHUD *)hud {
    if (!hud || !hud.containerView || !hud.superview) return;
    
    // 移除所有现有约束
    [self invalidateLayout];
    
    // 设置基本属性
    hud.translatesAutoresizingMaskIntoConstraints = NO;
    hud.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *allConstraints = [NSMutableArray array];
    NSView *container = hud.containerView;
    
    // 1. HUD 主视图约束 - 填充父视图
    [allConstraints addObjectsFromArray:@[
        [hud.leadingAnchor constraintEqualToAnchor:hud.superview.leadingAnchor],
        [hud.trailingAnchor constraintEqualToAnchor:hud.superview.trailingAnchor],
        [hud.topAnchor constraintEqualToAnchor:hud.superview.topAnchor],
        [hud.bottomAnchor constraintEqualToAnchor:hud.superview.bottomAnchor]
    ]];
    
    // 2. 容器视图约束
    // 居中约束
    [allConstraints addObjectsFromArray:@[
        [container.centerXAnchor constraintEqualToAnchor:hud.centerXAnchor],
        [container.centerYAnchor constraintEqualToAnchor:hud.centerYAnchor]
    ]];
    
    // 大小约束
    [allConstraints addObjectsFromArray:@[
        [container.widthAnchor constraintGreaterThanOrEqualToConstant:100],
        [container.widthAnchor constraintLessThanOrEqualToConstant:250],
        [container.heightAnchor constraintGreaterThanOrEqualToConstant:100]
    ]];
    
    // 边距约束
    [allConstraints addObjectsFromArray:@[
        [container.leadingAnchor constraintGreaterThanOrEqualToAnchor:hud.leadingAnchor constant:20],
        [container.trailingAnchor constraintLessThanOrEqualToAnchor:hud.trailingAnchor constant:-20]
    ]];
    
    // 激活约束
    [NSLayoutConstraint activateConstraints:allConstraints];
    [self.activeConstraints addObjectsFromArray:allConstraints];
}

- (void)setupConstraintsForHUD:(TFYProgressMacOSHUD *)hud {
    if (!hud || !hud.superview) return;
    
    // 禁用自动布局转换
    hud.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 移除现有约束
    [self removeExistingConstraints:hud];
    
    // 创建新的约束，确保HUD填满父视图
    NSArray *constraints = @[
        [hud.leadingAnchor constraintEqualToAnchor:hud.superview.leadingAnchor],
        [hud.trailingAnchor constraintEqualToAnchor:hud.superview.trailingAnchor],
        [hud.topAnchor constraintEqualToAnchor:hud.superview.topAnchor],
        [hud.bottomAnchor constraintEqualToAnchor:hud.superview.bottomAnchor]
    ];
    
    // 激活约束
    [NSLayoutConstraint activateConstraints:constraints];
    [self.activeConstraints addObjectsFromArray:constraints];
}

- (void)setupConstraintsForContainer:(NSView *)containerView {
    if (!containerView || !self.currentHUD) return;
    
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self removeExistingConstraints:containerView];
    
    NSArray *constraints = @[
        [containerView.centerXAnchor constraintEqualToAnchor:self.currentHUD.centerXAnchor],
        [containerView.centerYAnchor constraintEqualToAnchor:self.currentHUD.centerYAnchor]
    ];
    
    [NSLayoutConstraint activateConstraints:constraints];
    [self.activeConstraints addObjectsFromArray:constraints];
}

- (void)setupAdaptiveLayoutForHUD:(TFYProgressMacOSHUD *)hud {
    if (!hud) return;
    
    // 设置自动布局属性
    hud.translatesAutoresizingMaskIntoConstraints = NO;
    hud.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 设置容器视图的内容优先级
    [hud.containerView setContentCompressionResistancePriority:NSLayoutPriorityRequired 
                                                forOrientation:NSLayoutConstraintOrientationHorizontal];
    [hud.containerView setContentCompressionResistancePriority:NSLayoutPriorityRequired 
                                                forOrientation:NSLayoutConstraintOrientationVertical];
    
    [hud.containerView setContentHuggingPriority:NSLayoutPriorityDefaultHigh 
                                 forOrientation:NSLayoutConstraintOrientationHorizontal];
    [hud.containerView setContentHuggingPriority:NSLayoutPriorityDefaultHigh 
                                 forOrientation:NSLayoutConstraintOrientationVertical];
    
    // 设置状态标签的内容优先级
    [hud.statusLabel setContentCompressionResistancePriority:NSLayoutPriorityRequired 
                                             forOrientation:NSLayoutConstraintOrientationHorizontal];
    [hud.statusLabel setContentCompressionResistancePriority:NSLayoutPriorityRequired 
                                             forOrientation:NSLayoutConstraintOrientationVertical];
    
    [hud.statusLabel setContentHuggingPriority:NSLayoutPriorityDefaultLow 
                                forOrientation:NSLayoutConstraintOrientationHorizontal];
    [hud.statusLabel setContentHuggingPriority:NSLayoutPriorityDefaultLow 
                                forOrientation:NSLayoutConstraintOrientationVertical];
}

- (void)setupSubviewsConstraints:(TFYProgressMacOSHUD *)hud {
    if (!hud || !hud.containerView) return;
    
    NSView *container = hud.containerView;
    NSMutableArray *constraints = [NSMutableArray array];
    
    // 确保所有子视图自动换
    for (NSView *subview in container.subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 根据模式设置约束
    switch (hud.mode) {
        case TFYHUDModeLoading:
            // 无状态文本时居中显示
            [constraints addObject:[hud.activityIndicator.centerYAnchor constraintEqualToAnchor:container.centerYAnchor]];
            break;
        case TFYHUDModeDeterminate:
            [self setupDeterminateConstraints:hud constraints:constraints];
            break;
            
        case TFYHUDModeCustomView:
            [self setupCustomViewConstraints:hud constraints:constraints];
            break;
        default:
            [self setupDefaultConstraints:hud constraints:constraints];
            break;
    }
    
    // 激活约束
    [NSLayoutConstraint activateConstraints:constraints];
    [self.activeConstraints addObjectsFromArray:constraints];
}

- (void)updateLayoutForOrientation:(NSInteger)orientation {
    [self invalidateLayout];
    [self setupConstraintsForContainer:self.currentContainer];
    [self setupSubviewsConstraints:self.currentHUD];
}

- (void)invalidateLayout {
    [NSLayoutConstraint deactivateConstraints:self.activeConstraints];
    [self.activeConstraints removeAllObjects];
}

- (void)removeExistingConstraints:(NSView *)view {
    for (NSLayoutConstraint *constraint in view.constraints) {
        constraint.active = NO;
    }
}

- (void)setupDeterminateConstraints:(TFYProgressMacOSHUD *)hud constraints:(NSMutableArray *)constraints {
    NSView *container = hud.containerView;
    
    // 进度条模式
    if (!hud.progressView.hidden) {
        // 进度条基本约束
        [constraints addObjectsFromArray:@[
            [hud.progressView.widthAnchor constraintEqualToConstant:200],
            [hud.progressView.heightAnchor constraintEqualToConstant:20],
            [hud.progressView.centerXAnchor constraintEqualToAnchor:container.centerXAnchor]
        ]];
        
        if (!hud.statusLabel.hidden) {
            // 有状态文本时的布局
            [constraints addObjectsFromArray:@[
                [hud.progressView.topAnchor constraintEqualToAnchor:container.topAnchor constant:20],
                [hud.statusLabel.topAnchor constraintEqualToAnchor:hud.progressView.bottomAnchor constant:12],
                [hud.statusLabel.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:16],
                [hud.statusLabel.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-16],
                [hud.statusLabel.bottomAnchor constraintEqualToAnchor:container.bottomAnchor constant:-16]
            ]];
        } else {
            // 无状态文本时居中显示
            [constraints addObject:[hud.progressView.centerYAnchor constraintEqualToAnchor:container.centerYAnchor]];
        }
    } else {
        [self setupAdvancedCenterConstraints:hud];
    }
}

- (void)setupAdvancedCenterConstraints:(TFYProgressMacOSHUD *)hud {
    // 确保视图已添加到父视图
    if (hud.mode != TFYHUDModeIndeterminate) return;
    
    // 禁用自动转换frame为约束
    hud.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    // 1. 基础居中约束
    [constraints addObjectsFromArray:@[
        // 水平居中
        [hud.centerXAnchor constraintEqualToAnchor:hud.activityIndicator.centerXAnchor],
        // 垂直居中
        [hud.centerYAnchor constraintEqualToAnchor:hud.activityIndicator.centerYAnchor]
    ]];
    
    // 2. 大小约束
    [constraints addObjectsFromArray:@[
        // 最小宽度
        [hud.widthAnchor constraintGreaterThanOrEqualToConstant:40],
        // 最大宽度（相对于父视图）
        [hud.widthAnchor constraintLessThanOrEqualToAnchor:hud.activityIndicator.widthAnchor multiplier:0.8],
        // 最小高度
        [hud.heightAnchor constraintGreaterThanOrEqualToConstant:40],
        // 最大高度（相对于父视图）
        [hud.heightAnchor constraintLessThanOrEqualToAnchor:hud.activityIndicator.heightAnchor multiplier:0.8]
    ]];
    
    // 3. 边距约束（确保不会太靠近边缘）
    CGFloat minimumMargin = 20.0;
    [constraints addObjectsFromArray:@[
        // 左边距最小值
        [hud.leadingAnchor constraintGreaterThanOrEqualToAnchor:hud.activityIndicator.leadingAnchor
                                                       constant:minimumMargin],
        // 右边距最小值
        [hud.trailingAnchor constraintLessThanOrEqualToAnchor:hud.activityIndicator.trailingAnchor
                                                     constant:-minimumMargin],
        // 顶部边距最小值
        [hud.topAnchor constraintGreaterThanOrEqualToAnchor:hud.activityIndicator.topAnchor
                                                   constant:minimumMargin],
        // 底部边距最小值
        [hud.bottomAnchor constraintLessThanOrEqualToAnchor:hud.activityIndicator.bottomAnchor
                                                   constant:-minimumMargin]
    ]];
}


- (void)setupCustomViewConstraints:(TFYProgressMacOSHUD *)hud constraints:(NSMutableArray *)constraints {
    NSView *container = hud.containerView;
    
    // 自定义视图模式（成功/失败图标等）
    if (!hud.customImageView.hidden) {
        // 图片视图基本约束
        [constraints addObjectsFromArray:@[
            [NSLayoutConstraint constraintWithItem:hud.customImageView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:1.0
                                       constant:48],
            [NSLayoutConstraint constraintWithItem:hud.customImageView
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                     multiplier:1.0
                                       constant:48],
            [NSLayoutConstraint constraintWithItem:hud.customImageView
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:container
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:1.0
                                       constant:0]
        ]];
        
        if (!hud.statusLabel.hidden) {
            // 有状态文本时的布局
            [constraints addObjectsFromArray:@[
                // 图片视图顶部约束
                [NSLayoutConstraint constraintWithItem:hud.customImageView
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:container
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1.0
                                           constant:20],
                // 状态标签约束
                [NSLayoutConstraint constraintWithItem:hud.statusLabel
                                          attribute:NSLayoutAttributeTop
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:hud.customImageView
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1.0
                                           constant:12],
                [NSLayoutConstraint constraintWithItem:hud.statusLabel
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:container
                                          attribute:NSLayoutAttributeLeading
                                         multiplier:1.0
                                           constant:16],
                [NSLayoutConstraint constraintWithItem:hud.statusLabel
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:container
                                          attribute:NSLayoutAttributeTrailing
                                         multiplier:1.0
                                           constant:-16],
                [NSLayoutConstraint constraintWithItem:hud.statusLabel
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:container
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1.0
                                           constant:-16]
            ]];
        } else {
            // 无状态文本时，图片视图垂直居中
            [constraints addObject:[NSLayoutConstraint constraintWithItem:hud.customImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:container
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0]];
        }
        
        // 容器最小尺寸约束
        [constraints addObjectsFromArray:@[
            [container.widthAnchor constraintGreaterThanOrEqualToConstant:120],
            [container.heightAnchor constraintGreaterThanOrEqualToConstant:100]
        ]];
    }
}

- (void)setupDefaultConstraints:(TFYProgressMacOSHUD *)hud constraints:(NSMutableArray *)constraints {
    NSView *container = hud.containerView;
    
    // 1. 容器视图基础约束（所有情况下都需要）
    [constraints addObjectsFromArray:@[
        // 容器视图居中
        [container.centerXAnchor constraintEqualToAnchor:hud.centerXAnchor],
        [container.centerYAnchor constraintEqualToAnchor:hud.centerYAnchor],
        
        // 容器视图最小尺寸
        [container.widthAnchor constraintGreaterThanOrEqualToConstant:120],
        [container.heightAnchor constraintGreaterThanOrEqualToConstant:100]
    ]];
    
    // 2. 根据不同模式设置内部约束
    if (!hud.activityIndicator.hidden) {
        // 活动指示器基本约束
        [constraints addObjectsFromArray:@[
            [hud.activityIndicator.widthAnchor constraintEqualToConstant:32],
            [hud.activityIndicator.heightAnchor constraintEqualToConstant:32],
            [hud.activityIndicator.centerXAnchor constraintEqualToAnchor:container.centerXAnchor]
        ]];
        
        if (!hud.statusLabel.hidden) {
            // 有状态文本时的布局
            NSLayoutConstraint *topConstraint = [hud.activityIndicator.topAnchor 
                constraintEqualToAnchor:container.topAnchor constant:20];
            topConstraint.priority = NSLayoutPriorityDefaultHigh;
            
            [constraints addObjectsFromArray:@[
                topConstraint,
                [hud.statusLabel.topAnchor constraintEqualToAnchor:hud.activityIndicator.bottomAnchor 
                    constant:12],
                [hud.statusLabel.leadingAnchor constraintEqualToAnchor:container.leadingAnchor 
                    constant:16],
                [hud.statusLabel.trailingAnchor constraintEqualToAnchor:container.trailingAnchor 
                    constant:-16],
                [hud.statusLabel.bottomAnchor constraintEqualToAnchor:container.bottomAnchor 
                    constant:-16]
            ]];
        } else {
            // 无状态文本时，活动指示器居中
            NSLayoutConstraint *centerYConstraint = [hud.activityIndicator.centerYAnchor 
                constraintEqualToAnchor:container.centerYAnchor];
            centerYConstraint.priority = NSLayoutPriorityRequired;
            [constraints addObject:centerYConstraint];
        }
    } else if (!hud.statusLabel.hidden) {
        // 纯文本模式
        [constraints addObjectsFromArray:@[
            [hud.statusLabel.topAnchor constraintEqualToAnchor:container.topAnchor constant:16],
            [hud.statusLabel.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:16],
            [hud.statusLabel.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-16],
            [hud.statusLabel.bottomAnchor constraintEqualToAnchor:container.bottomAnchor constant:-16]
        ]];
    }
}

@end 
