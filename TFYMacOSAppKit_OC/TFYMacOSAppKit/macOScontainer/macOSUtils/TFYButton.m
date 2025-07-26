//
//  TFYButton.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "TFYButton.h"
#import "NSColor+Dejal.h"
#import "NSImage+Dejal.h"

NSString * const kTitle = @"title";
NSString * const kTitleColor = @"titleColor";
NSString * const kBackgroundImage = @"backgroundImage";
NSString * const kbackgroundColor = @"backgroundColor";
NSString * const kAttributedTitle = @"AttributedTitle";
NSString * const kBorderColor = @"BorderColor";
NSString * const kBorderWidth = @"BorderWidth";
NSString * const kCornerRadius = @"CornerRadius";

@interface TFYButton ()
@property (nonatomic, assign) BOOL hover;
@property(nonatomic, assign) BOOL mouseUp;

@property(nonatomic, strong) NSTrackingArea *trackingArea;

@property(nonatomic, strong) NSMutableDictionary *mdic;
@property(nonatomic, strong) NSMutableDictionary *mdicState;

@property(nonatomic, strong) NSMutableDictionary *mdicNormal;
@property(nonatomic, strong) NSMutableDictionary *mdicHighlighted;
@property(nonatomic, strong) NSMutableDictionary *mdicDisabled;
@property(nonatomic, strong) NSMutableDictionary *mdicSelected;
@property(nonatomic, strong) NSMutableDictionary *mdicHover;

@property(nonatomic, assign, readwrite) TFYControlState buttonState;
@end

@implementation TFYButton

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"enabled"];
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
        self.wantsLayer = true;
        
        [self setTitleColor:NSColor.labelColor forState:TFYControlStateNormal];
        [self setBackgroundImage:[NSImage tfy_imageWithColor:NSColor.lightGrayColor] forState:TFYControlStateNormal];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    NSImage *image = self.backgroundImage ? : [NSImage tfy_imageWithColor:NSColor.lightGrayColor];
    if (image) {
        [image drawInRect:self.bounds];
    }
    
    CGFloat padding = 8.0;
    if (self.isAttributedTitle) {
        [self drawAttributedString:self.attributedTitle padding:padding];

    } else {
        if (!self.title) {
            return;
        }
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle defaultParagraphStyle]mutableCopy];
        paraStyle.alignment = self.alignment ? self.alignment : NSTextAlignmentCenter;
        paraStyle.lineBreakMode = self.lineBreakMode ? self.lineBreakMode : NSLineBreakByWordWrapping;
        
        NSDictionary *attrDic = @{NSParagraphStyleAttributeName: paraStyle,
                                  NSForegroundColorAttributeName: self.titleColor ? : NSColor.labelColor,
                                  NSFontAttributeName: self.font,
                                }.mutableCopy;
        
        NSAttributedString *attString = [[NSAttributedString alloc]initWithString:self.title attributes:attrDic];
        [self drawAttributedString:attString padding:padding];
    }
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    [super viewWillMoveToSuperview:newSuperview];
    [self updateUIWithState:self.buttonState];
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways;
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:options owner:self userInfo:nil];

    [self addTrackingArea:self.trackingArea];
}

- (void)setButtonType:(TFYButtonType)buttonType {
    _buttonType = buttonType;
    switch (buttonType) {
        case TFYButtonType1:
        {
            [self setTitleColor:NSColor.labelColor forState:TFYControlStateNormal];
        }
            break;
        case TFYButtonType2:
        {
            [self setTitleColor:NSColor.whiteColor forState:TFYControlStateNormal];
            NSImage *image = [NSImage tfy_imageWithColor:[NSColor tfy_hexValue:0x29B5FE alpha:1]];
            [self setBackgroundImage:image forState:TFYControlStateNormal];
        }
            break;
        default:
            break;
    }
}


#pragma -NSEvent
- (void)mouseEntered:(NSEvent *)theEvent {
    self.hover = true;
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.hover = false;
}

- (void)mouseDown:(NSEvent *)event {
    self.mouseUp = false;
}

- (void)mouseUp:(NSEvent *)event {
    self.mouseUp = true;
}

#pragma mark -observe

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSNumber *valueNew = change[NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:@"enabled"]) {
        self.buttonState = valueNew.boolValue == false ? TFYControlStateDisabled : TFYControlStateNormal;
    }
}

#pragma mark -funtions
- (void)drawAttributedString:(NSAttributedString *)attributedString padding:(CGFloat)padding{
    CGSize maxSize = CGSizeMake(self.bounds.size.width - padding*2, CGFLOAT_MAX);
    CGSize size = [attributedString boundingRectWithSize:maxSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 context:nil].size;
    
    CGFloat gapX = padding + (maxSize.width - size.width)/2;
    CGFloat gapY = (CGRectGetHeight(self.bounds) - size.height)/2;
    CGRect contentRect = NSMakeRect(floorf(gapX), floorf(gapY), size.width, size.height);
    [attributedString drawInRect:contentRect];
}


- (void)setTitle:(nullable NSString *)title forState:(TFYControlState)state {
    if (!title) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.title = title;
        self.mdic[@(TFYControlStateHover)][kTitle] = title;
        self.mdic[@(TFYControlStateSelected)][kTitle] = title;
        self.mdic[@(TFYControlStateHighlighted)][kTitle] = title;
        self.mdic[@(TFYControlStateDisabled)][kTitle] = title;
    }
    self.mdic[@(state)][kTitle] = title;
}

- (void)setTitleColor:(nullable NSColor *)color forState:(TFYControlState)state {
    if (!color) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.titleColor = color;
        self.mdic[@(TFYControlStateHover)][kTitleColor] = color;
        self.mdic[@(TFYControlStateHover)][kBorderColor] = color;
    }
    self.mdic[@(state)][kTitleColor] = color;
    self.mdic[@(state)][kBorderColor] = color;
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(TFYControlState)state {
    if (!title) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.title = title.string;
        self.mdic[@(TFYControlStateHover)][kAttributedTitle] = title;
        self.mdic[@(TFYControlStateSelected)][kAttributedTitle] = title;
        self.mdic[@(TFYControlStateHighlighted)][kAttributedTitle] = title;
        self.mdic[@(TFYControlStateDisabled)][kAttributedTitle] = title;
    }
    self.mdic[@(state)][kAttributedTitle] = title;
}

- (void)setBackgroundImage:(nullable NSImage *)image forState:(TFYControlState)state {
    if (!image) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.mdic[@(TFYControlStateHover)][kBackgroundImage] = image;
        self.mdic[@(TFYControlStateSelected)][kBackgroundImage] = image;
        self.mdic[@(TFYControlStateHighlighted)][kBackgroundImage] = image;
        self.mdic[@(TFYControlStateDisabled)][kBackgroundImage] = image;
    }
    self.mdic[@(state)][kBackgroundImage] = image;
}

- (void)setBorderColor:(nullable NSColor *)color forState:(TFYControlState)state {
    if (!color) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.mdic[@(TFYControlStateHover)][kBorderColor] = color;
        self.mdic[@(TFYControlStateSelected)][kBorderColor] = color;
        self.mdic[@(TFYControlStateHighlighted)][kBorderColor] = color;
        self.mdic[@(TFYControlStateDisabled)][kBorderColor] = color;
    }
    self.mdic[@(state)][kBorderColor] = color;
}

- (void)setBorderWidth:(nullable NSNumber *)number forState:(TFYControlState)state {
    if (!number) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.mdic[@(TFYControlStateHover)][kBorderWidth] = number;
        self.mdic[@(TFYControlStateSelected)][kBorderWidth] = number;
        self.mdic[@(TFYControlStateHighlighted)][kBorderWidth] = number;
        self.mdic[@(TFYControlStateDisabled)][kBorderWidth] = number;
    }
    self.mdic[@(state)][kBorderWidth] = number;
}

- (void)setCornerRadius:(nullable NSNumber *)number forState:(TFYControlState)state {
    if (!number) {
        return;
    }
    if (state == TFYControlStateNormal) {
        self.mdic[@(TFYControlStateHover)][kCornerRadius] = number;
        self.mdic[@(TFYControlStateSelected)][kCornerRadius] = number;
        self.mdic[@(TFYControlStateHighlighted)][kCornerRadius] = number;
        self.mdic[@(TFYControlStateDisabled)][kCornerRadius] = number;
    }
    self.mdic[@(state)][kCornerRadius] = number;
}

- (nullable NSString *)titleForState:(TFYControlState)state {
    NSString *result = self.mdic[@(state)][kTitle] ? : self.mdic[@(TFYControlStateNormal)][kTitle];
    return result;
}

- (nullable NSColor *)titleColorForState:(TFYControlState)state {
    NSColor *result = self.mdic[@(state)][kTitleColor] ? : self.mdic[@(TFYControlStateNormal)][kTitleColor];
    return result;
}

- (nullable NSAttributedString *)attributedStringForState:(TFYControlState)state {
    NSAttributedString *result = self.mdic[@(state)][kAttributedTitle] ? : self.mdic[@(TFYControlStateNormal)][kAttributedTitle];
    return result;
}

- (nullable NSImage *)backgroundImageForState:(TFYControlState)state {
    NSImage *result = self.mdic[@(state)][kBackgroundImage] ? : self.mdic[@(TFYControlStateNormal)][kBackgroundImage];
    return result;
}

- (nullable NSColor *)borderColorForState:(TFYControlState)state {
    NSColor *result = self.mdic[@(state)][kBorderColor] ? : self.mdic[@(TFYControlStateNormal)][kBorderColor];
    return result;
}

- (nullable NSNumber *)borderWidthForState:(TFYControlState)state {
    NSNumber *result = self.mdic[@(state)][kBorderColor] ? : self.mdic[@(TFYControlStateNormal)][kBorderColor];
    return result;
}

- (nullable NSNumber *)cornerRadiusForState:(TFYControlState)state {
    NSNumber *result = self.mdic[@(state)][kCornerRadius] ? : self.mdic[@(TFYControlStateNormal)][kCornerRadius];
    return result;
}

- (void)updateUIWithState:(TFYControlState)state {
    if (self.block) {
        self.block(self, state);
    }
    if (state == TFYControlStateHighlighted && self.showHighlighted == false) {
        return;
    }
    
    self.mdicState = self.mdic[@(state)] ? : self.mdic[@(TFYControlStateNormal)];
    self.title = self.mdicState[kTitle];
    self.titleColor = self.mdicState[kTitleColor];
    self.backgroundImage = self.mdicState[kBackgroundImage];
                
    switch (self.buttonType) {
        case TFYButtonType1:
        {
            if (state == TFYControlStateDisabled) {
                self.layer.borderColor = NSColor.lightGrayColor.CGColor;
                
            } else {
                NSColor *borderColor = self.mdicState[kBorderColor];
                if (CGColorEqualToColor(NSColor.clearColor.CGColor, borderColor.CGColor) == false) {
                    self.layer.borderColor = [borderColor CGColor];
                }
            }
            NSNumber *borderWidth = self.mdicState[kBorderWidth];
            if (borderWidth.floatValue > 0) {
                self.layer.borderWidth = borderWidth.floatValue;
            }
            
            NSNumber *cornerRadius = self.mdicState[kCornerRadius];
            if (cornerRadius.floatValue > 0) {
                self.layer.cornerRadius = cornerRadius.floatValue;
            }
        }
            break;
        case TFYButtonType2:
        {
            if (state == TFYControlStateDisabled) {
                self.titleColor = NSColor.labelColor;
                NSImage *image = [NSImage tfy_imageWithColor:[NSColor tfy_hexValue:0x29B5FE alpha:1]];
                self.backgroundImage = image;
            }
        }
            break;
        default:
            break;
    }
    [self setNeedsDisplay:YES];
}

- (void)stateBlock:(void(^)(TFYButton *sender, TFYControlState state))block{
    self.block = block;
}


#pragma mark -set

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (!self.enabled) {
        return;
    }
    self.buttonState = selected ? TFYControlStateSelected : TFYControlStateNormal;
}

- (void)setHover:(BOOL)hover{
    _hover = hover;
    if (!self.enabled) {
        return;
    }
    
    if (hover) {
        self.buttonState = TFYControlStateHover;
    } else {
        self.buttonState = self.selected ? TFYControlStateSelected : TFYControlStateNormal;
    }
}

- (void)setMouseUp:(BOOL)mouseUp{
    _mouseUp = mouseUp;
    if (!self.enabled) {
        return;
    }
    
    if (mouseUp) {
        self.buttonState = self.selected ? TFYControlStateSelected : TFYControlStateNormal;

    } else {
        self.buttonState = TFYControlStateHighlighted;
    }
    
    if (self.hover && self.enabled && mouseUp) {
        NSString *selString = NSStringFromSelector(self.action);
        if ([selString hasSuffix:@":"]) {
            [self.target performSelector:self.action withObject:self afterDelay:0.f];
        } else {
            [self.target performSelector:self.action withObject:nil afterDelay:0.f];
        }
    }
}

- (void)setButtonState:(TFYControlState)buttonState{
    _buttonState = buttonState;

    [self updateUIWithState:buttonState];
}

#pragma mark -lazy

- (NSMutableDictionary *)mdic{
    if (!_mdic) {
        _mdic = @{@(TFYControlStateNormal): self.mdicNormal,
                  @(TFYControlStateHighlighted): self.mdicHighlighted,
                  @(TFYControlStateDisabled): self.mdicDisabled,
                  @(TFYControlStateSelected): self.mdicSelected,
                  @(TFYControlStateHover): self.mdicHover,
        }.mutableCopy;
    }
    return _mdic;
}

- (NSMutableDictionary *)mdicNormal{
    if (!_mdicNormal) {
        _mdicNormal = @{kTitle: self.title,
                        kTitleColor: NSColor.labelColor,
                        kBackgroundImage: [NSImage tfy_imageWithColor:NSColor.whiteColor],
                        kCornerRadius: @(0.0),
                        kBorderWidth: @(1.0),
                        kBorderColor: NSColor.clearColor,
        }.mutableCopy;
    }
    return _mdicNormal;
}

- (NSMutableDictionary *)mdicHighlighted{
    if (!_mdicHighlighted) {
        _mdicHighlighted = @{kTitle: self.title,
                             kTitleColor: NSColor.labelColor,
                             kBackgroundImage: [NSImage tfy_imageWithColor:NSColor.systemBlueColor],
                             kCornerRadius: @(0.0),
                             kBorderWidth: @(1.0),
                             kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicHighlighted;
}

- (NSMutableDictionary *)mdicDisabled{
    if (!_mdicDisabled) {
        _mdicDisabled = @{kTitle: self.title,
                          kTitleColor: NSColor.lightGrayColor,
                          kBackgroundImage: [NSImage tfy_imageWithColor:NSColor.whiteColor],
                          kCornerRadius: @(0.0),
                          kBorderWidth: @(1.0),
                          kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicDisabled;
}

- (NSMutableDictionary *)mdicSelected{
    if (!_mdicSelected) {
        _mdicSelected = @{kTitle: self.title,
                          kTitleColor: NSColor.labelColor,
                          kBackgroundImage: [NSImage tfy_imageWithColor:NSColor.whiteColor],
                          kCornerRadius: @(0.0),
                          kBorderWidth: @(1.0),
                          kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicSelected;
}

- (NSMutableDictionary *)mdicHover{
    if (!_mdicHover) {
        _mdicHover = @{kTitle: self.title,
                       kTitleColor: NSColor.labelColor,
                       kBackgroundImage: [NSImage tfy_imageWithColor:NSColor.whiteColor],
                       kCornerRadius: @(0.0),
                       kBorderWidth: @(1.0),
                       kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicHover;
}


@end
