//
//  TFYLabel.m
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import "TFYLabel.h"

@implementation TFYLabel

- (BOOL)isFlipped{
    return true;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.bordered = false;  ///是否显示边框
    self.editable = false;
    self.drawsBackground = true;
    self.backgroundColor = NSColor.clearColor;
    self.font = [NSFont systemFontOfSize:15];
    self.textColor = NSColor.blackColor;
    self.maximumNumberOfLines = 1;
    self.usesSingleLineMode = true;
}

- (void)mouseDown:(NSEvent *)event{
    if (self.mouseDownBlock) {
        self.mouseDownBlock(self);
    }
}

- (void)actionBlock:(void(^)(TFYLabel *sender))block{
    self.mouseDownBlock = block;
}

@end
