//
//  AppDelegate.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/10.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.windowController showWindow:self];
    
    HomeViewController *showVc = HomeViewController.new;
    showVc.preferredContentSize = CGSizeMake(500, 300);
    
    [[TFYStatusItem sharedInstance] presentStatusItemWithImage:[NSImage imageNamed:@"mood_cognition"] contentViewController:showVc dropHandler:^(TFYStatusItem * _Nonnull sharedItem, NSString * _Nonnull pasteboardType, NSArray * _Nonnull droppedObjects) {
        
        NSLog(@"%@%@%@",sharedItem,pasteboardType,droppedObjects);
        
    }];
    
//    NSView *backView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//    backView.wantsLayer = YES;
//    backView.layer.backgroundColor = NSColor.blueColor.CGColor;
//
//    [[TFYStatusItem sharedInstance] presentStatusItemWithView:backView contentViewController:showVc];
    
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
