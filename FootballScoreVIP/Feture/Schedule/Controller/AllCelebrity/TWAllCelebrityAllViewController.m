//
//  TWAllCelebrityAllViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWAllCelebrityAllViewController.h"
#import "TWExplainListModel.h"
#import "TWExplainListCell.h"
#import "SHExplanationDetailViewController.h"
#import "SHCelebrityDatailViewController.h"

@interface TWAllCelebrityAllViewController ()<UITableViewDelegate, UITableViewDataSource, TWExplainListCellDelegate>
@property (nonatomic, strong) NSMutableArray <TWExplainListModel *> * dataArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation TWAllCelebrityAllViewController

#pragma mark - ========tableView懒加载=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        [_tableView registerNib:[UINib nibWithNibName:@"TWExplainListCell" bundle:nil] forCellReuseIdentifier:TWExplainListCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    _currentPage = 1;
}

#pragma mark - ========刷新请求数据=======
- (ExplainListType)type{
    return ExplainListTypeAll;
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

// 下拉刷新数据
- (void)loadNewData{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"cfrom"] = @"ios";
    parameters[@"channel"] = @"tzhongcp";
    parameters[@"page"] = @"1";
    parameters[@"playtype"] = @(self.type);
    parameters[@"type"] = @"1";
    parameters[@"version"] = @"1";
    [[SHNetworkTool shareInstance] getCelebrityExplanationAllCelebrityWith:parameters Success:^(NSArray *allCelebrityArray) {
        _dataArray = [NSMutableArray arrayWithArray:allCelebrityArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    _currentPage++;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"cfrom"] = @"ios";
    parameters[@"channel"] = @"tzhongcp";
    parameters[@"page"] = @(_currentPage);
    parameters[@"playtype"] = @(self.type);
    parameters[@"type"] = @"1";
    parameters[@"version"] = @"1";
    [[SHNetworkTool shareInstance] getCelebrityExplanationAllCelebrityWith:parameters Success:^(NSArray *allCelebrityArray) {
        [_dataArray addObjectsFromArray:allCelebrityArray];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _dataArray.count == 0;
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWExplainListCell * cell = [tableView dequeueReusableCellWithIdentifier:TWExplainListCellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHExplanationDetailViewController * explanationDetailViewController = [[SHExplanationDetailViewController alloc]init];
    explanationDetailViewController.dbnoString = _dataArray[indexPath.row].dbno;
    [self.navigationController pushViewController:explanationDetailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)topTapButtonDidClickDelegate:(TWExplainListCell *)cell{
    // 跳转到显示详情的页面
    SHCelebrityDatailViewController * celebrityDatailViewController = [[SHCelebrityDatailViewController alloc]init];
    celebrityDatailViewController.authNameString = cell.model.authName;
    [self.navigationController pushViewController:celebrityDatailViewController animated:YES];
}

@end
