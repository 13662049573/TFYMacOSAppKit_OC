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
@end



NS_ASSUME_NONNULL_END
