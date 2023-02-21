//
//  TFYSecureTextField.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TFYSecureTextFieldNotifyingDelegate <NSTextFieldDelegate>
@optional

-(void)textFieldDidChange:(NSSecureTextField *_Nullable)textField;

@end

@interface TFYSecureTextField : NSSecureTextField
@property (nullable, weak) id<TFYSecureTextFieldNotifyingDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
