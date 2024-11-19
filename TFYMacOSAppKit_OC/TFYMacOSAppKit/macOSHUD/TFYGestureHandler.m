#import "TFYGestureHandler.h"

@interface TFYGestureHandler ()

@property (nonatomic, strong) NSClickGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSPanGestureRecognizer *swipeGesture;
@property (nonatomic, weak) NSView *targetView;

@end

@implementation TFYGestureHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        _gesturesEnabled = YES;
    }
    return self;
}

- (void)setupGesturesForView:(NSView *)view {
    self.targetView = view;
    
    if (self.gesturesEnabled) {
        [self addTapGestureToView:view];
        [self addSwipeGestureToView:view];
    }
}

- (void)addTapGestureToView:(NSView *)view {
    if (self.tapGesture) {
        [view removeGestureRecognizer:self.tapGesture];
    }
    
    self.tapGesture = [[NSClickGestureRecognizer alloc] initWithTarget:self 
                                                               action:@selector(handleTapGesture:)];
    [view addGestureRecognizer:self.tapGesture];
}

- (void)addSwipeGestureToView:(NSView *)view {
    if (self.swipeGesture) {
        [view removeGestureRecognizer:self.swipeGesture];
    }
    
    self.swipeGesture = [[NSPanGestureRecognizer alloc] initWithTarget:self 
                                                               action:@selector(handleSwipeGesture:)];
    [view addGestureRecognizer:self.swipeGesture];
}

- (void)handleTapGesture:(NSGestureRecognizer *)gesture {
    if (!self.gesturesEnabled) return;
    
    if ([self.delegate respondsToSelector:@selector(gestureHandler:didRecognizeTapGesture:)]) {
        [self.delegate gestureHandler:self didRecognizeTapGesture:gesture];
    }
}

- (void)handleSwipeGesture:(NSPanGestureRecognizer *)gesture {
    if (!self.gesturesEnabled) return;
    
    if (gesture.state == NSGestureRecognizerStateEnded) {
        NSPoint velocity = [gesture velocityInView:self.targetView];
        
        // 检查是否是有效的滑动手势
        if (fabs(velocity.x) > 500 || fabs(velocity.y) > 500) {
            if ([self.delegate respondsToSelector:@selector(gestureHandler:didRecognizeSwipeGesture:)]) {
                [self.delegate gestureHandler:self didRecognizeSwipeGesture:gesture];
            }
        }
    }
}

- (void)setGesturesEnabled:(BOOL)gestures {
    _gesturesEnabled = gestures;
    
    if (self.targetView) {
        if (gestures) {
            [self addTapGestureToView:self.targetView];
            [self addSwipeGestureToView:self.targetView];
        } else {
            [self removeAllGestureRecognizers];
        }
    }
}

- (void)removeAllGestureRecognizers {
    if (self.targetView) {
        for (NSGestureRecognizer *recognizer in self.targetView.gestureRecognizers) {
            [self.targetView removeGestureRecognizer:recognizer];
        }
    }
    
    self.tapGesture = nil;
    self.swipeGesture = nil;
}

- (void)cleanup {
    [self removeAllGestureRecognizers];
    self.delegate = nil;
    self.targetView = nil;
}

- (void)dealloc {
    [self cleanup];
}

@end 