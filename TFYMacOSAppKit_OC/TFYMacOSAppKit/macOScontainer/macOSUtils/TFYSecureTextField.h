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

-(void)securetextFieldDidChange:(NSSecureTextField *_Nullable)textField;

@end

@interface TFYSecureTextField : NSSecureTextField
@property (nullable, weak) id<TFYSecureTextFieldNotifyingDelegate> delegate;
/**
 文字是否居中 默认 NO
 */
@property (nonatomic, assign) BOOL isTextAlignmentVerticalCenter;
/**
 修改光标离X轴的距离 默认 0 isTextAlignmentVerticalCenter 为 YES 的时候 使用
 */
@property(nonatomic , assign)CGFloat Xcursor;
@end

NS_ASSUME_NONNULL_END
