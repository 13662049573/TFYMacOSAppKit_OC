//
//  TFYTextFieldCell.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYTextFieldCell : NSTextFieldCell

@end

@interface TFYTextFieldCell (cell)
/**
 文字是否居中 默认 NO
 */
@property (nonatomic , assign) BOOL tfy_isCentering;

@end

NS_ASSUME_NONNULL_END
