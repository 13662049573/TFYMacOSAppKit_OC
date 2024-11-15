//
//  MainViewController.m
//  TFYMacOSAppKit_OC
//
//  Created by 田风有 on 2023/2/13.
//

#import "MainViewController.h"

@interface MainViewController ()<TFYTextFieldNotifyingDelegate,TFYSecureTextFieldNotifyingDelegate>
@property (nonatomic , strong) NSView *backView;
@property(nonatomic , strong)NSButton *buttom;
@property(nonatomic , strong)NSPopUpButton *popbuttom;
@property (nonatomic , strong) TFYLabel *label;
@property (nonatomic , strong) TFYTextField *textField;
@property(nonatomic , strong) TFYSecureTextField *securetextField;
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
    
    [self.label tfy_changeLineSpaceWithTextLineSpace:5];
    [self.label tfy_changeColorWithTextColor:NSColor.redColor changeTexts:@[@"《用户协议》",@"《隐私政策》"]];
    
    [self.view addSubview:self.popbuttom];
    
    // 添加点击手势识别器
    NSClickGestureRecognizer *clickGesture = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldClicked:)];
    [self.label addGestureRecognizer:clickGesture];
}

- (void)textFieldClicked:(NSClickGestureRecognizer *)event {
    LinkInfo *type = LinkInfo.new;
    type.key = @"《用户协议》";
    type.value = @"https://leidianshare.mianzhikeji.com/index.html#/thunder/user";
    
    LinkInfo *type2 = LinkInfo.new;
    type2.key = @"《隐私政策》";
    type2.value = @"https://leidianshare.mianzhikeji.com/index.html#/thunder/privacy";
    
    [self.label didTapLabelAttributedText:@[type,type2] action:^(NSString * _Nonnull key, NSString * _Nullable value) {
        [[NSWorkspace sharedWorkspace]openURL:[NSURL URLWithString:value]];
    } lineFragmentPadding:5];
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
            .frame(CGRectMake(50,450, 200, 40));
    }
    return _popbuttom;
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
        .frame(NSMakeRect(50, 320, self.view.macos_width-100,100))
        .font([NSFont systemFontOfSize:14 weight:NSFontWeightMedium])
        .stringValue(@"感谢您信任并使用雷电加速器!我们非常重视您的隐私保护和个人信息保护。请认真阅读 《用户协议》和《隐私政策》的所有条款。1.为向您提供网络加速、用户注册登录等相关服务，我们会根据您使用服务的具体功能需要，收集必要的用户信息。2.为保障您的账号与使用安全，提升加速体验，您需要授权我们读取相关设备信息。您有权拒绝或取消授权。3.未经您授权，我们不会与第一方共享或对外提供您的信息。您点击“同意”即表示您已经阅读并同意以上协议的全部内容。;")
        .textColor(NSColor.blackColor)
        .layerBackGroundColor(NSColor.orangeColor);
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
        .frame(NSMakeRect(50, 550, self.view.macos_width-100, 40))
        .font([NSFont systemFontOfSize:14 weight:NSFontWeightMedium])
        .placeholderString(@"请输入文字")
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
        .frame(NSMakeRect(50, 500, self.view.macos_width-100, 40))
        .font([NSFont systemFontOfSize:14 weight:NSFontWeightMedium])
        .alignment(NSTextAlignmentRight)
        .placeholderString(@"请输入密码")
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
