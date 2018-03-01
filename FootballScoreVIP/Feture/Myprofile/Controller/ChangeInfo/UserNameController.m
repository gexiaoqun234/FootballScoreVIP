//
//  UserNameController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "UserNameController.h"

@interface UserNameController ()
@property (weak, nonatomic) IBOutlet UITextField *ueseNameTextFeild;
- (IBAction)sureButtonClick;
@property (nonatomic, copy) NSString * userString;
@end

@implementation UserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_ueseNameTextFeild rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        _userString = x;
    }];
}


- (IBAction)sureButtonClick {
    
    [_ueseNameTextFeild resignFirstResponder];
    
    // 0登录判断
    if ([[AccountTool sharedAccountTool] isLogin]) {
        // 1为空判断
        if (_userString == nil || [_userString isEqualToString:@""]) {
            [self showAlertVc:@"请将信息补充完整！"];
            return;
        }
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        // 3发送请求
        [SVProgressHUD show];
        
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        parameters[TWUsername] = _userString;
        parameters[TWUserID] = model.userId;
        
        [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWchangeUserSignInfoUrl parameters:parameters success:^(id responseObject) {
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                // 修改账号中的昵称
                model.username = _userString;
                [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
                // 将账户对象设置到单例对象中
                [AccountTool sharedAccountTool].accountModel = model;
                // 发送通知让个人页面刷新头部
                [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
                
                // 清空
                _ueseNameTextFeild.text = @"";
                
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sureButtonClick];
    return YES;
}

@end
