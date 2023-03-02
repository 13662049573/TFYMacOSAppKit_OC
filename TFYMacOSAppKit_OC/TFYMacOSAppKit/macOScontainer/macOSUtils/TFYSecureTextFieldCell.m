//
//  TFYSecureTextFieldCell.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/2.
//

#import "TFYSecureTextFieldCell.h"

@implementation TFYSecureTextFieldCell

- (void)setAlignment:(NSTextAlignment)alignment {
    [super setAlignment:alignment];
    NSString *placeholderString = self.placeholderString?:@"";
    if (placeholderString.length > 0) {
        NSMutableAttributedString *attributedString = [placeholderString mutableCopy];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = alignment;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, placeholderString.length)];
        self.placeholderAttributedString = attributedString;
    }
}

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame{
    if (self.isTextAlignmentVerticalCenter == false) {
        return frame;
    }
    NSInteger offset = floor((NSHeight(frame)/2 - (self.font.ascender + self.font.descender)));
    return NSInsetRect(frame, self.Xcursor, offset);
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

@end
