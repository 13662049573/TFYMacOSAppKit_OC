//
//  NSGestureRecognizer+TFY_Tools.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/11.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GestureTargetAction)(id gesture);

@interface NSGestureRecognizer (TFY_Tools)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;

- (void)tfy_addTargetBlock:(GestureTargetAction)block;

- (void)tfy_addTargetBlock:(GestureTargetAction)block tag:(NSString *)tag;

- (void)tfy_removeTargetBlockByTag:(NSString *)tag;

- (void)tfy_removeAllTargetBlock;

@end

NS_ASSUME_NONNULL_END
