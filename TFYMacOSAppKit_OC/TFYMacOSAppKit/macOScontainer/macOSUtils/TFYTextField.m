//
//  TFYTextField.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/11.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "TFYTextField.h"

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

-(void)registerForNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:NSControlTextDidChangeNotification object:self];
}

-(void)textFieldDidChange:(NSNotification *)notification{
    [self.delegate textFieldDidChange:self];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
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

