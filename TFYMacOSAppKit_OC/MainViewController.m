//
//  MainViewController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "MainViewController.h"


@interface MainViewController ()
@property (nonatomic , strong) NSView *backView;
@end

@implementation MainViewController

- (void)loadView {
    NSRect frame = CGRectMake(0, 0, 1100, 680);
    NSView *view = [[NSView alloc]initWithFrame:frame];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backView];
    
}

- (NSView *)backView {
   if (!_backView) {
       _backView = NSViewSet();
       _backView.makeChain
       .frame(NSMakeRect(0, 0, self.view.bounds.size.width, 200))
       .wantsLayer(YES)
       .layerBackGroundColor(NSColor.redColor);
   }
   return _backView;
}

@end
