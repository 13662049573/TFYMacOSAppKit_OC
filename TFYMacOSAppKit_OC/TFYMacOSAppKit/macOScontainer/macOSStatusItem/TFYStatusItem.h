//
//  TFYStatusItem.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import <Foundation/Foundation.h>
#import "TFYStatusItemWindowConfiguration.h"

@class TFYStatusItem;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TFYStatusItemPresentationMode) {
    TFYStatusItemPresentationModeUndefined = 0,
    TFYStatusItemPresentationModeImage,
    TFYStatusItemPresentationModeCustomView
};
typedef NS_ENUM(NSInteger, TFYStatusItemProximityDragStatus) {
    TFYProximityDragStatusEntered = 0,
    TFYProximityDragStatusExited
};

typedef void (^TFYStatusItemDropHandler)(TFYStatusItem *sharedItem, NSString *pasteboardType, NSArray *droppedObjects);
typedef void (^TFYStatusItemProximityDragDetectionHandler)(TFYStatusItem *sharedItem, NSPoint eventLocation, TFYStatusItemProximityDragStatus proxymityDragStatus);
typedef BOOL (^TFYStatusItemShouldShowHandler)(TFYStatusItem *sharedItem);

@interface TFYStatusItem : NSObject

#pragma mark - Initialization

+ (instancetype)sharedInstance;

#pragma mark - 创建并显示StatusBarItem

/**
 为弹出窗口显示共享的' CCNStatusItem '对象和给定的图像和contentViewController。

 itemImage  图像显示在状态栏项中。该映像自动成为模板映像。
 contentViewController 在弹出窗口中显示的contentViewController。
 */
- (void)presentStatusItemWithImage:(NSImage *)itemImage contentViewController:(NSViewController *)contentViewController;

/**
 为弹出窗口显示共享的' CCNStatusItem '对象和给定的图像和contentViewController。

 itemImage             图像显示在状态栏项中。该映像自动成为模板映像。
 contentViewController 在弹出窗口中显示的contentViewController。
 dropHandler          在状态栏项上发生拖拽时调用的处理程序。
 */
- (void)presentStatusItemWithImage:(NSImage *)itemImage contentViewController:(NSViewController *)contentViewController dropHandler:(nullable TFYStatusItemDropHandler)dropHandler;

/**
 用给定的自定义视图和弹出窗口的contentViewController显示共享的“CCNStatusItem”对象。

 itemView             显示为状态项视图的视图。
 contentViewController 在弹出窗口中显示的contentViewController。
 */
- (void)presentStatusItemWithView:(NSView *)itemView contentViewController:(NSViewController *)contentViewController;

/**
 用给定的自定义视图和弹出窗口的contentViewController显示共享的“CCNStatusItem”对象。

 itemView             显示为状态项视图的视图。
 contentViewController 在弹出窗口中显示的contentViewController。
 dropHandler          在状态栏项上发生拖拽时调用的处理程序。
 */
- (void)presentStatusItemWithView:(NSView *)itemView contentViewController:(NSViewController *)contentViewController dropHandler:(nullable TFYStatusItemDropHandler)dropHandler;

/**
 更新弹窗窗口的contentViewController。
 
 contentViewController 在弹出窗口中显示的contentViewController。
 */
- (void)updateContentViewController:(NSViewController *)contentViewController;

/**
 移除状态项。
 */
- (void)removeStatusItem;

/**
 属性，表示在状态栏中显示的底层“NSStatusItem”。
 */
@property (strong, readonly) NSStatusItem *statusItem;

/**
 属性，如果不是nil，则表示要执行的dropHandler。
 */
@property (copy, nonatomic,nullable) TFYStatusItemDropHandler dropHandler;

/**
 属性，该属性表示单击状态项时执行的shouldShowHandler(如果不是nil)。
 */
@property (copy, nonatomic) TFYStatusItemShouldShowHandler shouldShowHandler;


#pragma mark - StatusBarItem和弹窗显示

/**
 布尔属性，该属性决定系统状态项是处于暗模式(暗菜单栏)还是亮模式。
 */
@property (readonly, nonatomic) BOOL isDarkMode;

/**
 布尔属性，该属性确定状态项是禁用还是正常。

 显示为禁用并不意味着状态项本身也是禁用的。这种行为通常用于指示网络可达性。
 */
@property (assign, nonatomic) BOOL appearsDisabled;

/**
 布尔属性，该属性确定状态项是否启用。

 @value YES状态项为启用。
 @value NO状态项被禁用。
 */
@property (assign, nonatomic) BOOL enabled;

/**
 布尔属性，该属性确定状态项弹出窗口当前是否可见。

 弹出窗口是可见的。
 @value NO弹出窗口不可见。
 */
@property (readonly, nonatomic) BOOL isStatusItemWindowVisible;

/**
 显示弹出窗口。

 如果contentViewController没有设置什么也不会发生。
 */
- (void)showStatusItemWindow;

/**
 解散弹出窗口。

 由于这个弹窗是' NSPanel '的子类，当它关闭时它不会被释放。
 */
- (void)dismissStatusItemWindow;


# pragma mark - 处理拖拽事件和接近拖拽检测

/**
 布尔属性，该属性确定状态项是否对进度敏感。
 */
@property (assign, nonatomic, getter=isProximityDragDetectionEnabled) BOOL proximityDragDetectionEnabled;
@property (assign, nonatomic) NSInteger proximityDragZoneDistance;
@property (copy, nonatomic,nullable) TFYStatusItemProximityDragDetectionHandler proximityDragDetectionHandler;
@property (copy, nonatomic) NSArray *dropTypes;


#pragma mark - 处理StatusItem弹窗布局

/**
 属性保存窗口配置对象。
 */
@property (strong, nonatomic) TFYStatusItemWindowConfiguration *windowConfiguration;

@end

// 每个通知都有statusItemWindow作为通知对象。userInfo字典为nil。
FOUNDATION_EXPORT NSString *const TFYStatusItemWindowWillShowNotification;
FOUNDATION_EXPORT NSString *const TFYStatusItemWindowDidShowNotification;
FOUNDATION_EXPORT NSString *const TFYStatusItemWindowWillDismissNotification;
FOUNDATION_EXPORT NSString *const TFYStatusItemWindowDidDismissNotification;
FOUNDATION_EXPORT NSString *const TFYSystemInterfaceThemeChangedNotification; // 每次当系统主题在暗菜单模式和正常菜单模式之间切换时发送

NS_ASSUME_NONNULL_END
