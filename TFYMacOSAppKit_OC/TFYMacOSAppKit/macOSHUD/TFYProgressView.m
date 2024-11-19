





#import "TFYProgressView.h"

@interface TFYProgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, assign) CGFloat lastProgress;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, copy) void(^completionBlock)(void);

@end

@implementation TFYProgressView

#pragma mark - 初始化

- (instancetype)initWithStyle:(TFYProgressViewStyle)style {
    self = [super initWithFrame:NSZeroRect];
    if (self) {
        _style = style;
        _progress = 0.0;
        _animated = YES;
        _animationDuration = 0.3;
        _lineWidth = 3.0;
        _progressColor = [NSColor systemBlueColor];
        _trackColor = [NSColor lightGrayColor];
        _timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _style = TFYProgressViewStyleRing;
        _progress = 0.0;
        _animated = YES;
        _animationDuration = 0.3;
        _lineWidth = 2.0;
        _progressColor = [NSColor systemBlueColor];
        _trackColor = [NSColor lightGrayColor];
        _timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.wantsLayer = YES;
    
    // 创建轨道层
    self.trackLayer = [CAShapeLayer layer];
    self.trackLayer.fillColor = NSColor.clearColor.CGColor;
    self.trackLayer.strokeColor = self.trackColor.CGColor;
    self.trackLayer.lineWidth = self.lineWidth;
    [self.layer addSublayer:self.trackLayer];
    
    // 创建进度层
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = NSColor.clearColor.CGColor;
    self.progressLayer.strokeColor = self.progressColor.CGColor;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.strokeEnd = 0.0;
    [self.layer addSublayer:self.progressLayer];
    
    [self updatePaths];
}

#pragma mark - 布局

- (void)layout {
    [super layout];
    [self updatePaths];
}

- (void)updatePaths {
    CGRect bounds = self.bounds;
    CGPoint center = CGPointMake(NSMidX(bounds), NSMidY(bounds));
    CGFloat radius = MIN(NSWidth(bounds), NSHeight(bounds)) / 2 - self.lineWidth;
    switch (self.style) {
        case TFYProgressViewStyleRing: {
            CGPathRef circlePath = CGPathCreateWithEllipseInRect(
                CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2),
                NULL
            );
            self.trackLayer.path = circlePath;
            self.progressLayer.path = circlePath;
            CGPathRelease(circlePath);
            break;
        }
        case TFYProgressViewStyleHorizontal: {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, NSMinX(bounds), NSMidY(bounds));
            CGPathAddLineToPoint(path, NULL, NSMaxX(bounds), NSMidY(bounds));
            self.trackLayer.path = path;
            self.progressLayer.path = path;
            CGPathRelease(path);
            break;
        }
        default:
            break;
    }
}

#pragma mark - 进度控制

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:self.animated];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [self setProgress:progress animated:animated completion:nil];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated completion:(void(^)(void))completion {
    // 确保进度值在有效范围内
    progress = MIN(1.0, MAX(0.0, progress));
    if (_progress == progress) {
        if (completion) completion();
        return;
    }
    self.lastProgress = _progress;
    _progress = progress;
    self.completionBlock = completion;
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(self.lastProgress);
        animation.toValue = @(progress);
        animation.duration = self.animationDuration;
        animation.timingFunction = self.timingFunction;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        
        CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        colorAnimation.fromValue = (__bridge id)self.progressColor.CGColor;
        colorAnimation.toValue = (__bridge id)self.progressColor.CGColor;
        colorAnimation.duration = self.animationDuration;
        
        [self.progressLayer addAnimation:animation forKey:@"progressAnimation"];
        [self.progressLayer addAnimation:colorAnimation forKey:@"colorAnimation"];
        
        // 设置定时器在动画完成时调用完成回调
        [self.animationTimer invalidate];
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration
                                                             target:self
                                                           selector:@selector(animationDidComplete)
                                                           userInfo:nil
                                                            repeats:NO];
    } else {
        self.progressLayer.strokeEnd = progress;
        if (completion) completion();
    }
}

- (void)animationDidComplete {
    if (self.completionBlock) {
        self.completionBlock();
        self.completionBlock = nil;
    }
}

#pragma mark - 属性设置

- (void)setStyle:(TFYProgressViewStyle)style animated:(BOOL)animated {
    if (_style == style) return;
    
    _style = style;
    
    if (animated) {
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = self.animationDuration;
            context.timingFunction = self.timingFunction;
            [self updatePaths];
        }];
    } else {
        [self updatePaths];
    }
}

- (void)setProgressColor:(NSColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setTrackColor:(NSColor *)trackColor {
    _trackColor = trackColor;
    self.trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.trackLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
    [self updatePaths];
}

#pragma mark - 清理

- (void)dealloc {
    [self.animationTimer invalidate];
}

@end 
