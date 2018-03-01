//
//  TWNewsFootBallViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWNewsFootBallViewController.h"
#import "TWNewsModel.h"
#import "TWNewsCell.h"
#import "TWNewsDetailViewController.h"

@interface TWNewsFootBallViewController ()

@end

@implementation TWNewsFootBallViewController

#pragma mark - ========tableView懒加载=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [self.view addSubview:_tableView];
        // 适配ios11
        self.extendedLayoutIncludesOpaqueBars = YES;// 默认情况下, 扩展布局不包含导航栏
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(TitleViewHeight, 0, TWNaviHeight, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"TWNewsCell" bundle:nil] forCellReuseIdentifier:TWNewsCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [[SHNetworkTool shareInstance] getDiscoverNewsDataWithURL:DiscoverCopyFollowFootballURL Success:^(NSArray *newsArray) {
        _dataArray = [NSMutableArray arrayWithArray:newsArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSString *)subTitle{
    return @"足球资讯";
}

#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:TWNewsCellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TWNewsDetailViewController * detailVc = [[TWNewsDetailViewController alloc]init];
    detailVc.model = _dataArray[indexPath.row];
    detailVc.subTitle = self.subTitle;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
