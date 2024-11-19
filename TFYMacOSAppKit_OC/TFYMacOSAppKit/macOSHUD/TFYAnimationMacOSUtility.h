//
//  TFYAnimationMacOSUtility.h
//  AegisMacOsCommany
//
//  Created by apple on 2024/11/18.
//  Copyright © 2024 Aegis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYAnimationMacOSUtility : NSObject

+ (void)setupDefaultAnimations;
+ (void)registerCustomAnimations;
+ (CAAnimation *)animationForKey:(NSString *)key;
+ (void)registerAnimation:(CAAnimation *)animation forKey:(NSString *)key;
+ (void)removeAnimationForKey:(NSString *)key;
+ (void)cleanup;

// 预定义动画键
extern NSString *const kTFYFadeInAnimation;
extern NSString *const kTFYFadeOutAnimation;
extern NSString *const kTFYScaleInAnimation;
extern NSString *const kTFYScaleOutAnimation;
extern NSString *const kTFYShakeAnimation;
extern NSString *const kTFYPulseAnimation;
extern NSString *const kTFYSuccessAnimation;
extern NSString *const kTFYErrorAnimation;

@end

NS_ASSUME_NONNULL_END
