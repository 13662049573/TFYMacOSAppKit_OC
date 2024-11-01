//
//  MainViewController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "MainViewController.h"
#import "TFYCustomBtn.h"

@interface MainViewController ()<TFYTextFieldNotifyingDelegate,TFYSecureTextFieldNotifyingDelegate>
@property (nonatomic , strong) NSView *backView;
@property(nonatomic , strong)NSButton *buttom;
@property(nonatomic , strong)NSPopUpButton *popbuttom;
@property (nonatomic , strong) TFYLabel *label;
@property (nonatomic , strong) TFYTextField *textField;
@property(nonatomic , strong) TFYSecureTextField *securetextField;
@property(nonatomic , strong) TFYCustomBtn *btn;
@end

@implementation MainViewController

- (void)loadView {
    NSRect frame = CGRectMake(0, 0, 1100, 680);
    NSView *view = [[NSView alloc]initWithFrame:frame];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.buttom];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.securetextField];
    
    [self.label tfy_changeColorWithTextColor:NSColor.redColor changeText:@"数据"];

    [self.view addSubview:self.popbuttom];

}

- (NSPopUpButton *)popbuttom {
    if (!_popbuttom) {
        _popbuttom = NSPopUpButtonSet();
        _popbuttom.makeChain
            .pullsDown(NO)
            .autoenablesItems(YES)
            .preferredEdge(NSRectEdgeMinY)
            .addItemsWithTitles(@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"10", @"11", @"12", @"13"])
            .selectItemAtIndex(0)
            .addTarget(self, @selector(popUpButtonAction:))
            .frame(CGRectMake(80, 100, 200, 40));
    }
    return _popbuttom;
}

- (TFYCustomBtn *)btn {
    if (!_btn) {
        _btn = [[TFYCustomBtn alloc] initWithFrame:CGRectMake(20, 200, 400, 50)];
        _btn.isHandCursor = YES;
        _btn.defaultTitle = @"未选中";
        _btn.selectedTitle = @"已选中";
        _btn.defaultTitleColor = [NSColor whiteColor];
        _btn.selectedTitleColor = [NSColor blackColor];
        _btn.defaultFont = [NSFont systemFontOfSize:20];
        _btn.selectedFont = [NSFont systemFontOfSize:10];
        _btn.defaultBackgroundColor = [NSColor greenColor];
        _btn.selectedBackgroundColor = [NSColor blueColor];
        _btn.defaultBackgroundImage = [NSImage imageNamed:@""];
        _btn.selectedBackgroundImage = [NSImage imageNamed:@""];
        _btn.rectCorners = TFYRectCornerTopLeft|TFYRectCornerBottomLeft;
        _btn.radius = 15;
        _btn.textAlignment = TFYTextAlignmentLeft;
        [_btn setTarget:self];
        [_btn setAction:@selector(paymentBtnClick:)];
    }
    return _btn;
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

- (void)popUpButtonAction:(id)sender {
    NSPopUpButton *popUpButton = (NSPopUpButton *)sender;
    NSInteger selectedIndex = [popUpButton indexOfSelectedItem];
    NSString *selectedTitle = [popUpButton titleOfSelectedItem];
    
    // 处理选中项
    NSLog(@"选中的菜单项索引: %ld, 标题: %@", (long)selectedIndex, selectedTitle);
}


- (NSButton *)buttom {
    if (!_buttom) {
        _buttom = [[NSButton alloc] initWithFrame:NSMakeRect(50, 600, self.view.macos_width-100, 40)];
        _buttom.makeChain
            .title(@"获取验证码")
            .wantsLayer(YES)
            .layerBackGroundColor(NSColor.orangeColor)
            .cornerRadius(8)
            .textColor(NSColor.redColor)
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
        .frame(NSMakeRect(50, 500, self.view.macos_width-100, 40))
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
        .Xcursor(80)
        .delegateCustomize(self)
        .frame(NSMakeRect(50, 400, self.view.macos_width-100, 40))
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

- (TFYSecureTextField *)securetextField {
    if (!_securetextField) {
        _securetextField = TFYSecureTextFieldSet();
        _securetextField.makeChain
        .delegateCustomize(self)
        .isTextAlignmentVerticalCenter(YES)
        .Xcursor(10)
        .frame(NSMakeRect(50, 300, self.view.macos_width-100, 40))
        .font([NSFont systemFontOfSize:14 weight:NSFontWeightMedium])
        .alignment(NSTextAlignmentRight)
        .placeholderString(@"请输入密码")
        .wantsLayer(YES)
        .placeholderStringColor(NSColor.purpleColor)
        .layerBackGroundColor(NSColor.orangeColor)
        .borderColor(NSColor.blueColor.CGColor)
        .borderWidth(1)
        .masksToBounds(YES)
        .textColor(NSColor.blackColor)
        .cornerRadius(20)
        .bordered(NO)
        .focusRingType(NSFocusRingTypeNone);
    }
    return _securetextField;
}


- (void)paymentBtnClick:(NSButton *)btn {
    [btn tfy_startTimer:^(NSString * _Nonnull time, NSInteger type) {
        btn.makeChain
            .title(time)
            .textColor(NSColor.redColor);
    }];
}

-(void)textFieldDidChange:(NSTextField *_Nullable)textField {
    NSLog(@"输入===：%@",textField.stringValue);
}

-(void)securetextFieldDidChange:(NSSecureTextField *_Nullable)textField {
    NSLog(@"密码输入===：%@",textField.stringValue);
}

@end
