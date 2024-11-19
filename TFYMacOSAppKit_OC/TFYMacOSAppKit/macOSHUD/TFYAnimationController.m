#import "TFYAnimationController.h"

@interface TFYAnimationController () <CAAnimationDelegate>

@property (nonatomic, strong) NSMutableDictionary *animations;
@property (nonatomic, copy) void (^currentCompletionHandler)(void);
@property (nonatomic, assign) BOOL isReducedComplexity;
@property (nonatomic, weak) NSView *currentView;
@property (nonatomic, strong) NSMutableDictionary<NSString *, void(^)(BOOL)> *completionBlocks;
@property (nonatomic, strong) NSMutableSet<CALayer *> *animatingLayers;

@end

@implementation TFYAnimationController

- (instancetype)init {
    self = [super init];
    if (self) {
        _animations = [NSMutableDictionary dictionary];
        _isReducedComplexity = NO;
        _completionBlocks = [NSMutableDictionary dictionary];
        _animatingLayers = [NSMutableSet set];
    }
    return self;
}

#pragma mark - Animation Registration

- (void)registerAnimation:(CAAnimation *)animation forKey:(NSString *)key {
    if (!animation || !key) return;
    
    // 创建动画的深拷贝
    CAAnimation *copiedAnimation = [animation copy];
    self.animations[key] = copiedAnimation;
}

- (CAAnimation *)animationForKey:(NSString *)key {
    // 返回动画的拷贝，以防止外部修改
    return [self.animations[key] copy];
}

- (void)removeAnimationForKey:(NSString *)key {
    [self.animations removeObjectForKey:key];
}

- (void)setupDefaultAnimations {
    // 显示动画
    CAAnimationGroup *showAnimation = [CAAnimationGroup animation];
    
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0;
    fadeIn.toValue = @1.0;
    
    CABasicAnimation *scaleIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleIn.fromValue = @0.8;
    scaleIn.toValue = @1.0;
    
    showAnimation.animations = @[fadeIn, scaleIn];
    showAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self registerAnimation:showAnimation forKey:@"showAnimation"];
    
    // 隐藏动画
    CAAnimationGroup *hideAnimation = [CAAnimationGroup animation];
    
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.fromValue = @1.0;
    fadeOut.toValue = @0.0;
    
    CABasicAnimation *scaleOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleOut.fromValue = @1.0;
    scaleOut.toValue = @0.8;
    
    hideAnimation.animations = @[fadeOut, scaleOut];
    hideAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self registerAnimation:hideAnimation forKey:@"hideAnimation"];
}

- (void)setupCustomAnimationsWithDuration:(NSTimeInterval)duration {
    [self.animations enumerateKeysAndObjectsUsingBlock:^(NSString *key, CAAnimation *animation, BOOL *stop) {
        animation.duration = duration;
    }];
}

- (void)animateAppearanceWithDuration:(NSTimeInterval)duration 
                                view:(NSView *)view 
                   completionHandler:(void (^)(void))completion {
    if (!view) return;
    
    view.wantsLayer = YES;
    self.currentCompletionHandler = completion;
    
    if (self.isReducedComplexity) {
        // 简化动画
        CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeIn.fromValue = @0.0;
        fadeIn.toValue = @1.0;
        fadeIn.duration = duration;
        fadeIn.delegate = self;
        
        view.alphaValue = 1.0;
        [view.layer addAnimation:fadeIn forKey:@"fadeIn"];
    } else {
        // 完整动画
        CAAnimationGroup *animation = [self.animations[@"show"] copy];
        animation.duration = duration;
        animation.delegate = self;
        
        view.alphaValue = 1.0;
        [view.layer addAnimation:animation forKey:@"showAnimation"];
    }
    
    if ([self.delegate respondsToSelector:@selector(animationController:willStartAnimation:)]) {
        [self.delegate animationController:self willStartAnimation:self.animations[@"show"]];
    }
}

- (void)animateDisappearanceWithDuration:(NSTimeInterval)duration 
                                  view:(NSView *)view 
                     completionHandler:(void (^)(void))completion {
    if (!view) return;
    
    view.wantsLayer = YES;
    self.currentCompletionHandler = completion;
    
    if (self.isReducedComplexity) {
        // 简化动画
        CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeOut.fromValue = @1.0;
        fadeOut.toValue = @0.0;
        fadeOut.duration = duration;
        fadeOut.delegate = self;
        
        view.alphaValue = 0.0;
        [view.layer addAnimation:fadeOut forKey:@"fadeOut"];
    } else {
        // 完整动画
        CAAnimationGroup *animation = [self.animations[@"hide"] copy];
        animation.duration = duration;
        animation.delegate = self;
        
        view.alphaValue = 0.0;
        [view.layer addAnimation:animation forKey:@"hideAnimation"];
    }
    
    if ([self.delegate respondsToSelector:@selector(animationController:willStartAnimation:)]) {
        [self.delegate animationController:self willStartAnimation:self.animations[@"hide"]];
    }
}

#pragma mark - Enhanced Animation Methods

- (void)performShowAnimationWithCompletion:(void (^)(void))completion {
    if (!self.currentView) return;
    
    CAAnimationGroup *showAnimation = [CAAnimationGroup animation];
    showAnimation.duration = 0.3;
    
    // 淡入动画
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0;
    fadeIn.toValue = @1.0;
    
    // 缩放动画
    CABasicAnimation *scaleIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleIn.fromValue = @0.8;
    scaleIn.toValue = @1.0;
    
    showAnimation.animations = @[fadeIn, scaleIn];
    showAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    showAnimation.delegate = self;
    
    self.currentCompletionHandler = completion;
    self.currentView.alphaValue = 1.0;
    [self.currentView.layer addAnimation:showAnimation forKey:@"showAnimation"];
    
    if ([self.delegate respondsToSelector:@selector(animationController:willStartAnimation:)]) {
        [self.delegate animationController:self willStartAnimation:showAnimation];
    }
}

- (void)performDismissAnimationWithCompletion:(void (^)(void))completion {
    if (!self.currentView) return;
    
    CAAnimationGroup *dismissAnimation = [CAAnimationGroup animation];
    dismissAnimation.duration = 0.3;
    
    // 淡出动画
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.fromValue = @1.0;
    fadeOut.toValue = @0.0;
    
    // 缩放动画
    CABasicAnimation *scaleOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleOut.fromValue = @1.0;
    scaleOut.toValue = @0.8;
    
    dismissAnimation.animations = @[fadeOut, scaleOut];
    dismissAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    dismissAnimation.delegate = self;
    
    self.currentCompletionHandler = completion;
    self.currentView.alphaValue = 0.0;
    [self.currentView.layer addAnimation:dismissAnimation forKey:@"dismissAnimation"];
    
    if ([self.delegate respondsToSelector:@selector(animationController:willStartAnimation:)]) {
        [self.delegate animationController:self willStartAnimation:dismissAnimation];
    }
}

#pragma mark - Utility Methods

- (void)reduceAnimationComplexity {
    self.isReducedComplexity = YES;
    // 简化动画设置
    [self.animations enumerateKeysAndObjectsUsingBlock:^(NSString *key, CAAnimation *animation, BOOL *stop) {
        animation.duration *= 0.8;
        if ([animation isKindOfClass:[CAAnimationGroup class]]) {
            CAAnimationGroup *group = (CAAnimationGroup *)animation;
            group.animations = @[group.animations.firstObject];
        }
    }];
}

- (void)cleanup {
    [self.currentView.layer removeAllAnimations];
    self.currentView = nil;
    self.currentCompletionHandler = nil;
    [self.animations removeAllObjects];
}

#pragma mark - Animation Updates

- (void)updateAnimations {
    // 更新所有活动的动画
    [self.animations enumerateKeysAndObjectsUsingBlock:^(NSString *key, CAAnimation *animation, BOOL *stop) {
        if ([animation isKindOfClass:[CABasicAnimation class]]) {
            [self updateBasicAnimation:(CABasicAnimation *)animation];
        } else if ([animation isKindOfClass:[CAKeyframeAnimation class]]) {
            [self updateKeyframeAnimation:(CAKeyframeAnimation *)animation];
        }
    }];
}

- (void)updateBasicAnimation:(CABasicAnimation *)animation {
    // 更新基本动画
    if (self.isReducedComplexity) {
        animation.duration *= 0.8;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    }
}

- (void)updateKeyframeAnimation:(CAKeyframeAnimation *)animation {
    // 更新关键帧动画
    if (self.isReducedComplexity) {
        animation.duration *= 0.8;
        animation.calculationMode = kCAAnimationLinear;
    }
}

- (void)pauseAnimations {
    // 暂停所有动画
    CFTimeInterval pausedTime = [self.currentView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.currentView.layer.speed = 0.0;
    self.currentView.layer.timeOffset = pausedTime;
}

- (void)resumeAnimations {
    // 恢复所有动画
    CFTimeInterval pausedTime = self.currentView.layer.timeOffset;
    self.currentView.layer.speed = 1.0;
    self.currentView.layer.timeOffset = 0.0;
    self.currentView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.currentView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.currentView.layer.beginTime = timeSincePause;
}

- (void)executeAnimation:(CAAnimation *)animation 
                onLayer:(CALayer *)layer 
                withKey:(NSString *)key 
             completion:(void(^)(BOOL finished))completion {
    if (!animation || !layer || !key) return;
    
    // 存储完成回调
    if (completion) {
        self.completionBlocks[key] = completion;
    }
    
    // 设置动画代理
    animation.delegate = self;
    
    // 记录正在动画的图层
    [self.animatingLayers addObject:layer];
    
    // 在主线程执行动画
    dispatch_async(dispatch_get_main_queue(), ^{
        [layer addAnimation:animation forKey:key];
    });
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(animationController:willStartAnimation:)]) {
        [self.delegate animationController:self willStartAnimation:animation];
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    // 查找对应的key和layer
    NSString *keyToRemove = nil;
    CALayer *layerToRemove = nil;
    
    for (CALayer *layer in self.animatingLayers) {
        for (NSString *key in [layer animationKeys]) {
            if ([layer animationForKey:key] == animation) {
                keyToRemove = key;
                layerToRemove = layer;
                break;
            }
        }
        if (keyToRemove) break;
    }
    
    // 执行完成回调
    void(^completion)(BOOL) = self.completionBlocks[keyToRemove];
    if (completion) {
        completion(flag);
        [self.completionBlocks removeObjectForKey:keyToRemove];
    }
    
    // 移除记录
    if (layerToRemove) {
        [self.animatingLayers removeObject:layerToRemove];
    }
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(animationController:didFinishAnimation:)]) {
        [self.delegate animationController:self didFinishAnimation:animation];
    }
    
    if (flag && self.currentCompletionHandler) {
        self.currentCompletionHandler();
        self.currentCompletionHandler = nil;
    }
}

- (void)dealloc {
    [self.completionBlocks removeAllObjects];
    [self.animatingLayers removeAllObjects];
}

@end 
