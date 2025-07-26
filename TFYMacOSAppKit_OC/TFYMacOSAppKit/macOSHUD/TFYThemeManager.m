//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//


#import "TFYThemeManager.h"
#import "TFYProgressMacOSHUD.h"
#import <CoreImage/CoreImage.h>
@interface TFYThemeManager ()

@property (nonatomic, strong) NSMutableDictionary *themes;
@property (nonatomic, strong, readwrite) NSDictionary *currentTheme;
@property (nonatomic, weak) TFYProgressMacOSHUD *currentHUD;

@end

@implementation TFYThemeManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _themes = [NSMutableDictionary dictionary];
        [self setupDefaultTheme];
    }
    return self;
}

- (void)setupDefaultTheme {
    // 注册默认亮色主题
    [self registerTheme:[self defaultLightTheme] forName:@"light"];
    
    // 注册默认暗色主题
    [self registerTheme:[self defaultDarkTheme] forName:@"dark"];
    
    // 设置初始主题
    [self applyTheme:@"light"];
}

- (NSDictionary *)defaultLightTheme {
    return @{
        @"backgroundColor": [NSColor colorWithWhite:0.0 alpha:0.35],
        @"containerBackgroundColor": [NSColor colorWithWhite:0.95 alpha:1.0],
        @"textColor": [NSColor blackColor],
        @"progressColor": [NSColor systemBlueColor],
        @"successColor": [NSColor systemGreenColor],
        @"errorColor": [NSColor systemRedColor],
        @"shadowColor": [NSColor colorWithWhite:0 alpha:0.1],
        @"borderColor": [NSColor colorWithWhite:0.8 alpha:1.0],
        @"cornerRadius": @10.0,
        @"borderWidth": @1.0,
        @"shadowRadius": @20.0,
        @"shadowOpacity": @0.2,
        @"blurEffect": @"light"
    };
}

- (NSDictionary *)defaultDarkTheme {
    return @{
        @"backgroundColor": [NSColor colorWithWhite:0.0 alpha:0.35],
        @"containerBackgroundColor": [NSColor colorWithWhite:0.2 alpha:1.0],
        @"textColor": [NSColor whiteColor],
        @"progressColor": [NSColor systemBlueColor],
        @"successColor": [NSColor systemGreenColor],
        @"errorColor": [NSColor systemRedColor],
        @"shadowColor": [NSColor colorWithWhite:0 alpha:0.3],
        @"borderColor": [NSColor colorWithWhite:0.3 alpha:1.0],
        @"cornerRadius": @10.0,
        @"borderWidth": @1.0,
        @"shadowRadius": @20.0,
        @"shadowOpacity": @0.4,
        @"blurEffect": @"dark"
    };
}

- (void)registerTheme:(NSDictionary *)theme forName:(NSString *)name {
    if (theme && name) {
        self.themes[name] = theme;
    }
}

- (NSDictionary *)themeForName:(NSString *)name {
    return self.themes[name];
}

- (void)applyTheme:(NSString *)themeName {
    NSDictionary *theme = [self themeForName:themeName];
    if (theme) {
        self.currentTheme = theme;
        if (self.currentHUD) {
            [self applyThemeToHUD:self.currentHUD];
        }
    }
}

- (void)applyThemeToHUD:(TFYProgressMacOSHUD *)hud {
    if (!hud || !self.currentTheme) return;
    
    self.currentHUD = hud;
    
    // 配置主视图
    hud.wantsLayer = YES;
    hud.layer.backgroundColor = [self.currentTheme[@"backgroundColor"] CGColor];
    
    // 配置容器视图
    hud.containerView.wantsLayer = YES;
    hud.containerView.layer.backgroundColor = [self.currentTheme[@"containerBackgroundColor"] CGColor];
    
    // 使用安全的类型转换
    NSNumber *cornerRadius = self.currentTheme[@"cornerRadius"];
    NSNumber *borderWidth = self.currentTheme[@"borderWidth"];
    NSNumber *shadowRadius = self.currentTheme[@"shadowRadius"];
    NSNumber *shadowOpacity = self.currentTheme[@"shadowOpacity"];
    
    if ([cornerRadius isKindOfClass:[NSNumber class]]) {
        hud.containerView.layer.cornerRadius = cornerRadius.doubleValue;
    }
    
    if ([borderWidth isKindOfClass:[NSNumber class]]) {
        hud.containerView.layer.borderWidth = borderWidth.doubleValue;
    }
    
    NSColor *borderColor = self.currentTheme[@"borderColor"];
    if ([borderColor isKindOfClass:[NSColor class]]) {
        hud.containerView.layer.borderColor = borderColor.CGColor;
    }
    
    // 配置阴影
    NSColor *shadowColor = self.currentTheme[@"shadowColor"];
    if ([shadowColor isKindOfClass:[NSColor class]]) {
        hud.containerView.layer.shadowColor = shadowColor.CGColor;
    }
    
    if ([shadowRadius isKindOfClass:[NSNumber class]]) {
        hud.containerView.layer.shadowRadius = shadowRadius.doubleValue;
    }
    
    if ([shadowOpacity isKindOfClass:[NSNumber class]]) {
        hud.containerView.layer.shadowOpacity = shadowOpacity.floatValue;
    }
    
    hud.containerView.layer.shadowOffset = NSMakeSize(0, -3);
    
    // 配置文本颜色
    NSColor *textColor = self.currentTheme[@"textColor"];
    if ([textColor isKindOfClass:[NSColor class]]) {
        hud.statusLabel.textColor = textColor;
    }
    
    // 配置进度指示器颜色
    NSColor *progressColor = self.currentTheme[@"progressColor"];
    if ([progressColor isKindOfClass:[NSColor class]]) {
        hud.progressView.progressColor = progressColor;
    }
}

- (void)observeSystemThemeChanges {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(handleSystemThemeChange:)
                                                          name:@"AppleInterfaceThemeChangedNotification"
                                                        object:nil];
}

- (void)handleSystemThemeChange:(NSNotification *)notification {
    NSString *themeName = [NSApp.effectiveAppearance.name containsString:@"Dark"] ? @"dark" : @"light";
    [self applyTheme:themeName];
}

- (void)cleanup {
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
    self.themes = nil;
    self.currentTheme = nil;
    self.currentHUD = nil;
}

- (void)dealloc {
    [self cleanup];
}

@end 
