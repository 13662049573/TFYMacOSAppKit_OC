
//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//


#import "TFYAnimationEnhancer.h"
#import <QuartzCore/QuartzCore.h>

@implementation TFYAnimationEnhancer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureAnimationDefaults];
    }
    return self;
}

- (void)configureAnimationDefaults {
    self.duration = 0.3;
    self.springDamping = 0.7;
    self.initialSpringVelocity = 0.5;
    self.animationCurve = NSAnimationEaseInOut;
}

- (void)configureWithDuration:(CGFloat)duration
                springDamping:(CGFloat)springDamping
        initialSpringVelocity:(CGFloat)initialSpringVelocity
              animationCurve:(NSAnimationCurve)animationCurve {
    self.duration = duration;
    self.springDamping = springDamping;
    self.initialSpringVelocity = initialSpringVelocity;
    self.animationCurve = animationCurve;
}

- (void)addSuccessAnimation:(NSView *)view {
    // 缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@1.0, @1.2, @0.9, @1.0];
    scaleAnimation.keyTimes = @[@0.0, @0.4, @0.6, @1.0];
    scaleAnimation.duration = self.duration;
    
    // 旋转动画
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.values = @[@0, @(M_PI * 2)];
    rotateAnimation.keyTimes = @[@0.0, @1.0];
    rotateAnimation.duration = self.duration;
    
    // 组合动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[scaleAnimation, rotateAnimation];
    groupAnimation.duration = self.duration;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:groupAnimation forKey:@"successAnimation"];
}

- (void)addErrorAnimation:(NSView *)view {
    // 摇动动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAnimation.values = @[@0, @(-M_PI_4/2), @(M_PI_4/2), @0];
    shakeAnimation.keyTimes = @[@0.0, @0.3, @0.6, @1.0];
    shakeAnimation.duration = self.duration;
    
    // 缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@1.0, @1.1, @0.9, @1.0];
    scaleAnimation.keyTimes = @[@0.0, @0.3, @0.6, @1.0];
    scaleAnimation.duration = self.duration;
    
    // 组合动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[shakeAnimation, scaleAnimation];
    groupAnimation.duration = self.duration;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:groupAnimation forKey:@"errorAnimation"];
}

- (void)addShakeAnimation:(NSView *)view {
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnimation.values = @[@0, @(-10), @10, @(-5), @5, @0];
    shakeAnimation.keyTimes = @[@0.0, @0.2, @0.4, @0.6, @0.8, @1.0];
    shakeAnimation.duration = self.duration;
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:shakeAnimation forKey:@"shakeAnimation"];
}

- (void)addPulseAnimation:(NSView *)view {
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.fromValue = @1.0;
    pulseAnimation.toValue = @1.1;
    pulseAnimation.duration = self.duration;
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = HUGE_VALF;
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
}

- (void)setupWithView:(NSView *)view {
    view.wantsLayer = YES;
    view.layer.opacity = 0.0;
}

- (void)applyAnimationToView:(NSView *)view {
    view.layer.opacity = 1.0;
}

- (void)resetView:(NSView *)view {
    [view.layer removeAllAnimations];
    view.layer.opacity = 0.0;
}

@end 
