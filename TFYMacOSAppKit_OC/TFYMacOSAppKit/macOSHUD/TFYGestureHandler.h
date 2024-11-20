//
//  TFYGestureHandler.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TFYGestureHandlerDelegate;

/**
 * TFYGestureHandler
 * 手势处理器类，用于管理和处理视图的手势交互
 */
@interface TFYGestureHandler : NSObject

/// 手势处理代理
@property (nonatomic, weak) id<TFYGestureHandlerDelegate> delegate;
/// 是否启用手势
@property (nonatomic, assign) BOOL gesturesEnabled;

/**
 * 为视图设置手势识别
 *  view 目标视图
 */
- (void)setupGesturesForView:(NSView *)view;

/**
 * 添加点击手势
 *  view 目标视图
 */
- (void)addTapGestureToView:(NSView *)view;

/**
 * 添加滑动手势
 *  view 目标视图
 */
- (void)addSwipeGestureToView:(NSView *)view;

/**
 * 移除所有手势识别器
 */
- (void)removeAllGestureRecognizers;

/**
 * 清理资源
 */
- (void)cleanup;

@end

/**
 * TFYGestureHandlerDelegate
 * 手势处理器代理协议
 */
@protocol TFYGestureHandlerDelegate <NSObject>

@required
/**
 * 点击手势识别回调
 *  handler 手势处理器
 *  gesture 手势识别器
 */
- (void)gestureHandler:(TFYGestureHandler *)handler didRecognizeTapGesture:(NSGestureRecognizer *)gesture;

/**
 * 滑动手势识别回调
 *  handler 手势处理器
 *  gesture 手势识别器
 */
- (void)gestureHandler:(TFYGestureHandler *)handler didRecognizeSwipeGesture:(NSGestureRecognizer *)gesture;

@optional
/**
 * 是否应该响应点击手势
 *  handler 手势处理器
 *  gesture 手势识别器
 * @return 是否响应手势
 */
- (BOOL)gestureHandler:(TFYGestureHandler *)handler shouldRecognizeTapGesture:(NSGestureRecognizer *)gesture;

/**
 * 是否应该响应滑动手势
 *  handler 手势处理器
 *  gesture 手势识别器
 * @return 是否响应手势
 */
- (BOOL)gestureHandler:(TFYGestureHandler *)handler shouldRecognizeSwipeGesture:(NSGestureRecognizer *)gesture;

@end

NS_ASSUME_NONNULL_END 
