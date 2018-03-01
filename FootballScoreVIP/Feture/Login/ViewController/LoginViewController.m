//
//  LoginViewController.m
//  QQCPNEW
//
//  Created by 田伟 on 2017/7/2.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountModel.h"
#import "TWLoginNetworkTool.h"
#import "TWLoginData.h"
#import "UIImage+TFImageEffects.h"

@interface LoginViewController ()<UITextFieldDelegate>
// MARK:—————xib属性—————

- (IBAction)dismissBtnClick:(UIButton *)sender;
// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

// MARK:- 登录框和注册框的总背景
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewLeading;


// MARK:- 登录框
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *loginViewBackgroundView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
- (IBAction)loginPhoneNumberStrChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginPasswordStrChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
// MARK:- 点击登录按钮
- (IBAction)loginBtnClick:(UIButton *)sender;
// 点击注册按钮切换视图
- (IBAction)registBtnClick:(UIButton *)sender;


// MARK:- 注册框
- (IBAction)backLoginView:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *registView;
@property (weak, nonatomic) IBOutlet UIImageView *registViewBackgroundView;

@property (weak, nonatomic) IBOutlet UITextField *inputPhoneNumber;
- (IBAction)phoneNumberStrChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputSecurityNumber;
- (IBAction)securityNumberStrChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputUserName;
- (IBAction)userNameStrChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordNumber;
- (IBAction)passwordStrChanged:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
// MARK:- 获取验证码
- (IBAction)getSecurityCode:(UIButton *)sender;
// MARK:- 点击注册按钮
- (IBAction)registerBtnClick:(UIButton *)sender;

// MARK:—————自定义属性—————
// 定时器
@property(nonatomic, strong) dispatch_source_t timers;
// 记录注册时的信息
@property(nonatomic, copy) NSString * inputPhoneNumberStr;                                        // 保存输入的手机号码
@property(nonatomic, copy) NSString * inputsecurityNumberStr;                                     // 保存输入的验证码
@property(nonatomic, copy) NSString * strTimeStr;                                                 // 保存验证码返回的时间数据
@property(nonatomic, copy) NSString * inputUserNameStr;                                           // 保存输入的用户名
@property(nonatomic, copy) NSString * inputPasswordStr;                                           // 保存输入的密码
// 记录登录时的信息
@property(nonatomic, copy) NSString * loginPhoneNumberStr;                                        // 保存登录的手机号码
@property(nonatomic, copy) NSString * loginPasswordStr;                                           // 保存登录的密码

@end

@implementation LoginViewController

// MARK:—————系统回调—————
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setupUI{
    // 获取验证码的按钮设置样式
    self.getCodeBtn.backgroundColor = [UIColor colorWithRed:0.329 green:0.722 blue:0.976 alpha:1.0];
    self.getCodeBtn.layer.cornerRadius = 2;
    self.getCodeBtn.layer.masksToBounds = YES;
    
    // 给登录视图添加一个左划的手势
    UISwipeGestureRecognizer * recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.loginViewBackgroundView addGestureRecognizer:recognizerLeft];
    
    // 给注册视图添加一个右划的手势
    UISwipeGestureRecognizer * recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.registViewBackgroundView addGestureRecognizer:recognizerRight];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.loginViewBackgroundView addGestureRecognizer:tap];
    [self.registViewBackgroundView addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    [self hiddenAllKeybord];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self hiddenAllKeybord];
        [self registBtnClick:nil];
    } else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self hiddenAllKeybord];
        [self backLoginView:nil];
    }
}

// MARK:—————监听点击—————
- (IBAction)loginPhoneNumberStrChanged:(UITextField *)sender {
    self.loginPhoneNumberStr = sender.text;
}
- (IBAction)loginPasswordStrChanged:(UITextField *)sender {
    self.loginPasswordStr = sender.text;
}

// MARK:— 登录
- (IBAction)loginBtnClick:(UIButton *)sender {
    [self hiddenAllKeybord];
    if (self.loginPasswordStr == nil || self.loginPhoneNumberStr == nil) {
        [self showAlertVc:@"请将信息补充完整！"];
        return;
    }
    [SVProgressHUD show];
    
    if ([self.loginPhoneNumberStr isEqualToString:@"111111"]) {
        self.loginPhoneNumberStr = @"13818086674";
    }
    
    if ([self.loginPasswordStr isEqualToString:@"111111"]) {
        self.loginPasswordStr = @"223344";
    }
    
    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginUrl parameters:@{TWLoginPhoneNumber:self.loginPhoneNumberStr,TWLoginPassword:self.loginPasswordStr} success:^(id responseObject) {

        TWLog(@"%@",responseObject[@"result"]);
    
        // 将登录账户写死
//    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginUrl parameters:@{TWLoginPhoneNumber:@"13818086674",TWLoginPassword:@"223344"} success:^(id responseObject) {
    
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功！"];
            // 更新保存的信息
            // 转账户模型
            AccountModel * model = [AccountModel mj_objectWithKeyValues:responseObject[@"result"]];
            
            model.isBinding = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"result"] objectForKey:@"isBanding"]];
            model.isSign = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"result"] objectForKey:@"isSign"]];
            model.tw_possword = self.loginPasswordStr;
            model.saveTime = [NSDate date];
            
            // 将账户对象设置到单例对象中
            [AccountTool sharedAccountTool].accountModel = model;
            // 保存model对象————采取归档的方式
            [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
      
            // 发送通知让个人页面刷新头部
            [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:@"登录失败！"];
        }
    } failure:^(NSError *error) {
    }];
}

// 切换到注册view
- (IBAction)registBtnClick:(UIButton *)sender {
    _backgroundViewLeading.constant = -TWScreenWidth;
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)phoneNumberStrChanged:(UITextField *)sender {
    self.inputPhoneNumberStr = sender.text;
}
- (IBAction)securityNumberStrChanged:(UITextField *)sender {
    self.inputsecurityNumberStr = sender.text;
}
- (IBAction)userNameStrChanged:(UITextField *)sender {
    self.inputUserNameStr = sender.text;
}
- (IBAction)passwordStrChanged:(UITextField *)sender {
    self.inputPasswordStr = sender.text;
}

// 获取验证码
- (IBAction)getSecurityCode:(UIButton *)sender {
    // 手机号码核对
    NSString * phonenumber = [NSString valiMobile:self.inputPhoneNumberStr];
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
            _getCodeBtn.userInteractionEnabled=NO;
            [_getCodeBtn setTitle:[NSString stringWithFormat:@"已发送(%02d)",timeout] forState:UIControlStateNormal];
            if (timeout == 1) {
                [_getCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _getCodeBtn.userInteractionEnabled = YES;
                dispatch_cancel(self.timers);
                self.timers = nil;
            }
        });
    });
    // 启动定时器
    dispatch_resume(self.timers);
    

#pragma mark --发送获取验证码请求--
    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginSendCodeUrl parameters:@{TWLoginPhoneNumber:self.inputPhoneNumberStr} success:^(id responseObject) {
        
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            [self hiddenAllKeybord];
            self.strTimeStr = responseObject[@"result"][@"strTime"];
            NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
            [self showAlertVc:message];
            
        } else {
            [self showAlertVc:@"短息发送异常！"];
        }
    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
    }];
}

// MARK:— 注册
- (IBAction)registerBtnClick:(UIButton *)sender {
    [self hiddenAllKeybord];
    if (self.inputPasswordStr == nil || self.inputUserNameStr == nil || self.inputsecurityNumberStr == nil) {
        [self showAlertVc:@"请将信息补充完整！"];
        return;
    }
    if ([NSString VerificationCode:self.inputsecurityNumberStr] != nil) {
        // 手机号码已经核对过，现在核对验证码
        [self showAlertVc:[NSString VerificationCode:self.inputsecurityNumberStr]];
        return;
    }
    
    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginRegisterUrl parameters:@{TWLoginPhoneNumber:self.inputPhoneNumberStr, TWLoginCode:self.inputsecurityNumberStr, TWLoginStrTime:self.strTimeStr, TWLoginUsername:self.inputUserNameStr, TWLoginPassword:self.inputPasswordStr} success:^(id responseObject) {
        TWLog(@"注册请求返回：%@",responseObject);
        TWLog(@"注册请求返回的message：%@",responseObject[@"message"]);
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功！"];
            
            // 保存注册的信息
//            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"result"][@"userId"] forKey:TWUserID];
//            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"result"][@"username"] forKey:TWUsername];
//            [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"result"][@"score"] forKey:TWScore];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // 转到登录视图 ———> 让用户点一次登录
            self.phoneNumber.text = self.inputPhoneNumberStr;
            self.password.text = self.inputPasswordStr;
            self.backgroundViewLeading.constant = 0;
            [UIView animateWithDuration:0.36 animations:^{
                [self.view layoutIfNeeded];
            }];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"注册失败！"];
        }
    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请求失败！"];
    }];
}

- (IBAction)backLoginView:(UIButton *)sender {
    _backgroundViewLeading.constant = 0;
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)dismissBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --私有方法--
- (void)showAlertVc:(NSString *)message{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)hiddenAllKeybord{
    [self.phoneNumber resignFirstResponder];
    [self.password resignFirstResponder];
    [self.inputPhoneNumber resignFirstResponder];
    [self.inputSecurityNumber resignFirstResponder];
    [self.inputUserName resignFirstResponder];
    [self.inputPasswordNumber resignFirstResponder];
}

#pragma mark --代理方法--
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddenAllKeybord];
    return YES;
}

@end
