#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TFYAnimationControllerDelegate;

@interface TFYAnimationController : NSObject

@property (nonatomic, weak) id<TFYAnimationControllerDelegate> delegate;

// 动画注册方法
- (void)registerAnimation:(CAAnimation *)animation forKey:(NSString *)key;
- (CAAnimation *)animationForKey:(NSString *)key;
- (void)removeAnimationForKey:(NSString *)key;

// 现有方法
- (void)setupDefaultAnimations;
- (void)setupCustomAnimationsWithDuration:(NSTimeInterval)duration;
- (void)performShowAnimationWithCompletion:(void (^)(void))completion;
- (void)performDismissAnimationWithCompletion:(void (^)(void))completion;
- (void)animateAppearanceWithDuration:(NSTimeInterval)duration 
                                view:(NSView *)view 
                   completionHandler:(void (^)(void))completion;
- (void)animateDisappearanceWithDuration:(NSTimeInterval)duration 
                                  view:(NSView *)view 
                     completionHandler:(void (^)(void))completion;
- (void)reduceAnimationComplexity;
- (void)cleanup;

// 动画更新方法
- (void)updateAnimations;
- (void)pauseAnimations;
- (void)resumeAnimations;

// 添加动画执行方法
- (void)executeAnimation:(CAAnimation *)animation 
                onLayer:(CALayer *)layer 
                withKey:(NSString *)key 
             completion:(nullable void(^)(BOOL finished))completion;

@end

@protocol TFYAnimationControllerDelegate <NSObject>
@optional
- (void)animationController:(TFYAnimationController *)controller willStartAnimation:(CAAnimation *)animation;
- (void)animationController:(TFYAnimationController *)controller didFinishAnimation:(CAAnimation *)animation;
@end

NS_ASSUME_NONNULL_END 
