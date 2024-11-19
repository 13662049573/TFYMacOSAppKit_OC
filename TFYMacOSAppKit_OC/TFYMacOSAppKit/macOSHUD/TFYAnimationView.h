#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYAnimationView : NSView

@property (nonatomic, strong, nullable) NSTimer *animationTimer;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) NSTimeInterval animationDuration;

- (void)startAnimating;
- (void)stopAnimating;
- (void)cleanup;

@end

NS_ASSUME_NONNULL_END 