//
//  TFYLayoutManager.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

@class TFYProgressMacOSHUD;

/**
 * 布局回调块定义
 *  hud HUD实例
 */
typedef void(^TFYLayoutBlock)(TFYProgressMacOSHUD *hud);

/**
 * TFYLayoutManager
 * 布局管理器类，负责管理HUD的布局和约束
 */
@interface TFYLayoutManager : NSObject

/**
 * 注册布局
 *  layout 布局回调块
 *  mode HUD显示模式
 */
- (void)registerLayout:(TFYLayoutBlock)layout forMode:(NSInteger)mode;

/**
 * 应用布局
 *  mode HUD显示模式
 *  hud 目标HUD实例
 */
- (void)applyLayoutForMode:(NSInteger)mode toHUD:(TFYProgressMacOSHUD *)hud;

/**
 * 设置HUD的基础约束
 *  hud 目标HUD实例
 */
- (void)setupHUDConstraints:(TFYProgressMacOSHUD *)hud;

/**
 * 设置HUD相对于父视图的约束
 *  hud 目标HUD实例
 */
- (void)setupConstraintsForHUD:(TFYProgressMacOSHUD *)hud;

/**
 * 设置HUD的自适应布局
 *  hud 目标HUD实例
 */
- (void)setupAdaptiveLayoutForHUD:(TFYProgressMacOSHUD *)hud;

/**
 * 设置HUD子视图的约束
 *  hud 目标HUD实例
 */
- (void)setupSubviewsConstraints:(TFYProgressMacOSHUD *)hud;

/**
 * 使当前布局失效
 */
- (void)invalidateLayout;

@end
