//
//  MainWindowController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "MainWindowController.h"
#import "MainViewController.h"

@interface MainWindowController ()<NSWindowDelegate>
@property (nonatomic, strong)MainViewController *viewController;
@end

@implementation MainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (instancetype)initWithWindow:(NSWindow *)window {
    if (self = [super initWithWindow:window]) {
        NSRect frame = CGRectMake(0, 0, 1100, 680);
        
        NSUInteger style = NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskTitled | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskFullSizeContentView;
        
        self.window = [[NSWindow alloc]initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:YES];
        self.window.minSize = CGSizeMake(1100, 680);
        self.window.title = @"妙智康医护端";
        self.window.delegate = self;
        self.window.windowController = self;
        self.window.titlebarAppearsTransparent = YES;
        self.window.titleVisibility = NSWindowTitleHidden;
        
        [self.window setMovableByWindowBackground:YES];
        
        [self.window setRestorable:NO];
        
        self.contentViewController = self.viewController;

        [self.window center];
    }
    return self;
}

- (MainViewController *)viewController {
    if (!_viewController) {
        _viewController = MainViewController.new;
    }
    return _viewController;
}

#pragma mark - NSWindowDelegate
- (void)windowDidEnterFullScreen:(NSNotification *)notification {
   
}

- (void)windowDidExitFullScreen:(NSNotification *)notification {
    
}

- (void)windowDidResize:(NSNotification *)notification {
   
}



@end
