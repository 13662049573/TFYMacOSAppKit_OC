//
//  TFYStatusItemWindowController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItemWindowController.h"
#import <QuartzCore/QuartzCore.h>

NSString *const TFYStatusItemWindowWillShowNotification    = @"TFYStatusItemWindowWillShowNotification";
NSString *const TFYStatusItemWindowDidShowNotification     = @"TFYStatusItemWindowDidShowNotification";
NSString *const TFYStatusItemWindowWillDismissNotification = @"TFYStatusItemWindowWillDismissNotification";
NSString *const TFYStatusItemWindowDidDismissNotification  = @"TFYStatusItemWindowDidDismissNotification";
NSString *const TFYSystemInterfaceThemeChangedNotification = @"TFYSystemInterfaceThemeChangedNotification";


static const CGFloat TFYTransitionDistance = 8.0;
typedef NS_ENUM(NSUInteger, TFYFadeDirection) {
    TFYFadeDirectionFadeIn = 0,
    TFYFadeDirectionFadeOut
};

typedef void (^TFYStatusItemWindowAnimationCompletion)(void);

@interface TFYStatusItemWindowController ()
@property (strong) TFYStatusItem *statusItemView;
@property (strong) TFYStatusItemWindowConfiguration *windowConfiguration;
@end

@implementation TFYStatusItemWindowController

- (id)initWithConnectedStatusItem:(TFYStatusItem *)statusItem
            contentViewController:(NSViewController *)contentViewController
              windowConfiguration:(TFYStatusItemWindowConfiguration *)windowConfiguration {

    if (!contentViewController) {
        return nil;
    }

    NSAssert(contentViewController.preferredContentSize.width != 0 && contentViewController.preferredContentSize.height != 0, @"[%@] contentViewController的preferredContentSize不能是NSZeroSize!", [self className]);

    self = [super init];
    if (self) {
        self.windowIsOpen = NO;
        self.statusItemView = statusItem;
        self.windowConfiguration = windowConfiguration;

        // StatusItem Window
        self.window = [TFYStatusItemWindow statusItemWindowWithConfiguration:windowConfiguration];
        self.contentViewController = contentViewController;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWindowDidResignKeyNotification:) name:NSWindowDidResignKeyNotification object:nil];
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppleInterfaceThemeChangedNotification:) name:@"AppleInterfaceThemeChangedNotification" object:nil];
    }
    return self;
}

- (void)updateContenetViewController:(NSViewController *)contentViewController {
    // Set nil first to trigger window resize
    self.contentViewController = nil;
    self.contentViewController = contentViewController;

    [self updateWindowFrame];
}

#pragma mark - Helper

- (void)updateWindowFrame {
    CGRect statusItemRect = [[self.statusItemView.statusItem.button window] frame];
    CGRect windowFrame = NSMakeRect(NSMinX(statusItemRect) - NSWidth(self.window.frame) / 2 + NSWidth(statusItemRect) / 2,
                                    MIN(NSMinY(statusItemRect), [NSScreen mainScreen].frame.size.height) - NSHeight(self.window.frame) - self.windowConfiguration.windowToStatusItemMargin,
                                    self.window.frame.size.width,
                                    self.window.frame.size.height);
    [self.window setFrame:windowFrame display:YES];
    [self.window setAppearance:[NSAppearance currentAppearance]];
}

#pragma mark - Handling Window Visibility

- (void)showStatusItemWindow {
    if (self.animationIsRunning) return;

    [self updateWindowFrame];
    [self.window setAlphaValue:0.0];
    [self showWindow:nil];

    [self animateWindow:(TFYStatusItemWindow *) self.window withFadeDirection:TFYFadeDirectionFadeIn];
}

- (void)dismissStatusItemWindow {
    if (self.animationIsRunning) return;

    [self animateWindow:(TFYStatusItemWindow *) self.window withFadeDirection:TFYFadeDirectionFadeOut];
}

- (void)animateWindow:(TFYStatusItemWindow *)window withFadeDirection:(TFYFadeDirection)fadeDirection {
    switch (self.windowConfiguration.presentationTransition) {
        case TFYPresentationTransitionNone:
        case TFYPresentationTransitionFade: {
            [self animateWindow:window withFadeTransitionUsingFadeDirection:fadeDirection];
            break;
        }
        case TFYPresentationTransitionSlideAndFade: {
            [self animateWindow:window withSlideAndFadeTransitionUsingFadeDirection:fadeDirection];
            break;
        }
    }
}

- (void)animateWindow:(TFYStatusItemWindow *)window withFadeTransitionUsingFadeDirection:(TFYFadeDirection)fadeDirection {
    NSString *notificationName = (fadeDirection == TFYFadeDirectionFadeIn ? TFYStatusItemWindowWillShowNotification : TFYStatusItemWindowWillDismissNotification);
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:window];

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = self.windowConfiguration.animationDuration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [[window animator] setAlphaValue:(fadeDirection == TFYFadeDirectionFadeIn ? 1.0 : 0.0)];

    }                   completionHandler:[self animationCompletionForWindow:window fadeDirection:fadeDirection]];
}

- (void)animateWindow:(TFYStatusItemWindow *)window withSlideAndFadeTransitionUsingFadeDirection:(TFYFadeDirection)fadeDirection {
    NSString *notificationName = (fadeDirection == TFYFadeDirectionFadeIn ? TFYStatusItemWindowWillShowNotification : TFYStatusItemWindowWillDismissNotification);
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:window];

    CGRect windowStartFrame, windowEndFrame;
    CGRect calculatedFrame = NSMakeRect(NSMinX(window.frame), NSMinY(window.frame) + TFYTransitionDistance, NSWidth(window.frame), NSHeight(window.frame));

    switch (fadeDirection) {
        case TFYFadeDirectionFadeIn: {
            windowStartFrame = calculatedFrame;
            windowEndFrame = window.frame;
            break;
        }
        case TFYFadeDirectionFadeOut: {
            windowStartFrame = window.frame;
            windowEndFrame = calculatedFrame;
            break;
        }
    }
    [window setFrame:windowStartFrame display:NO];

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = self.windowConfiguration.animationDuration;
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [[window animator] setFrame:windowEndFrame display:NO];
        [[window animator] setAlphaValue:(fadeDirection == TFYFadeDirectionFadeIn ? 1.0 : 0.0)];

    }                   completionHandler:[self animationCompletionForWindow:window fadeDirection:fadeDirection]];
}

- (TFYStatusItemWindowAnimationCompletion)animationCompletionForWindow:(TFYStatusItemWindow *)window fadeDirection:(TFYFadeDirection)fadeDirection {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    __weak typeof(self) wSelf = self;

    return ^{
        wSelf.animationIsRunning = NO;
        wSelf.windowIsOpen = (fadeDirection == TFYFadeDirectionFadeIn);

        if (fadeDirection == TFYFadeDirectionFadeIn) {
            [window makeKeyWindow];
            [nc postNotificationName:TFYStatusItemWindowDidShowNotification object:window];
        }
        else {
            [window orderOut:wSelf];
            [window close];
            [nc postNotificationName:TFYStatusItemWindowDidDismissNotification object:window];
        }
    };
}

#pragma mark - Notifications

- (void)handleWindowDidResignKeyNotification:(NSNotification *)note {
    if (![note.object isEqual:self.window]) return;
    if (!self.windowConfiguration.isPinned) {
        [self dismissStatusItemWindow];
    }
}

#pragma mark - NSDistributedNotificationCenter

- (void)handleAppleInterfaceThemeChangedNotification:(NSNotification *)note {
    [[NSNotificationCenter defaultCenter] postNotificationName:TFYSystemInterfaceThemeChangedNotification object:nil];
}

@end
