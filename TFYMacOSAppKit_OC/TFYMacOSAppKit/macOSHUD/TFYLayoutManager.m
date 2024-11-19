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

- (void)setupHUDConstraints:(TFYProgressMacOSHUD *)hud {
    // 移除所有现有约束
    [self invalidateLayout];
    
    // 设置基本属性
    hud.translatesAutoresizingMaskIntoConstraints = NO;
    hud.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *allConstraints = [NSMutableArray array];
    NSView *container = hud.containerView;
    
    // 如果状态标签存在，添加与customImageView的约束
    if (hud.statusLabel) {
        [allConstraints addObjectsFromArray:@[
            [hud.statusLabel.topAnchor constraintEqualToAnchor:hud.customImageView.bottomAnchor constant:12]
        ]];
    }

    // 设置customImageView的约束
    [allConstraints addObjectsFromArray:@[
        [hud.customImageView.centerXAnchor constraintEqualToAnchor:container.centerXAnchor],
        [hud.customImageView.topAnchor constraintEqualToAnchor:container.topAnchor constant:20],
        [hud.customImageView.widthAnchor constraintEqualToConstant:32],
        [hud.customImageView.heightAnchor constraintEqualToConstant:32]
    ]];
   
    // 设置customImageView的约束
    [allConstraints addObjectsFromArray:@[
        [hud.progressView.centerXAnchor constraintEqualToAnchor:container.centerXAnchor],
        [hud.progressView.topAnchor constraintEqualToAnchor:container.topAnchor constant:20],
        [hud.progressView.widthAnchor constraintEqualToConstant:40],
        [hud.progressView.heightAnchor constraintEqualToConstant:40]
    ]];

    [allConstraints addObjectsFromArray:@[
        // 容器视图居中
        [container.centerXAnchor constraintEqualToAnchor:hud.centerXAnchor],
        [container.centerYAnchor constraintEqualToAnchor:hud.centerYAnchor],
        
        // 容器视图最小尺寸
        [container.widthAnchor constraintGreaterThanOrEqualToConstant:120],
        [container.heightAnchor constraintGreaterThanOrEqualToConstant:120],
        
        // 容器视图内边距
        [container.leadingAnchor constraintGreaterThanOrEqualToAnchor:hud.leadingAnchor constant:40],
        [container.trailingAnchor constraintLessThanOrEqualToAnchor:hud.trailingAnchor constant:-40]
    ]];
   
    
    // 设置活动指示器约束
    [allConstraints addObjectsFromArray:@[
        [hud.activityIndicator.centerXAnchor constraintEqualToAnchor:container.centerXAnchor],
        [hud.activityIndicator.topAnchor constraintEqualToAnchor:container.topAnchor constant:20],
        [hud.activityIndicator.widthAnchor constraintEqualToConstant:32],
        [hud.activityIndicator.heightAnchor constraintEqualToConstant:32]
    ]];
    
    // 设置状态标签约束
    [allConstraints addObjectsFromArray:@[
        [hud.statusLabel.topAnchor constraintEqualToAnchor:hud.activityIndicator.bottomAnchor constant:12],
        [hud.statusLabel.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:16],
        [hud.statusLabel.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-16],
        [hud.statusLabel.bottomAnchor constraintEqualToAnchor:container.bottomAnchor constant:-16]
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
    
    [self setupDefaultConstraints:hud constraints:constraints];
    // 激活约束
    [NSLayoutConstraint activateConstraints:constraints];
    [self.activeConstraints addObjectsFromArray:constraints];
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
