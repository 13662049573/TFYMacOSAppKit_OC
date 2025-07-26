//
//  TFYProgressIndicator.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2024/11/19.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFYProgressIndicator : NSView
@property (strong) NSProgressIndicator *progressIndicator;
@property (strong) NSColor *tintColor;

- (void)startAnimation;
- (void)stopAnimation;
- (void)setColor:(NSColor *)color;
@end

NS_ASSUME_NONNULL_END
