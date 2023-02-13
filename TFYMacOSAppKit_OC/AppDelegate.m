//
//  AppDelegate.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/10.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.windowController showWindow:self];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (MainWindowController *)windowController {
    if (!_windowController) {
        _windowController = MainWindowController.new;
    }
    return _windowController;
}

@end
