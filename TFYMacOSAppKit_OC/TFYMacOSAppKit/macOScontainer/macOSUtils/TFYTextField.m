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
    self.cell = [[TFYTextFieldCell alloc]initTextCell:@""];
    self.cell.lineBreakMode = NSLineBreakByWordWrapping;
    self.cell.truncatesLastVisibleLine = true;
    self.editable = true;  ///是否可编辑
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self];
}

- (void)setIsTextAlignmentVerticalCenter:(BOOL)isTextAlignmentVerticalCenter{
    _isTextAlignmentVerticalCenter = isTextAlignmentVerticalCenter;
    ((TFYTextFieldCell *)self.cell).isTextAlignmentVerticalCenter = true;
}

- (void)setXcursor:(CGFloat)Xcursor {
    _Xcursor = Xcursor;
    ((TFYTextFieldCell *)self.cell).Xcursor = Xcursor;
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

