//
//  ChangeInfoViewController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "ChangePwdController.h"
#import "ChangeSignController.h"
#import "UserNameController.h"

@interface ChangeInfoViewController ()
@property(nonatomic, strong) NSMutableArray * dataArr;
@property(nonatomic, strong) NSMutableArray * dataImageArr;
@property(nonatomic, strong) ChangePwdController * pwdVc;
@property(nonatomic, strong) ChangeSignController * signVc;
@property(nonatomic, strong) UserNameController * userVc;
@end

@implementation ChangeInfoViewController

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithObjects:@"用户密码修改",@"用户签名修改",@"用户昵称修改", nil];
    }
    return _dataArr;
}

- (NSMutableArray *)dataImageArr{
    if (_dataImageArr == nil) {
        _dataImageArr = [NSMutableArray arrayWithObjects:@"tw_pass_change",@"tw_sign_change",@"tw_nickname_change", nil];
    }
    return _dataImageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TWColorRGB(242, 242, 242);
    _pwdVc = [[ChangePwdController alloc]init];
    _signVc = [[ChangeSignController alloc]init];
    _userVc = [[UserNameController alloc]init];
    self.title = @"修改个人信息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text = self.dataArr[indexPath.section];
        cell.imageView.image = [UIImage imageNamed:self.dataImageArr[indexPath.section]];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        _pwdVc.title = @"修改密码";
        [self.navigationController pushViewController:_pwdVc animated:YES];
    } else if (indexPath.section == 1) {
        _signVc.title = @"修改签名";
        [self.navigationController pushViewController:_signVc animated:YES];
    } else if (indexPath.section == 2) {
        _userVc.title = @"修改昵称";
        [self.navigationController pushViewController:_userVc animated:YES];
    }
}


@end
