//
//  main.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/10.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication];//创建应用
        
        AppDelegate *appDelegate = [[AppDelegate alloc]init];//创建代理
        
        [application setDelegate:appDelegate];//配置应用代理
    
        [application run];//运行应用
    }
    return NSApplicationMain(argc, argv);
}
