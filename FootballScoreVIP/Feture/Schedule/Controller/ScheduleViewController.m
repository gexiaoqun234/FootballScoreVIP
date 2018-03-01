//
//  ScheduleViewController.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "ScheduleViewController.h"
#import "TWExplainListModel.h"
#import "SHExplanationDetailViewController.h"
#import "SHCelebrityDatailViewController.h"
#import "SHAllCelebrityViewController.h"

@interface ScheduleViewController ()<TWExplainListCellDelegate>
@property (nonatomic, strong) NSMutableArray <TWExplainListModel *> * explainListArray;
@property (nonatomic, assign) BOOL showEmpty;
@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showEmpty = NO;
    [self.view addSubview:self.tableView];
    [self setupScheduleData];
}

- (void)setupScheduleData{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadScheduleData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadScheduleData{
    [SVProgressHUD show];
    [[SHNetworkTool shareInstance] getCelebrityExplanationExplainListDataSuccess:^(NSArray *ExplainListArray) {
        _explainListArray = [NSMutableArray arrayWithArray:ExplainListArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        self.loading = NO;
        _showEmpty = NO;
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
        _showEmpty = YES;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _explainListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWExplainListCell * cell = [tableView dequeueReusableCellWithIdentifier:TWExplainListCellID forIndexPath:indexPath];
    cell.model = _explainListArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHExplanationDetailViewController * explanationDetailViewController = [[SHExplanationDetailViewController alloc]init];
    explanationDetailViewController.dbnoString = _explainListArray[indexPath.row].dbno;
    [self.navigationController pushViewController:explanationDetailViewController animated:YES];
}

// 是否显示
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return _showEmpty;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [super emptyDataSet:scrollView didTapButton:button];
    [self.tableView.mj_header beginRefreshing];
}

// 设置组间距
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self createFooterView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return TableViewSectionHeaderHeight;
}

- (void)topTapButtonDidClickDelegate:(TWExplainListCell *)cell{
    // 跳转到显示详情的页面
    SHCelebrityDatailViewController * celebrityDatailViewController = [[SHCelebrityDatailViewController alloc]init];
    celebrityDatailViewController.authNameString = cell.model.authName;
    [self.navigationController pushViewController:celebrityDatailViewController animated:YES];
}

- (UIView *)createFooterView{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TableViewSectionHeaderHeight)];
    // 显示全部跟单
    UIButton * showAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showAllButton.frame = footerView.frame;
    showAllButton.contentEdgeInsets = UIEdgeInsetsMake(-9, 0, 0, 0);
    [showAllButton setTitle:@"点击查看全部名家解说>>" forState:UIControlStateNormal];
    showAllButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [showAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerView addSubview:showAllButton];
    [[showAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        SHAllCelebrityViewController * allCelebrityViewController = [[SHAllCelebrityViewController alloc]init];
        [self.navigationController pushViewController:allCelebrityViewController animated:YES];
    }];
    return footerView;
}

@end
