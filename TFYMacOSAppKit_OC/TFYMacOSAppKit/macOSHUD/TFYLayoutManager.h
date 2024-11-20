//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

@class TFYProgressMacOSHUD;

typedef void(^TFYLayoutBlock)(TFYProgressMacOSHUD *hud);

@interface TFYLayoutManager : NSObject

- (void)registerLayout:(TFYLayoutBlock)layout forMode:(NSInteger)mode;
- (void)applyLayoutForMode:(NSInteger)mode toHUD:(TFYProgressMacOSHUD *)hud;
- (void)setupHUDConstraints:(TFYProgressMacOSHUD *)hud;
- (void)setupConstraintsForHUD:(TFYProgressMacOSHUD *)hud;
- (void)setupAdaptiveLayoutForHUD:(TFYProgressMacOSHUD *)hud;
- (void)setupSubviewsConstraints:(TFYProgressMacOSHUD *)hud;
- (void)invalidateLayout;

@end
