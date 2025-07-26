//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//


#import <Cocoa/Cocoa.h>

@class TFYProgressMacOSHUD;

NS_ASSUME_NONNULL_BEGIN

@interface TFYThemeManager : NSObject

@property (nonatomic, strong, readonly) NSDictionary *currentTheme;

- (void)setupDefaultTheme;
- (void)registerTheme:(NSDictionary *)theme forName:(NSString *)name;
- (NSDictionary *)themeForName:(NSString *)name;
- (void)applyTheme:(NSString *)themeName;
- (void)applyThemeToHUD:(TFYProgressMacOSHUD *)hud;
- (void)observeSystemThemeChanges;
- (void)cleanup;

@end

NS_ASSUME_NONNULL_END 
