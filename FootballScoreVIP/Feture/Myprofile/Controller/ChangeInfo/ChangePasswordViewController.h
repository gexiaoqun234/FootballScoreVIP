//
//  ChangePasswordViewController.h
//  QQCPNEW
//
//  Created by 田伟 on 2017/7/3.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "SHBaseViewController.h"

@interface ChangePasswordViewController : SHBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *phonenumberTetxtFeild;
- (IBAction)phonenumberValueChanged:(UITextField *)sender;

@property (weak, nonatomic) IBOutlet UITextField *securityNumberTextFeild;
- (IBAction)securityNumberValueChanged:(UITextField *)sender;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBottom;
- (IBAction)getCodeBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextf;

- (IBAction)newPasswordValueChanged:(UITextField *)sender;

- (IBAction)ChangePasswordBtnClick:(UIButton *)sender;


@end
