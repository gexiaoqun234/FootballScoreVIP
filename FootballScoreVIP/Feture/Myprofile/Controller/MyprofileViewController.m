//
//  MyprofileViewController.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "MyprofileViewController.h"
#import "MineHeaderTopView.h"
#import "LoginOutCell.h"
#import "IconViewController.h"
#import "BindingRealInfoViewController.h"
#import "MySelectViewController.h"
#import "MySelectForumController.h"
#import "BuyViewController.h"
#import "TWBuyCPViewController.h"
#import "IntegralViewController.h"
#import "ChangeInfoViewController.h"
#import "ChangePasswordViewController.h"
#import "TWSectionToolCell.h"
#import "TWSectionCell.h"
#import "TWTime.h"


static NSString * const TWSectionCellID = @"TWSectionCellID";
static NSString * const TWSectionToolCellID = @"TWSectionToolCellID";


@interface MyprofileViewController ()<UITableViewDelegate, UITableViewDataSource, TWSectionToolCellDelagate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) MineHeaderTopView * headerView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * imageArray;

@property (nonatomic, strong) LoginViewController * loginVc;
@property (nonatomic, strong) IconViewController * IconVc;
@property (nonatomic, strong) BindingRealInfoViewController * bundingVc;
@property (nonatomic, strong) MySelectViewController * selectVc;
@property (nonatomic, strong) MySelectForumController * selectForumVc;
@property (nonatomic, strong) BuyViewController * buyVc;
@property (nonatomic, strong) TWBuyCPViewController * wantToBuyVc;
@property (nonatomic, strong) ChangeInfoViewController * changeInfoVc;
@property (nonatomic, strong) IntegralViewController * IntegralVc;
@property (nonatomic, strong) ChangePasswordViewController * forgetPwdVc;
@end

@implementation MyprofileViewController

- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        NSArray * collectArr = @[@"tw_youhuoquan",@"collection"];
        NSArray * personageArr = @[ @"detailedQuery",@"realInformation"];
        NSArray * loginArr = @[@"personalInformationChanges",@"forgotpassword"];
        NSArray * loginOutArr = @[@"cancellation"];
        _imageArray = [NSMutableArray arrayWithObjects:collectArr,personageArr,loginArr,loginOutArr, nil];
    }
    return _imageArray;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSArray * collectArr = @[@"优惠券",@"资讯收藏"];
        NSArray * personageArr = @[ @"个人积分明细",@"绑定真实信息"];
        NSArray * loginArr = @[@"修改个人信息",@"忘记密码"];
        NSArray * loginOutArr = @[@"退出登录"];
        _dataArray = [NSMutableArray arrayWithObjects:collectArr,personageArr,loginArr,loginOutArr, nil];
    }
    return _dataArray;
}

- (MineHeaderTopView *)headerView{
    if (!_headerView) {
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        CGFloat signH = [UILabel calculateHeight:model.userSign withMaxSize:CGSizeMake(TWScreenWidth - 20, MAXFLOAT) withFont:[UIFont systemFontOfSize:12]];
        CGFloat topViewH = 44 + TWMargin + TWMargin + 60 + TWMargin + 20 + 10 + signH + TWMargin * 3;
        _headerView = [[MineHeaderTopView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, topViewH)];
        _headerView.mineModel = model;
        [_headerView.iconImageViewSingal subscribeNext:^(id  _Nullable x) {
            [self topHeaderViewIconImageViewDidClick];
        }];
    }
    return _headerView;
}

// 修改头像
- (void)topHeaderViewIconImageViewDidClick{
    if ([AccountTool sharedAccountTool].isLogin) {
        [self presentViewController:_IconVc animated:YES completion:nil];
    } else{
        [self presentViewController:_loginVc animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([AccountTool sharedAccountTool].isLogin) {
        // 已经登录
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        NSDate * now = [NSDate date];
        //        NSLog(@"saveTime:%@  ***  now____%@",model.saveTime,now);
        if (![TWTime isSameDay:model.saveTime date2:now]) {
            //            NSLog(@"已经隔了一分钟");
            // 不是同一天，刷新请求
            [self refreshButtonDidClick];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewController];
    [self setupTableView];
    [self setupNavBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeaderView) name:TWPersonageVcRefreshHeaderNotification object:nil];
    self.view.backgroundColor = TWRandomColor;
}

- (void)refreshHeaderView{
    // 刷新视图
    [self.tableView reloadData];
    if ([AccountTool sharedAccountTool].isLogin) {
        // 已经登录,刷新下视图
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        self.headerView.mineModel = model;
        //        _headerView.mineModel = model;
    } else {
        // 注销
        AccountModel * model = [[AccountModel alloc]init];
        model.username = @"您还未登录";
        model.userSign = @"登录后可以设置签名";
        self.headerView.mineModel = model;
        //        _headerView.mineModel = model;
    }
}

- (void)initViewController{
    _loginVc = [[LoginViewController alloc]init];
    _IconVc = [[IconViewController alloc]init];
    _IntegralVc = [[IntegralViewController alloc]init];
    _bundingVc = [[BindingRealInfoViewController alloc]init];
    _changeInfoVc = [[ChangeInfoViewController alloc]init];
    _forgetPwdVc = [[ChangePasswordViewController alloc]init];
}

- (void)setupNavBar{
    // 刷新按钮
    UIButton * refreahButton = [UIButton createBttonWithFrame:CGRectZero titleText:@"" imageName:@"tw_refresh_mine" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
    [refreahButton sizeToFit];
    [refreahButton addTarget:self action:@selector(refreshButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:refreahButton];
}

- (void)refreshButtonDidClick{
    if ([AccountTool sharedAccountTool].isLogin) {
        // 刷新
        [SVProgressHUD showWithStatus:@"更新个人信息中~"];
        
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        // 重新请求个人信息
        NSString * phoneNumber = model.phoneNumber;
        NSString * password = model.tw_possword;
        
        [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginUrl parameters:@{TWLoginPhoneNumber:phoneNumber,TWLoginPassword:password} success:^(id responseObject) {
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"更新成功！"];
                [SVProgressHUD dismissWithDelay:0.5];
                // 更新保存的信息
                // 转账户模型
                AccountModel * model = [AccountModel mj_objectWithKeyValues:responseObject[@"result"]];
                model.isBinding = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"result"] objectForKey:@"isBanding"]];
                model.tw_possword = password;
                model.saveTime = [NSDate date];
                
                // 将账户对象设置到单例对象中
                [AccountTool sharedAccountTool].accountModel = model;
                // 保存model对象————采取归档的方式
                [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
                
                //                    [[NSUserDefaults standardUserDefaults] setObject:model.username forKey:TWUsername];
                //                    [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 发送通知让个人页面刷新头部
                [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
                //                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
                
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"刷新失败！"];
        }];
    } else {
        // 还未登录
        [self presentViewController:_loginVc animated:YES completion:nil];
    }
}


#pragma mark --UI界面
- (void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TWNaviHeight, TWScreenWidth, TWScreenHeight - (TWTabbarHeight) - (TWNaviHeight)) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = TWColorRGB(242, 242, 242);
    [self.tableView registerNib:[UINib nibWithNibName:@"TWSectionCell" bundle:nil] forCellReuseIdentifier:TWSectionCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"TWSectionToolCell" bundle:nil] forCellReuseIdentifier:TWSectionToolCellID];
    self.tableView.tableHeaderView = self.headerView;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
}

#pragma mark --代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [[UIView alloc]init];
    header.backgroundColor = TWColorRGB(242, 242, 242);
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    } else {
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.dataArray[section - 1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TWSectionToolCell * cell = [tableView dequeueReusableCellWithIdentifier:TWSectionToolCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.mineModel = [[AccountTool sharedAccountTool] readAccount];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        TWSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:TWSectionCellID forIndexPath:indexPath];
        cell.tw_titleLabel.text = self.dataArray[indexPath.section - 1][indexPath.row];
        cell.tw_titleLabel.font = [UIFont systemFontOfSize:14];
        cell.iconImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section - 1][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 已经登录
    if ([AccountTool sharedAccountTool].isLogin) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                // 选号收藏
                _selectVc = [[MySelectViewController alloc]init];
                [self.navigationController pushViewController:_selectVc animated:YES];
            } else if (indexPath.row == 1) {
                // 资讯收藏
                _selectForumVc = [[MySelectForumController alloc]init];
                [self.navigationController pushViewController:_selectForumVc animated:YES];
            }
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                // 个人积分明细
                [self.navigationController pushViewController:_IntegralVc animated:YES];
            } else if (indexPath.row == 1) {
                // 绑定真实信息
                [self attestationClick];
            }
        } else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                // 修改个人信息
                [self.navigationController pushViewController:_changeInfoVc animated:YES];
            } else if (indexPath.row == 1) {
                // 忘记密码
                [self.navigationController pushViewController:_forgetPwdVc animated:YES];
            }
        } else if (indexPath.section == 4) {
            // 退出登录
            UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出当前账号么？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [SVProgressHUD show];
                AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
                [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWLoginOutUrl parameters:@{TWUserID:model.userId} success:^(id responseObject) {
                    // 删除归档文件
                    if ([[AccountTool sharedAccountTool] deleteAccount]) {
                        // 更新保存
                        //                            [[NSUserDefaults standardUserDefaults] setObject:TWUserID forKey:TWUserID];
                        //                            [[NSUserDefaults standardUserDefaults] setObject:TWUsername forKey:TWUsername];
                        //                            [[NSUserDefaults standardUserDefaults] setObject:TWScore forKey:TWScore];
                        //                            [[NSUserDefaults standardUserDefaults] synchronize];
                        // 刷新头部
                        [self refreshHeaderView];
                        [SVProgressHUD showSuccessWithStatus:@"退出成功~"];
                        [SVProgressHUD dismissWithDelay:0.5];
                        
                    } else {
                        [SVProgressHUD showSuccessWithStatus:@"退出失败~"];
                    }
                } failure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                }];
            }];
            [alertC addAction:cancelAction];
            [alertC addAction:action];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    } else {
        // 未登录
        [self presentViewController:_loginVc animated:YES completion:nil];
    }
}

// 绑定信息
- (void)attestationClick{
    if ([AccountTool sharedAccountTool].isLogin) {
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        if ([model.isBinding isEqualToString:@"1"]) {
            // 已绑定
            [SVProgressHUD showSuccessWithStatus:@"已绑定，谢谢~"];
            [SVProgressHUD dismissWithDelay:0.5];
        } else {
            _bundingVc.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:_bundingVc animated:YES completion:nil];
        }
    } else{
        [self presentViewController:_loginVc animated:YES completion:nil];
    }
}

#pragma mark - ========TWSectionToolCellDelagate=======
- (void)attestationButtonDidClick{
    if([AccountTool sharedAccountTool].isLogin) {
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        if ([model.isBinding isEqualToString:@"1"]) {
            // 已绑定
            [SVProgressHUD showSuccessWithStatus:@"已绑定，谢谢~"];
            [SVProgressHUD dismissWithDelay:0.5];
        } else if([model.isBinding isEqualToString:@"0"]) {
            _bundingVc.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:_bundingVc animated:YES completion:nil];
        }
    } else{
        [self presentViewController:_loginVc animated:YES completion:nil];
    }}

- (void)signButtonDidClick{
    if ([[AccountTool sharedAccountTool] isLogin]) {
        
        // 已经登录
        [SVProgressHUD show];
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        
        if ([[NSString stringWithFormat:@"%@",model.isSign] isEqualToString:@"0"]) {
            // 签到请求
            [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWUserSignUrl parameters:@{TWUserID:model.userId} success:^(id responseObject) {
                
                // 请求成功
                if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                    [SVProgressHUD showSuccessWithStatus:@"签到成功~"];
                    
                    // 修改账号信息
                    model.isSign = responseObject[@"result"][@"isSign"];
                    model.score = responseObject[@"result"][@"score"];
                    model.level = responseObject[@"result"][@"level"];
                    
                    // 将账户对象设置到单例对象中
                    [AccountTool sharedAccountTool].accountModel = model;
                    [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
                    
                    // 刷新视图
                    [self refreshHeaderView];
                } else {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
                }
                
            } failure:^(NSError *error) {
                
                // 请求失败
                
            }];
        } else if ([model.isSign isEqualToString:@"1"]){
            [SVProgressHUD showInfoWithStatus:@"今天已经签到过啦~"];
            [SVProgressHUD dismissWithDelay:0.5];
        } else {
            TWLog(@"model的isSign属性的值为——————————%@——————————",model.isSign);
        }
    } else{
        
        // 还未登录
        [self presentViewController:_loginVc animated:YES completion:nil];
        
    }
}

- (void)gradeButtonDidClick{
    TWLog(@"目前只是展示等级");
}

- (void)integralButtonDidClick{
    TWLog(@"目前只是展示积分");
}

@end
