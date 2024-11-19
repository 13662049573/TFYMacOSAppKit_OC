#import "TFYAnimationView.h"

@implementation TFYAnimationView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _animationDuration = 0.3;
        _isAnimating = NO;
        _animationTimer = nil;
    }
    return self;
}

- (void)startAnimating {
    if (self.isAnimating) return;
    
    self.isAnimating = YES;
    
    // 停止现有的定时器
    if (self.animationTimer) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
    
    // 创建新的定时器
    self.animationTimer = [NSTimer timerWithTimeInterval:1.0/30.0  // 30 FPS
                                                target:self
                                              selector:@selector(updateAnimation:)
                                              userInfo:nil
                                               repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.animationTimer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimating {
    self.isAnimating = NO;
    
    if (self.animationTimer) {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
}

- (void)updateAnimation:(NSTimer *)timer {
    if (!self.isAnimating) {
        [self stopAnimating];
        return;
    }
    
    [self setNeedsDisplay:YES];
}

- (void)cleanup {
    [self stopAnimating];
}

- (void)dealloc {
    [self cleanup];
}

@end 