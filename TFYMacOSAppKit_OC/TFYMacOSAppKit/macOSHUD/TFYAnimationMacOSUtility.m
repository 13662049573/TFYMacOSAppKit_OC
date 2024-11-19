//
//  TFYAnimationMacOSUtility.m
//  AegisMacOsCommany
//
//  Created by apple on 2024/11/18.
//  Copyright © 2024 Aegis. All rights reserved.
//

#import "TFYAnimationMacOSUtility.h"

NSString *const kTFYFadeInAnimation = @"fadeIn";
NSString *const kTFYFadeOutAnimation = @"fadeOut";
NSString *const kTFYScaleInAnimation = @"scaleIn";
NSString *const kTFYScaleOutAnimation = @"scaleOut";
NSString *const kTFYShakeAnimation = @"shake";
NSString *const kTFYPulseAnimation = @"pulse";
NSString *const kTFYSuccessAnimation = @"success";
NSString *const kTFYErrorAnimation = @"error";

@implementation TFYAnimationMacOSUtility

static NSMutableDictionary *_animations = nil;

+ (void)initialize {
    if (self == [TFYAnimationMacOSUtility class]) {
        _animations = [NSMutableDictionary dictionary];
    }
}

+ (void)setupDefaultAnimations {
    // 淡入动画
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0;
    fadeIn.toValue = @1.0;
    fadeIn.duration = 0.3;
    [self registerAnimation:fadeIn forKey:kTFYFadeInAnimation];
    
    // 淡出动画
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.fromValue = @1.0;
    fadeOut.toValue = @0.0;
    fadeOut.duration = 0.3;
    [self registerAnimation:fadeOut forKey:kTFYFadeOutAnimation];
    
    // 缩放入场动画
    CABasicAnimation *scaleIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleIn.fromValue = @0.8;
    scaleIn.toValue = @1.0;
    scaleIn.duration = 0.3;
    [self registerAnimation:scaleIn forKey:kTFYScaleInAnimation];
    
    // 缩放出场动画
    CABasicAnimation *scaleOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleOut.fromValue = @1.0;
    scaleOut.toValue = @0.8;
    scaleOut.duration = 0.3;
    [self registerAnimation:scaleOut forKey:kTFYScaleOutAnimation];
    
    // 摇动动画
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.values = @[@0, @10, @-10, @10, @-5, @5, @-5, @0];
    shake.keyTimes = @[@0, @0.125, @0.25, @0.375, @0.5, @0.625, @0.75, @1.0];
    shake.duration = 0.4;
    [self registerAnimation:shake forKey:kTFYShakeAnimation];
    
    // 脉冲动画
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.fromValue = @1.0;
    pulse.toValue = @1.1;
    pulse.duration = 0.3;
    pulse.autoreverses = YES;
    pulse.repeatCount = HUGE_VALF;
    [self registerAnimation:pulse forKey:kTFYPulseAnimation];
}

+ (void)registerCustomAnimations {
    // 成功动画
    CAKeyframeAnimation *success = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    success.values = @[@1.0, @1.2, @0.9, @1.0];
    success.keyTimes = @[@0.0, @0.4, @0.6, @1.0];
    success.duration = 0.5;
    [self registerAnimation:success forKey:kTFYSuccessAnimation];
    
    // 错误动画
    CAKeyframeAnimation *error = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    error.values = @[@0, @(-M_PI_4/2), @(M_PI_4/2), @0];
    error.duration = 0.4;
    [self registerAnimation:error forKey:kTFYErrorAnimation];
    
    // 可以继续添加更多自定义动画...
}

+ (void)registerAnimation:(CAAnimation *)animation forKey:(NSString *)key {
    if (!animation || !key) return;
    _animations[key] = animation;
}

+ (CAAnimation *)animationForKey:(NSString *)key {
    return [_animations[key] copy];
}

+ (void)removeAnimationForKey:(NSString *)key {
    [_animations removeObjectForKey:key];
}

+ (void)cleanup {
    [_animations removeAllObjects];
}

@end
