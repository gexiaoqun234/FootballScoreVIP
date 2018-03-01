//
//  BindingRealInfoViewController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/21.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "BindingRealInfoViewController.h"
#import "TWLoginData.h"
#import "TWLoginNetworkTool.h"

@interface BindingRealInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
- (IBAction)dismissButtonClick:(UIButton *)sender;
- (IBAction)unbundling:(UIButton *)sender;// 解绑

@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *IdCardNumberTextFeild;
- (IBAction)binding:(UIButton *)sender;// 绑定
@property (weak, nonatomic) IBOutlet UIButton *bingdingButton;

@property (nonatomic, copy) NSString * nameStr;
@property (nonatomic, copy) NSString * iphoneStr;
@property (nonatomic, copy) NSString * IDStr;
@end

@implementation BindingRealInfoViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[_nameTextFiled rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _nameStr = x;
    }];
    [[_phoneNumberTextFeild rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _iphoneStr = x;
    }];
    [[_IdCardNumberTextFeild rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _IDStr = x;
    }];
}

- (void)setupUI{
    _bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _bgView.layer.borderWidth = 2;
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.masksToBounds = YES;
    _bingdingButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _bingdingButton.layer.borderWidth = 3;
    _bingdingButton.layer.cornerRadius = 17;
    _bingdingButton.layer.masksToBounds = YES;
}



- (IBAction)dismissButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        _nameTextFiled.text = @"";
        _phoneNumberTextFeild.text = @"";
        _IdCardNumberTextFeild.text = @"";
        _nameStr = @"";
        _iphoneStr = @"";
        _IDStr = @"";
    }];
}

- (IBAction)unbundling:(UIButton *)sender {
}

- (IBAction)binding:(UIButton *)sender {
    // 0登录判断
    if ([[AccountTool sharedAccountTool] isLogin]) {
        // 1为空判断
        if (_nameStr == nil || _iphoneStr == nil || _IDStr == nil || [_nameStr isEqualToString:@""] || [_iphoneStr isEqualToString:@""] || [_IDStr isEqualToString:@""]) {
            [self showAlertVc:@"请将信息补充完整！"];
            return;
        }
        // 2校核手机号码
        NSString * phonenumber = [NSString valiMobile:_iphoneStr];
        if (![phonenumber isEqual:@"合格"]) {
            [self showAlertVc:phonenumber];
            return;
        }
        // 3发送请求
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        parameters[TWLoginPhoneNumber] = _iphoneStr;
        parameters[TWRealName] = _nameStr;
        parameters[TWIdCard] = _IDStr;
        AccountModel * model =  [[AccountTool sharedAccountTool] readAccount];
        parameters[TWUserID] =model.userId;
        
        [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWBandRealInfoUrl parameters:parameters success:^(id responseObject) {
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
                // 发送通知让个人页面刷新头部
                [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
            } else {
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            
        }];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"请先登录，在进行其他操作~"];
    }
}

#pragma mark --代理方法--
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddenAllKeybord];
    return YES;
}

- (void)hiddenAllKeybord{
    [_nameTextFiled resignFirstResponder];
    [_phoneNumberTextFeild resignFirstResponder];
    [_IdCardNumberTextFeild resignFirstResponder];
}

- (void)showAlertVc:(NSString *)message{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}

@end

