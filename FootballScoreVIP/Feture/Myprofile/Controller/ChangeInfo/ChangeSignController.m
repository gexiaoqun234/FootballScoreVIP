//
//  ChangeSignController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "ChangeSignController.h"

@interface ChangeSignController ()
@property (weak, nonatomic) IBOutlet UITextField *signTextField;
- (IBAction)sureButtonClick:(UIButton *)sender;
@property (nonatomic, copy) NSString * singStr;
@end

@implementation ChangeSignController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_signTextField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _singStr = x;
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sureButtonClick:nil];
    return YES;
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    
    [_signTextField resignFirstResponder];
    
    // 0登录判断
    if ([[AccountTool sharedAccountTool] isLogin]) {
        // 1为空判断
        if (_singStr == nil || [_singStr isEqualToString:@""]) {
            [self showAlertVc:@"请将信息补充完整！"];
            return;
        }
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        // 3发送请求
        [SVProgressHUD show];
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        parameters[TWUserSign] = _singStr;
        parameters[TWUserID] = model.userId;
    
        [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWchangeUserSignInfoUrl parameters:parameters success:^(id responseObject) {
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                
                // 修改账号中的签名
                model.userSign = _singStr;
                // 将账户对象设置到单例对象中
                [AccountTool sharedAccountTool].accountModel = model;
                [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
                
                // 发送通知让个人页面刷新头部
                [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
                
                // 情空
                _signTextField.text = @"";
                
                // 调回上个界面
                [self.navigationController popViewControllerAnimated:YES];
            
            } else {
                
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
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
