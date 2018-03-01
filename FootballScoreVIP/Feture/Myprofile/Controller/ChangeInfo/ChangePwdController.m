//
//  ChangePwdController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "ChangePwdController.h"

// 修改密码

@interface ChangePwdController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *xinPwdTextFeild;
- (IBAction)sureButtonClick:(UIButton *)sender;
@property (nonatomic, copy) NSString * oldStr;
@property (nonatomic, copy) NSString * xinStr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTopCon;
@end

@implementation ChangePwdController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TWColorRGB(242, 242, 242);
    
    [[_oldPwdTextFeild rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _oldStr = x;
    }];
    [[_xinPwdTextFeild rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _xinStr = x;
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sureButtonClick:nil];
    return YES;
}

- (void)hiddenAllKeybord{
    [_oldPwdTextFeild resignFirstResponder];
    [_xinPwdTextFeild resignFirstResponder];
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    
    [self hiddenAllKeybord];
    
    // 0登录判断
    if ([[AccountTool sharedAccountTool] isLogin]) {
        // 1为空判断
        if (_oldStr == nil || _xinStr == nil || [_oldStr isEqualToString:@""] || [_xinStr isEqualToString:@""]) {
            [self showAlertVc:@"请将信息补充完整！"];
            return;
        }
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        
        // 3发送请求
        [SVProgressHUD show];
        
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        parameters[TWOldPassword] = _oldStr;
        parameters[TWLoginPassword] = _xinStr;
        parameters[TWUserID] = model.userId;
        
        [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWChangeUserInfoUrl parameters:parameters success:^(id responseObject) {
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功~"];
                
                AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
                // 更新密码
                model.tw_possword = _xinStr;
                
                // 将账户对象设置到单例对象中
                [AccountTool sharedAccountTool].accountModel = model;
                // 保存model对象————采取归档的方式
                [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
                
                
                
                // 修改账号中的密码
//                [[NSUserDefaults standardUserDefaults] setObject:_xinStr forKey:TWLoginPassword];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 发送通知让个人页面刷新头部
                [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
                
                // 去掉之前输入值
                _oldPwdTextFeild.text = @"";
                _xinPwdTextFeild.text = @"";
                
                // 退出当前页面
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"修改失败~"];
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"请先登录，在进行其他操作~"];
    } 
}

- (void)showAlertVc:(NSString *)message{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}
@end
