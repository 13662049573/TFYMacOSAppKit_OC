//
//  ViewController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/10.
//

#import "ViewController.h"
#import "TFYMacOSAppKit.h"

@interface ViewController ()
@property (nonatomic , strong) NSView *backView;
@end

@implementation ViewController

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

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
