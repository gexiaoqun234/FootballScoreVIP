//
//  TWBuyCPViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/17.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWBuyCPViewController.h"
#import "TWGetOrdersModel.h"
#import "TWGetOrdersCell.h"
#import "TWOrderDetailViewController.h"

static NSString * const TWGetOrdersCellID = @"TWGetOrdersCell";

@interface TWBuyCPViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIImageView * nojiluImageView;
@property (nonatomic, strong) NSMutableArray <TWGetOrdersModel * > * ordersArray;
@end

@implementation TWBuyCPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self setupRefresh];
}


#pragma mark - ========刷新请求数据=======
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}

// 下拉刷新数据
- (void)loadNewData{
    [self.ordersArray removeAllObjects];
    AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:PersonalGetUserOrdersURL parameters:@{TWUserID:model.userId} success:^(id responseObject) {
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            self.ordersArray = [TWGetOrdersModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.ordersArray.count == 0) {
                [SVProgressHUD showErrorWithStatus:@"您还没有任何订单~"];
                [self.tableView addSubview:self.nojiluImageView];
            } else {
//                [SVProgressHUD showSuccessWithStatus:@"获取成功"];
                [self.tableView reloadData];
            }
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ordersArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWGetOrdersCell * cell = [tableView dequeueReusableCellWithIdentifier:TWGetOrdersCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.ordersArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TWOrderDetailViewController * orderDetailVC = [[TWOrderDetailViewController alloc]init];
    orderDetailVC.selectModel = self.ordersArray[indexPath.row];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

#pragma mark - ========懒加载=======
- (NSMutableArray<TWGetOrdersModel *> *)ordersArray{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray array];
    }
    return _ordersArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:@"TWGetOrdersCell" bundle:nil] forCellReuseIdentifier:TWGetOrdersCellID];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, (TWTabbarHeight) + 10, 0);
    }
    return _tableView;
}

- (UIImageView *)nojiluImageView{
    if (!_nojiluImageView) {
        UIImage * nojilu = [UIImage imageNamed:@"tw_NoJiLu"];
        _nojiluImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nojilu.size.width, nojilu.size.height)];
        _nojiluImageView.center = self.view.center;
        _nojiluImageView.image = nojilu;
    }
    return _nojiluImageView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
