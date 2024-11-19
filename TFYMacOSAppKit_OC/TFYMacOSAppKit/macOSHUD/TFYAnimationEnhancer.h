//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYAnimationEnhancer : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat springDamping;
@property (nonatomic, assign) CGFloat initialSpringVelocity;
@property (nonatomic, assign) NSAnimationCurve animationCurve;

- (void)configureAnimationDefaults;
- (void)configureWithDuration:(CGFloat)duration
                springDamping:(CGFloat)springDamping
        initialSpringVelocity:(CGFloat)initialSpringVelocity
              animationCurve:(NSAnimationCurve)animationCurve;

- (void)setupWithView:(NSView *)view;
- (void)applyAnimationToView:(NSView *)view;
- (void)resetView:(NSView *)view;

- (void)addSuccessAnimation:(NSView *)view;
- (void)addErrorAnimation:(NSView *)view;
- (void)addShakeAnimation:(NSView *)view;
- (void)addPulseAnimation:(NSView *)view;

@end

NS_ASSUME_NONNULL_END 
