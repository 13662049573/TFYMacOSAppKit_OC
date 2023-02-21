//
//  TFYTextFieldCell.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import "TFYTextFieldCell.h"
#import <objc/message.h>

@implementation TFYTextFieldCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollable = true;
        self.title = @"";
        self.editable = true;
    }
    return self;
}

@end

@implementation TFYTextFieldCell (cell)

- (void)setTfy_isCentering:(BOOL)tfy_isCentering {
    objc_setAssociatedObject(self, @selector(tfy_isCentering), @(tfy_isCentering), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)tfy_isCentering {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return number.boolValue;
}

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame {
    NSInteger offset = floor((NSHeight(frame)/2 - ([[self font] ascender] + [[self font] descender])));
    NSRect rect = self.tfy_isCentering?NSInsetRect(frame, 0.0, offset):frame;
    return rect;
}

 - (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event {
    [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate event:event];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate start:(NSInteger)start length:(NSInteger)length {
    [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect]
                inView:controlView editor:editor delegate:delegate
                 start:start length:length];
}

 - (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view {
     [super drawInteriorWithFrame:[self adjustedFrameToVerticallyCenterText:frame] inView:view];
}


@end
