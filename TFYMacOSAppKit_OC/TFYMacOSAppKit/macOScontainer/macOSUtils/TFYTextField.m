//
//  TFYTextField.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/11.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "TFYTextField.h"
#import "TFYTextFieldCell.h"

@implementation TFYTextField
@synthesize delegate;

-(id)init{
    self = [super init];
    if(self){
        [self registerForNotifications];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self registerForNotifications];
    }
    return self;
}

-(id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if(self){
        [self registerForNotifications];
    }
    return self;
}

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

-(void)registerForNotifications{
    self.maximumNumberOfLines = 0;
    self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.bordered = NO;  ///是否显示边框
    self.drawsBackground = YES;
    self.backgroundColor = NSColor.clearColor;
    self.font = [NSFont systemFontOfSize:14];
    self.textColor = NSColor.blackColor;
    self.wantsLayer = YES;
    self.focusRingType = NSFocusRingTypeNone;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.cell = [[TFYTextFieldCell alloc]initTextCell:@""];
    self.cell.lineBreakMode = NSLineBreakByWordWrapping;
    self.editable = true;  ///是否可编辑
    self.preferredMaxLayoutWidth = 200;
    self.cell.wraps = YES;
    self.cell.truncatesLastVisibleLine = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self];
}

- (void)setIsTextAlignmentVerticalCenter:(BOOL)isTextAlignmentVerticalCenter{
    _isTextAlignmentVerticalCenter = isTextAlignmentVerticalCenter;
    if (isTextAlignmentVerticalCenter == NO) {
        ((TFYTextFieldCell *)self.cell).isTextAlignmentVerticalCenter = isTextAlignmentVerticalCenter;
    } else {
        ((TFYTextFieldCell *)self.cell).isTextAlignmentVerticalCenter = true;
    }
}

- (void)setXcursor:(CGFloat)Xcursor {
    _Xcursor = Xcursor;
    ((TFYTextFieldCell *)self.cell).Xcursor = Xcursor;
}

- (void)setOringeY:(CGFloat)oringeY {
    _oringeY = oringeY;
    ((TFYTextFieldCell *)self.cell).oringeY = oringeY;
}

-(void)textFieldDidChange:(NSNotification *)notification{
    [self.delegate textFieldDidChange:self];
}

- (BOOL)becomeFirstResponder {
    BOOL success = [super becomeFirstResponder];
    if (success) {
        NSTextView *textView = (NSTextView *)[self currentEditor];
        if ([textView respondsToSelector:@selector(setInsertionPointColor:)]) {
            NSColor *tintCor = self.textColor;
            [textView setInsertionPointColor: tintCor];
        }
    }
    return success;
}

@end

