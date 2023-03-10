//
//  TFYStatusItemWindowBackgroundView.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "TFYStatusItemWindowBackgroundView.h"

@interface TFYStatusItemWindowBackgroundView ()
@property (strong) TFYStatusItemWindowConfiguration *windowConfiguration;
@end

@implementation TFYStatusItemWindowBackgroundView

- (instancetype)initWithFrame:(NSRect)frameRect windowConfiguration:(TFYStatusItemWindowConfiguration *)configuration {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.windowConfiguration = configuration;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    CGFloat arrowHeight   = TFYDefaultArrowHeight;
    CGFloat arrowWidth    = TFYDefaultArrowWidth;
    CGFloat cornerRadius  = TFYDefaultCornerRadius;
    NSRect backgroundRect = NSMakeRect(NSMinX(self.bounds), NSMinY(self.bounds), NSWidth(self.bounds), NSHeight(self.bounds) - arrowHeight);

    NSBezierPath *windowPath     = [NSBezierPath bezierPath];
    NSBezierPath *arrowPath      = [NSBezierPath bezierPath];
    NSBezierPath *backgroundPath = [NSBezierPath bezierPathWithRoundedRect:backgroundRect xRadius:cornerRadius yRadius:cornerRadius];

    NSPoint leftPoint  = {NSWidth(backgroundRect) / 2 - arrowWidth / 2, NSMaxY(backgroundRect)};
    NSPoint topPoint   = {NSWidth(backgroundRect) / 2, NSMaxY(backgroundRect) + arrowHeight};
    NSPoint rightPoint = {NSWidth(backgroundRect) / 2 + arrowWidth / 2, NSMaxY(backgroundRect)};

    [arrowPath moveToPoint:leftPoint];
    [arrowPath curveToPoint:topPoint
              controlPoint1:NSMakePoint(NSWidth(backgroundRect) / 2 - arrowWidth / 4, NSMaxY(backgroundRect))
              controlPoint2:NSMakePoint(NSWidth(backgroundRect) / 2 - arrowWidth / 7, NSMaxY(backgroundRect) + arrowHeight)];
    [arrowPath curveToPoint:rightPoint
              controlPoint1:NSMakePoint(NSWidth(backgroundRect) / 2 + arrowWidth / 7, NSMaxY(backgroundRect) + arrowHeight)
              controlPoint2:NSMakePoint(NSWidth(backgroundRect) / 2 + arrowWidth / 4, NSMaxY(backgroundRect))];
    [arrowPath lineToPoint:leftPoint];
    [arrowPath closePath];

    [windowPath appendBezierPath:arrowPath];
    [windowPath appendBezierPath:backgroundPath];

    [self.windowConfiguration.backgroundColor setFill];
    [windowPath fill];
}

#pragma mark - Custom Accessors

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay:YES];
}

@end
