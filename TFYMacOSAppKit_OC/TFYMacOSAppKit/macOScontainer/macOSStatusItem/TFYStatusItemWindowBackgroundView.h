//
//  TFYStatusItemWindowBackgroundView.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import <Cocoa/Cocoa.h>
#import "TFYStatusItemWindowConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYStatusItemWindowBackgroundView : NSView
- (instancetype)initWithFrame:(NSRect)frameRect windowConfiguration:(TFYStatusItemWindowConfiguration *)configuration;
@end

NS_ASSUME_NONNULL_END
