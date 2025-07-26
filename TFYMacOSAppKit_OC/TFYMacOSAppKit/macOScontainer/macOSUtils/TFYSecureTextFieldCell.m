//
//  TFYSecureTextFieldCell.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/2.
//

#import "TFYSecureTextFieldCell.h"

@implementation TFYSecureTextFieldCell

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame{
    if (self.isTextAlignmentVerticalCenter == false) {
        return frame;
    }
    CGRect titleRect =  [self titleRectForBounds:frame];
    titleRect.origin.y += self.oringeY;
    return NSInsetRect(titleRect, self.Xcursor, 0);
}

- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event{
    [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate event:event];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate start:(NSInteger)start length:(NSInteger)length{
    [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate start:start length:length];
}

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view{
    [super drawInteriorWithFrame: [self adjustedFrameToVerticallyCenterText:frame] inView:view];
}

- (NSRect)titleRectForBounds:(NSRect)rect
{
    NSRect titleRect = [super titleRectForBounds:rect];
    CGFloat minimHeight = self.cellSize.height;
    titleRect.origin.y += (titleRect.size.height - minimHeight)/2;
    titleRect.size.height = minimHeight;
    return titleRect;
}
 
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    [super drawWithFrame:cellFrame inView:controlView];
}
@end
