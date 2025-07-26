//
//  TFYStatusItemWindowConfiguration.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TFYPresentationTransition) {
    TFYPresentationTransitionNone = 0,
    TFYPresentationTransitionFade,
    TFYPresentationTransitionSlideAndFade
};

static const CGFloat TFYDefaultArrowHeight  = 11.0;
static const CGFloat TFYDefaultArrowWidth   = 42.0;
static const CGFloat TFYDefaultCornerRadius = 5.0;

@interface TFYStatusItemWindowConfiguration : NSObject


+ (instancetype)defaultConfiguration;

// 状态项窗口
@property (assign, nonatomic) CGFloat windowToStatusItemMargin;                     // 默认值:2.0
@property (assign, nonatomic) NSTimeInterval animationDuration;                     // 默认值:0.21
@property (strong, nonatomic) NSColor *backgroundColor;                             // 默认值: [NSColor windowBackgroundColor]
@property (assign, nonatomic) TFYPresentationTransition presentationTransition;     // 默认值: CCNPresentationTransitionFade
                                                                                    // 在将' presentationtransition '设置为大小写'TFYPresentationTransitionNone' property 'animationDuration'将被设置为0
                                                                                    
@property (strong, nonatomic,nullable) NSString *toolTip;
@property (assign, nonatomic, getter=isPinned) BOOL pinned; //默认值:无;通常情况下，如果窗口失去了它的关键窗口状态，它将被自动解散。将此属性设置为YES将使窗口可见。

@end

NS_ASSUME_NONNULL_END
