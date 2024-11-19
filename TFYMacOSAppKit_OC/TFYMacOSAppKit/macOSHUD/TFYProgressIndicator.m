//
//  TFYProgressIndicator.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import "TFYProgressIndicator.h"
#import <CoreImage/CoreImage.h>

@implementation TFYProgressIndicator

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProgressIndicator];
    }
    return self;
}

- (void)setupProgressIndicator {
    // 创建进度指示器
    self.progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSZeroRect];
    self.progressIndicator.style = NSProgressIndicatorStyleSpinning;
    self.progressIndicator.controlSize = NSControlSizeRegular;
    self.progressIndicator.wantsLayer = YES;
    
    [self addSubview:self.progressIndicator];
    
    // 设置约束
    self.progressIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.progressIndicator.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.progressIndicator.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.progressIndicator.widthAnchor constraintEqualToConstant:30],
        [self.progressIndicator.heightAnchor constraintEqualToConstant:30]
    ]];
}

- (void)setColor:(NSColor *)color {
    _tintColor = color;
    
    // 方法1：使用 Core Image 滤镜
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [colorFilter setDefaults];
    [colorFilter setValue:[[CIColor alloc] initWithColor:color] forKey:@"inputColor"];
    [colorFilter setValue:@1.0 forKey:@"inputIntensity"];
    self.progressIndicator.contentFilters = @[colorFilter];
    
    // 方法2：尝试直接设置层属性
    self.progressIndicator.layer.backgroundColor = NSColor.clearColor.CGColor;
    
    // 方法3：根据颜色设置外观
    CGFloat brightness = 0;
    [[color colorUsingColorSpace:NSColorSpace.sRGBColorSpace] getHue:NULL saturation:NULL brightness:&brightness alpha:NULL];
    if (brightness > 0.5) {
        self.progressIndicator.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    } else {
        self.progressIndicator.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
    }
}

- (void)startAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressIndicator startAnimation:nil];
    });
}

- (void)stopAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressIndicator stopAnimation:nil];
    });
}

@end

