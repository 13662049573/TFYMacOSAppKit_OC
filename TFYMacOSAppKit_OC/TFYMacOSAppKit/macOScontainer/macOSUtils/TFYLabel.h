//
//  TFYLabel.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/10.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TFYTextField.h"

NS_ASSUME_NONNULL_BEGIN

@class TFYLabel;
typedef void(^action)(TFYLabel *sender);

@interface TFYLabel : TFYTextField

@property(nonatomic, copy) void(^mouseDownBlock)(TFYLabel *sender);
///返回事件
- (void)actionBlock:(action)block;

@end

NS_ASSUME_NONNULL_END
