//
//  TFYGestureHandler.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import "TFYGestureHandler.h"

@interface TFYGestureHandler ()

/// 点击手势识别器
@property (nonatomic, strong) NSClickGestureRecognizer *tapGesture;
/// 滑动手势识别器
@property (nonatomic, strong) NSPanGestureRecognizer *swipeGesture;
/// 目标视图
@property (nonatomic, weak) NSView *targetView;

@end

@implementation TFYGestureHandler

#pragma mark - 初始化方法

- (instancetype)init {
    self = [super init];
    if (self) {
        _gesturesEnabled = YES; // 默认启用手势
    }
    return self;
}

#pragma mark - 公共方法

- (void)setupGesturesForView:(NSView *)view {
    self.targetView = view;
    
    if (self.gesturesEnabled) {
        [self addTapGestureToView:view];
        [self addSwipeGestureToView:view];
    }
}

- (void)addTapGestureToView:(NSView *)view {
    // 移除已存在的点击手势
    if (self.tapGesture) {
        [view removeGestureRecognizer:self.tapGesture];
    }
    
    // 创建并添加新的点击手势
    self.tapGesture = [[NSClickGestureRecognizer alloc] initWithTarget:self 
                                                               action:@selector(handleTapGesture:)];
    [view addGestureRecognizer:self.tapGesture];
}

- (void)addSwipeGestureToView:(NSView *)view {
    // 移除已存在的滑动手势
    if (self.swipeGesture) {
        [view removeGestureRecognizer:self.swipeGesture];
    }
    
    // 创建并添加新的滑动手势
    self.swipeGesture = [[NSPanGestureRecognizer alloc] initWithTarget:self 
                                                               action:@selector(handleSwipeGesture:)];
    [view addGestureRecognizer:self.swipeGesture];
}

#pragma mark - 手势处理方法

- (void)handleTapGesture:(NSGestureRecognizer *)gesture {
    if (!self.gesturesEnabled) return;
    
    // 检查代理是否实现了点击手势回调方法
    if ([self.delegate respondsToSelector:@selector(gestureHandler:didRecognizeTapGesture:)]) {
        [self.delegate gestureHandler:self didRecognizeTapGesture:gesture];
    }
}

- (void)handleSwipeGesture:(NSPanGestureRecognizer *)gesture {
    if (!self.gesturesEnabled) return;
    
    if (gesture.state == NSGestureRecognizerStateEnded) {
        NSPoint velocity = [gesture velocityInView:self.targetView];
        
        // 检查是否是有效的滑动手势（速度阈值：500）
        if (fabs(velocity.x) > 500 || fabs(velocity.y) > 500) {
            if ([self.delegate respondsToSelector:@selector(gestureHandler:didRecognizeSwipeGesture:)]) {
                [self.delegate gestureHandler:self didRecognizeSwipeGesture:gesture];
            }
        }
    }
}

#pragma mark - 属性设置方法

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

#pragma mark - 清理方法

- (void)removeAllGestureRecognizers {
    if (self.targetView) {
        // 移除所有手势识别器
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
