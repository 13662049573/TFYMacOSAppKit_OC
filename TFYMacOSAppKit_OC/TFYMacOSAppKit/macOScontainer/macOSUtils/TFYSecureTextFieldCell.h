//
//  TFYSecureTextFieldCell.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/2.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYSecureTextFieldCell : NSSecureTextFieldCell
@property (nonatomic, assign) BOOL isTextAlignmentVerticalCenter;
@property(nonatomic , assign)CGFloat Xcursor;
@property (nonatomic) IBInspectable CGFloat oringeY;
@end

NS_ASSUME_NONNULL_END
