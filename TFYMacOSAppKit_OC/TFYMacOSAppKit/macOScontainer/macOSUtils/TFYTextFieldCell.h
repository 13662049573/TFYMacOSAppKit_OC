//
//  TFYTextFieldCell.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYTextFieldCell : NSTextFieldCell
@property (nonatomic, assign) BOOL isTextAlignmentVerticalCenter;
@property(nonatomic , assign)CGFloat Xcursor;
@end

NS_ASSUME_NONNULL_END
