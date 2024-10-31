//
//  TFYCustomBtn.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/10/31.
//

#import "TFYCustomBtn.h"
#import <objc/message.h>

#define TFYMsgSend(...)       ((void (*)(void *, SEL, id))objc_msgSend)(__VA_ARGS__)
#define TFYMsgTarget(target)  (__bridge void *)(target)

@interface TFYCustomBtn (){
    NSTrackingArea *_trackingArea;
}

@property (nonatomic,assign) BOOL mouseDown;

@end

@implementation TFYCustomBtn

- (void)setMouseDown:(BOOL)mouseDown {
    if (_mouseDown == mouseDown) return;
    
    _mouseDown = mouseDown;
    [self setNeedsDisplay];
}

///圆角
- (void)setRectCorners:(TFYRectCorner)rectCorners {
    if (_rectCorners == rectCorners) return;
    
    _rectCorners = rectCorners;
    [self setNeedsDisplay];
}

///半径
- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    
    _radius = radius;
    [self setNeedsDisplay];
}

///按钮文字
- (void)setDefaultTitle:(NSString *)defaultTitle {
    if ([_defaultTitle isEqualToString:defaultTitle]) return;
    _defaultTitle = defaultTitle;
    [self setNeedsDisplay];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    if ([_selectedTitle isEqualToString:selectedTitle]) return;
    _selectedTitle = selectedTitle;
    [self setNeedsDisplay];
}

///按钮文字对齐方式
- (void)setTextAlignment:(TFYTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) return;
    _textAlignment = textAlignment;
    [self setNeedsDisplay];
}

///按钮文字下划线样式
- (void)setTextUnderLineStyle:(TFYTextUnderLineStyle)textUnderLineStyle {
    if (_textUnderLineStyle == textUnderLineStyle) return;
    _textUnderLineStyle = textUnderLineStyle;
    [self setNeedsDisplay];
}

///按钮文字颜色
- (void)setDefaultTitleColor:(NSColor *)defaultTitleColor {
    if (_defaultTitleColor == defaultTitleColor) return;
    _defaultTitleColor = defaultTitleColor;
    [self setNeedsDisplay];
}

- (void)setSelectedTitleColor:(NSColor *)selectedTitleColor {
    if (_selectedTitleColor == selectedTitleColor) return;
    _selectedTitleColor = selectedTitleColor;
    [self setNeedsDisplay];
}

///按钮字体
- (void)setDefaultFont:(NSFont *)defaultFont {
    if (_defaultFont == defaultFont) return;
    _defaultFont = defaultFont;
    [self setNeedsDisplay];
}

- (void)setSelectedFont:(NSFont *)selectedFont {
    if (_selectedFont == selectedFont) return;
    _selectedFont = selectedFont;
    [self setNeedsDisplay];
}

///当背景图片存在时，背景色无效
- (void)setDefaultBackgroundImage:(NSImage *)defaultBackgroundImage {
    if (_defaultBackgroundImage == defaultBackgroundImage) return;
    _defaultBackgroundImage = defaultBackgroundImage;
    [self setNeedsDisplay];
}

- (void)setSelectedBackgroundImage:(NSImage *)selectedBackgroundImage {
    if (_selectedBackgroundImage == selectedBackgroundImage) return;
    _selectedBackgroundImage = selectedBackgroundImage;
    [self setNeedsDisplay];
}

///当背景图片不存在时，显示背景色
- (void)setDefaultBackgroundColor:(NSColor *)defaultBackgroundColor {
    if (_defaultBackgroundColor == defaultBackgroundColor) return;
    _defaultBackgroundColor = defaultBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setSelectedBackgroundColor:(NSColor *)selectedBackgroundColor {
    if (_selectedBackgroundColor == selectedBackgroundColor) return;
    _selectedBackgroundColor = selectedBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setNeedsDisplay {
    if (self.superview) {
        [self setNeedsDisplay:YES];
    }
}

-(void)updateTrackingAreas {
    if (_trackingArea == nil) {
        _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                     options:NSTrackingMouseEnteredAndExited|NSTrackingActiveInKeyWindow
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:_trackingArea];
    }
}

-(void)mouseEntered:(NSEvent *)theEvent{
    if (_isHandCursor == NO) return;
    [[NSCursor pointingHandCursor] set];
}

-(void)mouseExited:(NSEvent *)theEvent{
    if (_isHandCursor == NO) return;
    [[NSCursor arrowCursor] set];
}

- (void)mouseDown:(NSEvent *)event {
    NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
    if (CGRectContainsPoint(self.bounds, point)) {
        self.mouseDown = YES;
    }
}

- (void)mouseUp:(NSEvent *)event {
    if (self.mouseDown) {
        self.mouseDown = NO;
        [self setNeedsDisplay:YES];
        
        NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
        if (CGRectContainsPoint(self.bounds, point)) {
            
            if (self.target && self.action && [self.target respondsToSelector:self.action]) {
                TFYMsgSend(TFYMsgTarget(self.target), self.action, self);
            }
        }
    }
}

- (void)drawRect:(NSRect)dirtyRect {

    NSString *title      = nil;
    NSFont   *font       = nil;
    NSColor  *titleColor = nil;
    NSColor  *backgroundColor = nil;
    NSImage  *backgroundImage = nil;
    
    if (self.mouseDown) {
        title = self.selectedTitle;
        font  = self.selectedFont;
        titleColor = self.selectedTitleColor;
        backgroundColor = self.selectedBackgroundColor;
        backgroundImage = self.selectedBackgroundImage;
        
        if (title == nil) {
            title = self.defaultTitle;
        }
        if (font == nil) {
            font  = self.defaultFont;
        }
        if (titleColor == nil) {
            titleColor = self.defaultTitleColor;
        }
        if (backgroundColor == nil) {
            backgroundColor = self.defaultBackgroundColor;
        }
        if (backgroundImage == nil) {
            backgroundImage = self.defaultBackgroundImage;
        }
    }
    else {
        title = self.defaultTitle;
        font  = self.defaultFont;
        titleColor = self.defaultTitleColor;
        backgroundColor = self.defaultBackgroundColor;
        backgroundImage = self.defaultBackgroundImage;
    }
    
    if (title == nil) {
        title = @"按钮";
    }
    if (font == nil) {
        font = [NSFont systemFontOfSize:17];
    }
    if (titleColor == nil) {
        titleColor = [NSColor blackColor];
    }
    if (backgroundImage) {
        backgroundColor = [NSColor colorWithPatternImage:backgroundImage];
    }
    else {
        if (backgroundColor == nil) {
            backgroundColor = [NSColor clearColor];
        }
    }
    
    if (_rectCorners) {
        NSBezierPath *bezierPath;
        if (_rectCorners == TFYRectCornerAllCorners) {
            bezierPath = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:_radius yRadius:_radius];
        }
        else {
            bezierPath = [NSBezierPath bezierPath];
            
            CGFloat topRightRadius = 0.0, topLeftRadius = 0.0, bottomLeftRadius = 0.0, bottomRightRadius = 0.0;
            
            if (_rectCorners & TFYRectCornerTopRight) {
                topRightRadius = _radius;
            }
            if (_rectCorners & TFYRectCornerTopLeft) {
                topLeftRadius = _radius;
            }
            if (_rectCorners & TFYRectCornerBottomLeft) {
                bottomLeftRadius = _radius;
            }
            if (_rectCorners & TFYRectCornerBottomRight) {
                bottomRightRadius = _radius;
            }
            
            //右上
            CGPoint topRightPoint = CGPointMake(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y+dirtyRect.size.height);
            topRightPoint.x -= topRightRadius;
            topRightPoint.y -= topRightRadius;
            [bezierPath appendBezierPathWithArcWithCenter:topRightPoint radius:topRightRadius startAngle:0 endAngle:90];
            
            //左上
            CGPoint topLeftPoint = CGPointMake(dirtyRect.origin.x, dirtyRect.origin.y+dirtyRect.size.height);
            topLeftPoint.x += topLeftRadius;
            topLeftPoint.y -= topLeftRadius;
            [bezierPath appendBezierPathWithArcWithCenter:topLeftPoint radius:topLeftRadius startAngle:90 endAngle:180];
            
            //左下
            CGPoint bottomLeftPoint = dirtyRect.origin;
            bottomLeftPoint.x += bottomLeftRadius;
            bottomLeftPoint.y += bottomLeftRadius;
            [bezierPath appendBezierPathWithArcWithCenter:bottomLeftPoint radius:bottomLeftRadius startAngle:180 endAngle:270];
            
            //右下
            CGPoint bottomRightPoint = CGPointMake(dirtyRect.origin.x+dirtyRect.size.width, dirtyRect.origin.y);
            bottomRightPoint.x -= bottomRightRadius;
            bottomRightPoint.y += bottomRightRadius;
            [bezierPath appendBezierPathWithArcWithCenter:bottomRightPoint radius:bottomRightRadius startAngle:270 endAngle:360];
        }
        [backgroundColor setFill];
        [bezierPath fill];
    }
    else {
        [backgroundColor setFill];
        NSRectFill(dirtyRect);
    }
    
    if (title) {
        
        //绘制文字
        NSMutableAttributedString *attTitle = [[NSMutableAttributedString alloc] initWithString:title];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 1;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     NSForegroundColorAttributeName:titleColor};
        
        [attTitle addAttributes:attributes range:NSMakeRange(0, attTitle.length)];
        
        if (self.textUnderLineStyle == TFYTextUnderLineStyleSingle) {
            NSUnderlineStyle style = NSUnderlineStyleSingle;
            [attTitle addAttributes:@{NSUnderlineStyleAttributeName:@(style)} range:NSMakeRange(0, attTitle.length)];
            [attTitle addAttributes:@{NSUnderlineColorAttributeName:titleColor} range:NSMakeRange(0, attTitle.length)];
        }
        else if (self.textUnderLineStyle == TFYTextUnderLineStyleDouble) {
            NSUnderlineStyle style = NSUnderlineStyleDouble;
            [attTitle addAttributes:@{NSUnderlineStyleAttributeName:@(style)} range:NSMakeRange(0, attTitle.length)];
            [attTitle addAttributes:@{NSUnderlineColorAttributeName:titleColor} range:NSMakeRange(0, attTitle.length)];
        }
        else if (self.textUnderLineStyle == TFYTextUnderLineStyleDeleteSingle) {
            [attTitle addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle),
                                      NSStrikethroughColorAttributeName:titleColor}
                          range:NSMakeRange(0, attTitle.length)];
        }
        else if (self.textUnderLineStyle == TFYTextUnderLineStyleDeleteDouble) {
            [attTitle addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleDouble),
                                      NSStrikethroughColorAttributeName:titleColor}
                              range:NSMakeRange(0, attTitle.length)];
        }
        
        CGSize titleSize = [attTitle.string boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        CGRect titleRect;
        if (self.textAlignment == TFYTextAlignmentLeft) {
            titleRect = CGRectMake(0,
                                   (self.bounds.size.height-titleSize.height)/2.0,
                                   titleSize.width,
                                   titleSize.height);
        }
        else if (self.textAlignment == TFYTextAlignmentCenter) {
            titleRect = CGRectMake((self.bounds.size.width-titleSize.width)/2.0,
                                   (self.bounds.size.height-titleSize.height)/2.0,
                                   titleSize.width,
                                   titleSize.height);
        }
        else {
            titleRect = CGRectMake((self.bounds.size.width-titleSize.width),
                                   (self.bounds.size.height-titleSize.height)/2.0,
                                   titleSize.width,
                                   titleSize.height);
        }
        [attTitle drawInRect:titleRect];
    }
    [super drawRect:dirtyRect];
}

- (void)removeFromSuperview {
    if (_trackingArea) {
        [self removeTrackingArea:_trackingArea];
    }
    [super removeFromSuperview];
}


@end
