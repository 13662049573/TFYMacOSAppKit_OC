# TFYMacOSAppKit

[![Platform](https://img.shields.io/badge/platform-macOS-blue.svg)](https://github.com/13662049573/TFYMacOSAppKit)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/13662049573/TFYMacOSAppKit/blob/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/TFYMacOSAppKit.svg)](https://cocoapods.org/pods/TFYMacOSAppKit)
[![Support](https://img.shields.io/badge/support-macOS%2010.13+-blue.svg)](https://github.com/13662049573/TFYMacOSAppKit)

TFYMacOSAppKit 是一个功能丰富的 macOS 开发工具库，提供了大量实用的扩展和组件，帮助开发者更高效地构建 macOS 应用。本框架包含了大量 UI 控件的链式封装、实用工具类、自定义控件等，可以大大提升开发效率。

## 功能特性

### 1. 链式编程支持 (macOSchain)
- 支持 NSView、CALayer 等组件的链式调用
- 提供流畅的 API 接口,让代码更简洁优雅
- 支持手势识别、动画等链式操作
- 支持 Masonry 布局链式调用
- 支持各种 UI 控件的快速配置

### 2. 强大的分类扩展 (macOScategory) 
- NSView、NSButton、NSTextField 等控件扩展
- NSColor、NSImage 等工具类扩展
- NSString、NSArray、NSDictionary 等基础类扩展
- 提供大量实用方法简化开发
- 支持控件样式快速配置

### 3. 实用工具集合 (macOScontainer)
- GCD 任务队列管理(串行/并行/延时/定时)
- SQLite 数据库操作封装(增删改查/事务/多线程)
- 状态栏开发工具(图标/菜单/拖拽)
- 定时器封装(倒计时/循环执行)
- 文件选择器(单选/多选/自定义过滤)
- WKWebView 功能扩展
- 安全的文本输入框

### 4. Foundation 扩展 (macOSfoundation)
- 字符串处理(正则/编码/加密/格式化)
- 数组字典集合类扩展
- 文件管理(增删改查/移动/复制)
- 日期处理(格式化/计算/比较)
- 富文本属性字符串处理
- UserDefaults 数据存储
- 对象归档解档

### 5. HUD 提示框架 (macOSHUD)
- 优雅的加载提示
- 支持进度展示
- 可自定义动画效果
- 支持深色/浅色主题切换
- 支持成功/失败/警告等状态
- 支持自定义视图
- 支持手势交互

## 安装

### CocoaPods 安装
```ruby
# Podfile
platform :osx, '10.13'
use_frameworks!

target 'YourApp' do
    pod 'TFYMacOSAppKit'
end
```

然后运行:
```bash
pod install
```

### 手动安装
1. 下载 TFYMacOSAppKit 文件夹
2. 将其拖入到项目中
3. 在需要使用的地方导入头文件:
```objc
#import <TFYMacOSAppKit/TFYMacOSAppKit.h>
```

## 使用示例

### 链式调用示例
```objc
// 创建按钮
NSButton *button = NSButton.new;
button.tfy_makeChain
    .frame(CGRectMake(20, 20, 100, 30))
    .title(@"Click Me")
    .target(self)
    .action(@selector(buttonClicked:))
    .font([NSFont systemFontOfSize:14])
    .backgroundColor(NSColor.clearColor)
    .addToSuperView(self.view);

// 创建渐变图层
CAGradientLayer *gradientLayer = [CAGradientLayer tfy_colorGradientChangeWithSize:CGSizeMake(200, 200) 
                                                                       direction:GradientMacOsDirectionLeftToRight 
                                                                      colorsArr:@[NSColor.redColor, NSColor.blueColor]];

// 创建自定义按钮
TFYButton *customButton = TFYButton.new;
customButton.tfy_makeChain
    .frame(CGRectMake(20, 60, 120, 40))
    .title(@"Custom Button")
    .titleColor(NSColor.whiteColor, TFYControlStateNormal)
    .backgroundColor(NSColor.systemBlueColor, TFYControlStateNormal)
    .backgroundColor(NSColor.systemGrayColor, TFYControlStateHighlighted)
    .cornerRadius(20)
    .addToSuperView(self.view);
```

### HUD 使用示例
```objc
// 显示加载提示
[TFYProgressMacOSHUD showWithStatus:@"Loading..."];

// 显示进度
[TFYProgressMacOSHUD showProgress:0.5 status:@"Downloading..."];

// 显示成功提示
[TFYProgressMacOSHUD showSuccessWithStatus:@"Success!"];

// 显示错误提示
[TFYProgressMacOSHUD showErrorWithStatus:@"Error occurred"];

// 显示自定义图片
[TFYProgressMacOSHUD showImage:[NSImage imageNamed:@"custom"] status:@"Custom"];

// 延迟隐藏
[TFYProgressMacOSHUD dismissWithDelay:2.0];
```

### 工具类使用示例
```objc
// GCD 定时器
[TFYmacOSTimer countDownWithPER_SECBlock:^{
    // 每秒执行
}];

// SQLite 数据库操作
TFYmacOSSqlite *db = [TFYmacOSSqlite shareDatabase];
[db createTable:@"users" dictOrModel:@{@"name": @"TEXT", @"age": @"INTEGER"}];
[db insertTable:@"users" dictOrModel:@{@"name": @"John", @"age": @25}];

// 状态栏
TFYStatusItem *statusItem = [[TFYStatusItem alloc] init];
statusItem.image = [NSImage imageNamed:@"icon"];
statusItem.target = self;
statusItem.action = @selector(statusItemClicked:);

// 文件选择
[TFYOpenPanel showOpenPanelWithAllowedFileTypes:@[@"jpg", @"png"]
                              canChooseFiles:YES
                           canChooseDirectories:NO
                              allowsMultipleSelection:YES
                              completionHandler:^(NSArray<NSURL *> *urls) {
    // 处理选中的文件
}];
```

### Foundation 扩展示例
```objc
// 字符串处理
NSString *str = @"hello world";
BOOL hasPrefix = [str tfy_hasPrefix:@"he" caseSensitive:NO];
NSString *md5 = [str tfy_md5String];
NSString *base64 = [str tfy_base64Encode];

// 日期处理
NSDate *date = [NSDate date];
NSString *dateStr = [date tfy_stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
NSInteger days = [date tfy_daysFromDate:[NSDate date]];

// 文件操作
NSFileManager *fm = [NSFileManager defaultManager];
[fm tfy_createDirectoryAtPath:@"path/to/dir"];
NSArray *contents = [fm tfy_contentsOfDirectoryAtPath:@"path" deep:YES];
```

## 自定义控件

### TFYButton
- 支持设置不同状态下的背景色
- 支持设置圆角
- 支持设置边框
- 支持设置图文布局
- 支持点击事件回调

### TFYTextField
- 支持设置占位文字颜色
- 支持限制输入长度
- 支持自定义输入规则
- 支持文本改变回调

### TFYLabel
- 支持富文本点击
- 支持文本垂直对齐
- 支持自定义行间距
- 支持渐变文字

## 系统要求
- macOS 10.13+
- Xcode 12.0+
- Objective-C

## 更新日志

### 1.1.0
- 新增 HUD 提示框架
- 优化链式调用接口
- 修复已知问题

### 1.0.0 
- 首次发布
- 实现基础功能

## 许可证
TFYMacOSAppKit 基于 MIT 许可证开源。详见 LICENSE 文件。

## 联系方式
- 作者: 田风有
- Email: 13662049573@163.com
- GitHub: [https://github.com/13662049573/TFYMacOSAppKit](https://github.com/13662049573/TFYMacOSAppKit)

## 贡献
欢迎提交 Issue 和 Pull Request。如果你发现了 bug 或者有新功能的想法，欢迎提交 issue 讨论。

## 致谢
感谢所有为这个项目做出贡献的开发者。

## 相关项目
- [TFYCrashSDK](https://github.com/13662049573/TFYCrashSDK)
- [TFYProgressHUD](https://github.com/13662049573/TFYProgressHUD)
