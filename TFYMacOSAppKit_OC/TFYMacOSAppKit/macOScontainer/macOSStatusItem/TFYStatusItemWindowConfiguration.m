//
//  TFYStatusItemWindowConfiguration.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItemWindowConfiguration.h"

static const CGFloat TFYDefaultStatusItemMargin         = 2.0;
static const NSTimeInterval TFYDefaultAnimationDuration = 0.21;


@implementation TFYStatusItemWindowConfiguration

+ (instancetype)defaultConfiguration {
    return [[[self class] alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.windowToStatusItemMargin = TFYDefaultStatusItemMargin;
        self.animationDuration        = TFYDefaultAnimationDuration;
        self.presentationTransition   = TFYPresentationTransitionFade;
        self.toolTip                  = nil;
        self.backgroundColor          = [NSColor windowBackgroundColor];
        self.pinned                   = NO;
    }
    return self;
}

#pragma mark - Custom Accessors

- (void)setPresentationTransition:(TFYPresentationTransition)presentationTransition {
    if (_presentationTransition != presentationTransition) {
        _presentationTransition = presentationTransition;
        if (_presentationTransition == TFYPresentationTransitionNone) {
            self.animationDuration = 0;
        }
        else {
            self.animationDuration = TFYDefaultAnimationDuration;
        }
    }
}


@end
