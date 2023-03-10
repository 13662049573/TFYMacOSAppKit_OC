//
//  TFYStatusItemWindowController.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import <Cocoa/Cocoa.h>
#import "TFYStatusItem.h"
#import "TFYStatusItemWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFYStatusItemWindowController : NSWindowController

- (id)initWithConnectedStatusItem:(TFYStatusItem *)statusItem
            contentViewController:(NSViewController *)contentViewController
              windowConfiguration:(TFYStatusItemWindowConfiguration *)windowConfiguration;

- (void)updateContenetViewController:(NSViewController *)contentViewController;

@property (assign) BOOL windowIsOpen;
@property (assign) BOOL animationIsRunning;

- (void)showStatusItemWindow;
- (void)dismissStatusItemWindow;

@end

NS_ASSUME_NONNULL_END
