//
//  MainViewController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "MainViewController.h"


@interface MainViewController ()<TFYTextFieldNotifyingDelegate>
@property (nonatomic , strong) NSView *backView;
@property(nonatomic , strong)NSButton *buttom;
@property (nonatomic , strong) TFYLabel *label;
@property (nonatomic , strong) TFYTextField *textField;
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
    
    [self.view addSubview:self.buttom];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textField];
    
    [self.label tfy_changeColorWithTextColor:NSColor.redColor changeText:@"数据"];
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

- (NSButton *)buttom {
    if (!_buttom) {
        _buttom = [[NSButton alloc] initWithFrame:NSMakeRect(50, 600, self.view.bounds.size.width-100, 40)];
        _buttom.makeChain
            .title(@"获取验证码")
            .wantsLayer(YES)
            .layerBackGroundColor(NSColor.orangeColor)
            .cornerRadius(8)
            .textColor(NSColor.whiteColor)
            .bezelStyle(NSBezelStyleTexturedSquare)
            .font([NSFont systemFontOfSize:12 weight:NSFontWeightHeavy])
            .addTarget(self, @selector(paymentBtnClick:));
    }
    return _buttom;
}

- (TFYLabel *)label {
    if (!_label) {
        _label = TFYLabelSet();
        _label.makeChain
        .actionBlock(^(__kindof TFYLabel * _Nonnull sender) {
            NSLog(@"点击文字");
        })
        .isTextAlignmentVerticalCenter(YES)
        .frame(NSMakeRect(50, 500, self.view.bounds.size.width-100, 40))
        .font([NSFont systemFontOfSize:14 weight:NSFontWeightMedium])
        .stringValue(@"点击测试互数据")
        .textColor(NSColor.whiteColor)
        .layerBackGroundColor(NSColor.orangeColor)
        .alignment(NSTextAlignmentCenter);
    }
    return _label;
}

- (TFYTextField *)textField {
    if (!_textField) {
        _textField = TFYTextFieldSet();
        _textField.makeChain
        .isTextAlignmentVerticalCenter(YES)
        .Xcursor(10)
        .delegateCustomize(self)
        .frame(NSMakeRect(50, 400, self.view.bounds.size.width-100, 40))
        .font([NSFont systemFontOfSize:14 weight:NSFontWeightMedium])
        .placeholderString(@"请输入文字")
        .wantsLayer(YES)
        .placeholderStringColor(NSColor.purpleColor)
        .layerBackGroundColor(NSColor.whiteColor)
        .borderColor(NSColor.redColor.CGColor)
        .borderWidth(1)
        .masksToBounds(YES)
        .textColor(NSColor.blackColor)
        .cornerRadius(20)
        .bordered(NO)
        .focusRingType(NSFocusRingTypeNone);
    }
    return _textField;
}

- (void)paymentBtnClick:(NSButton *)btn {
    
}

-(void)textFieldDidChange:(NSTextField *_Nullable)textField {
    NSLog(@"输入===：%@",textField.stringValue);
}

@end
