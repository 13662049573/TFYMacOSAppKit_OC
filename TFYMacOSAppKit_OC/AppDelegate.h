//
//  AppDelegate.h
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/10.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) MainWindowController *windowController;

@end

