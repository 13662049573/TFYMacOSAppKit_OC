//
//  HomeViewController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/3/10.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.blueColor.CGColor;

}

@end
