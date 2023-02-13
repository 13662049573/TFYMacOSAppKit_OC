//
//  NSViewController+Hook.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSViewController (Hook)

@end

@interface NSObject (Hook)
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;
@end

@interface NSView (Hook)

@end

NS_ASSUME_NONNULL_END
