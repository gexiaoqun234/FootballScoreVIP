//
//  ChangePasswordViewController.m
//  QQCPNEW
//
//  Created by 田伟 on 2017/7/3.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@property(nonatomic, copy) NSString * phoneNumberStr;
@property(nonatomic, copy) NSString * securityNumberStr;
@property(nonatomic, copy) NSString * strTimeStr;
@property(nonatomic, copy) NSString * passwordString;
@property(nonatomic, strong) dispatch_source_t timers;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    self.getCodeBottom.layer.cornerRadius = 3;
    self.getCodeBottom.layer.masksToBounds = YES;
}

#pragma mark --监听点击--
- (IBAction)phonenumberValueChanged:(UITextField *)sender {
    self.phoneNumberStr = sender.text;
}

- (IBAction)securityNumberValueChanged:(UITextField *)sender {
    self.securityNumberStr = sender.text;
}

- (IBAction)getCodeBtnClick:(UIButton *)sender {
    
    // 手机号码核对
    NSString * phonenumber = [NSString valiMobile:self.phoneNumberStr];
    if (![phonenumber isEqual:@"合格"]) {
        [self showAlertVc:phonenumber];
        return;
    }
    
#pragma mark --获取验证码时的UI显示--
    __block int timeout= 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建一个定时器(dispatch_source_t本质还是个OC对象,创建出来的对象需要强引用)
    self.timers = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)); //比当前时间晚1秒
    //    dispatch_time_t start = DISPATCH_TIME_NOW;// 当前时间执行
    uint64_t interval= 1.5 * NSEC_PER_SEC;
    dispatch_source_set_timer(self.timers, start, interval, 0); // NSEC_PER_SEC 纳秒
    // 设置回调
    dispatch_source_set_event_handler(self.timers, ^{
        timeout--;
        // 记好了刷新UI的时候一定要在主队列中刷新,就是主线程.
        dispatch_async(dispatch_get_main_queue(), ^{
            _getCodeBottom.userInteractionEnabled=NO;
            [_getCodeBottom setTitle:[NSString stringWithFormat:@"已发送(%02d)",timeout] forState:UIControlStateNormal];
            if (timeout == 1) {
                [_getCodeBottom setTitle:@"发送验证码" forState:UIControlStateNormal];
                _getCodeBottom.userInteractionEnabled = YES;
                dispatch_cancel(self.timers);
                self.timers = nil;
            }
        });
    });
    // 启动定时器
    dispatch_resume(self.timers);
    
    
#pragma mark --发送获取验证码请求--
    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginSendCodeUrl parameters:@{TWLoginPhoneNumber:self.phoneNumberStr} success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            
            self.strTimeStr = responseObject[@"result"][@"strTime"];
            NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            [self showAlertVc:message];
            
        } else {
            [self showAlertVc:@"短息发送异常！"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
    }];
}

- (IBAction)newPasswordValueChanged:(UITextField *)sender {
    self.passwordString = sender.text;
}

// 确认修改
- (IBAction)ChangePasswordBtnClick:(UIButton *)sender {
    [self hiddenKeybord];
    if ([self.phoneNumberStr isEqualToString:@""] || [self.securityNumberStr isEqualToString:@""] || [self.passwordString isEqualToString:@""]) {
        [self showAlertVc:@"请将信息填充完整！"];
        return;
    }
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[TWLoginPhoneNumber] = self.phoneNumberStr;
    parameters[TWLoginPassword] = self.passwordString;
    parameters[TWLoginCode] = self.securityNumberStr;
    parameters[TWLoginStrTime] = self.strTimeStr;
    
    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWForgetPwdUrl parameters:parameters success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            
            AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
            // 更新密码
            model.tw_possword = self.passwordString;
            
            // 将账户对象设置到单例对象中
            [AccountTool sharedAccountTool].accountModel = model;
            // 保存model对象————采取归档的方式
            [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
            
            
            // 更新保存的信息
//            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberStr forKey:TWLoginPhoneNumber];
//            [[NSUserDefaults standardUserDefaults] setObject:self.passwordString forKey:TWLoginPassword];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // 清空
            self.phonenumberTetxtFeild.text = @"";
            self.securityNumberTextFeild.text = @"";
            self.passwordTextf.text = @"";
            
            // 发送通知让个人页面刷新头部
            [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"重设密码失败"];
    }];
}

#pragma mark --私有方法--
- (void)showAlertVc:(NSString *)message{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)hiddenKeybord{
    [self.phonenumberTetxtFeild resignFirstResponder];
    [self.securityNumberTextFeild resignFirstResponder];
    [self.passwordTextf resignFirstResponder];
}

@end
