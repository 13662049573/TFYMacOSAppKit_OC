//
//  TFYStatusItemWindow.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItemWindow.h"
#import "TFYStatusItemWindowBackgroundView.h"
#import "TFYStatusItem.h"

@interface TFYStatusItemWindow (){
    TFYStatusItemWindowConfiguration *_configuration;
}
@property (strong) NSView *userContentView;
@property (strong, nonatomic) TFYStatusItemWindowBackgroundView *backgroundView;

@end

@implementation TFYStatusItemWindow

+ (instancetype)statusItemWindowWithConfiguration:(TFYStatusItemWindowConfiguration *)configuration {
    return [[[self class] alloc] initWithContentRect:NSZeroRect styleMask:NSWindowStyleMaskNonactivatingPanel backing:NSBackingStoreBuffered defer:YES configuration:configuration];
}

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)styleMask backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag configuration:(TFYStatusItemWindowConfiguration *)configuration {
    _configuration = configuration;
    self = [super initWithContentRect:contentRect styleMask:styleMask backing:bufferingType defer:flag];
    if (self) {
        self.opaque = NO;
        self.hasShadow = YES;
        self.level = NSStatusWindowLevel;
        self.backgroundColor = [NSColor clearColor];
        self.collectionBehavior = (NSWindowCollectionBehaviorCanJoinAllSpaces | NSWindowCollectionBehaviorIgnoresCycle);
        [self setAppearance:[NSAppearance currentAppearance]];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (void)setContentView:(id)contentView {
    if ([self.userContentView isEqual:contentView]) return;

    NSView *userContentView = (NSView *)contentView;
    NSRect bounds = userContentView.bounds;
    CAEdgeAntialiasingMask antialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;

    self.backgroundView = super.contentView;
    if (!self.backgroundView) {
        self.backgroundView = [[TFYStatusItemWindowBackgroundView alloc] initWithFrame:bounds windowConfiguration:_configuration];
        self.backgroundView.wantsLayer = YES;
        self.backgroundView.layer.frame = bounds;
        self.backgroundView.layer.cornerRadius = TFYDefaultCornerRadius;
        self.backgroundView.layer.masksToBounds = YES;
        self.backgroundView.layer.edgeAntialiasingMask = antialiasingMask;
        super.contentView = self.backgroundView;
    }

    if (self.userContentView) {
        [self.userContentView removeFromSuperview];
    }

    self.userContentView = userContentView;
    self.userContentView.frame = [self contentRectForFrameRect:bounds];
    self.userContentView.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);
    self.userContentView.wantsLayer = YES;
    self.userContentView.layer.frame = bounds;
    self.userContentView.layer.cornerRadius = TFYDefaultCornerRadius;
    self.userContentView.layer.masksToBounds = YES;
    self.userContentView.layer.edgeAntialiasingMask = antialiasingMask;

    [self.backgroundView addSubview:self.userContentView];
}

- (id)contentView {
    return self.userContentView;
}

- (NSRect)frameRectForContentRect:(NSRect)contentRect {
    return NSMakeRect(NSMinX(contentRect), NSMinY(contentRect), NSWidth(contentRect), NSHeight(contentRect) + TFYDefaultArrowHeight);
}


@end
