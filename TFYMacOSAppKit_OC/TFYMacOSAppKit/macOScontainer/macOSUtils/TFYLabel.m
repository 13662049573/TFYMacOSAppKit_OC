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
    self.editable = NO;
    self.isTextAlignmentVerticalCenter = NO;
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
