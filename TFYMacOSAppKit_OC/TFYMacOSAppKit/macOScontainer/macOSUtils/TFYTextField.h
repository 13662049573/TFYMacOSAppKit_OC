//
//  TFYTextField.h
//  MZKMedicalMacOs
//
//  Created by 田风有 on 2023/2/11.
//  Copyright © 2023 MZK. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TFYTextFieldNotifyingDelegate <NSTextFieldDelegate>
@optional

-(void)textFieldDidChange:(NSTextField *_Nullable)textField;

@end

@interface TFYTextField : NSTextField
@property (nullable, weak) id<TFYTextFieldNotifyingDelegate> delegate;
/**
 文字是否居中 默认 NO
 */
@property (nonatomic, assign) BOOL isTextAlignmentVerticalCenter;
/**
 修改光标离X轴的距离 默认 0 isTextAlignmentVerticalCenter 为 YES 的时候 使用
 */
@property(nonatomic , assign)CGFloat Xcursor;
/**
  调整Y偏移
 */
@property (nonatomic) IBInspectable CGFloat oringeY;
@end



NS_ASSUME_NONNULL_END
