//
//  TFYSecureTextField.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import "TFYSecureTextField.h"

@implementation TFYSecureTextField
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self];
}

-(void)textFieldDidChange:(NSNotification *)notification{
    [self.delegate securetextFieldDidChange:self];
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

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
