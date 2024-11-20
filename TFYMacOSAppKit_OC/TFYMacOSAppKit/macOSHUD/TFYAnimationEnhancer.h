//
//  TFYAnimationEnhancer.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * TFYAnimationEnhancer
 * 动画增强器类，用于管理和执行视图动画
 */
@interface TFYAnimationEnhancer : NSObject

/// 动画持续时间
@property (nonatomic, assign) CGFloat duration;
/// 弹簧阻尼系数 (0-1)，值越小弹性越大
@property (nonatomic, assign) CGFloat springDamping;
/// 初始弹簧速度
@property (nonatomic, assign) CGFloat initialSpringVelocity;
/// 动画曲线类型
@property (nonatomic, assign) NSAnimationCurve animationCurve;

/**
 * 配置动画默认参数
 */
- (void)configureAnimationDefaults;

/**
 * 配置动画参数
 *  duration 动画持续时间
 *  springDamping 弹簧阻尼系数
 *  initialSpringVelocity 初始弹簧速度
 *  animationCurve 动画曲线类型
 */
- (void)configureWithDuration:(CGFloat)duration
                springDamping:(CGFloat)springDamping
        initialSpringVelocity:(CGFloat)initialSpringVelocity
              animationCurve:(NSAnimationCurve)animationCurve;

/**
 * 为视图设置初始状态
 *  view 目标视图
 */
- (void)setupWithView:(NSView *)view;

/**
 * 为视图应用动画效果
 *  view 目标视图
 */
- (void)applyAnimationToView:(NSView *)view;

/**
 * 重置视图状态
 *  view 目标视图
 */
- (void)resetView:(NSView *)view;

/**
 * 添加成功动画效果
 *  view 目标视图
 */
- (void)addSuccessAnimation:(NSView *)view;

/**
 * 添加错误动画效果
 *  view 目标视图
 */
- (void)addErrorAnimation:(NSView *)view;

/**
 * 添加摇动动画效果
 *  view 目标视图
 */
- (void)addShakeAnimation:(NSView *)view;

/**
 * 添加脉冲动画效果
 *  view 目标视图
 */
- (void)addPulseAnimation:(NSView *)view;

@end

NS_ASSUME_NONNULL_END 
