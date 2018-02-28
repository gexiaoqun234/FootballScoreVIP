//
//  SHMoreCelebrityViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHMoreCelebrityViewController.h"
#import "TWFamousListsModel.h"
#import "TWAllCelebrityCell.h"
#import "SHCelebrityDatailViewController.h"

static NSString * const TWAllCelebrityCellID = @"TWAllCelebrityCell";

@interface SHMoreCelebrityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <TWFamousListsModel *> * listArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation SHMoreCelebrityViewController

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
        _tableView.contentInset = UIEdgeInsetsMake(TWNaviHeight, 0, 0, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"TWAllCelebrityCell" bundle:nil] forCellReuseIdentifier:TWAllCelebrityCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.title = @"名人列表";
    [self setupRefresh];
    _currentPage = 1;
}

#pragma mark - ========刷新请求数据=======
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
    parameters[@"page"] = @(1);
    parameters[@"version"] = @(1);
    [[SHNetworkTool shareInstance] getDiscoverCopyFollowsAllCelebrityListsWith:parameters Success:^(NSArray *celebrityListsArray) {
        _listArray = [NSMutableArray arrayWithArray:celebrityListsArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

// 上拉加载更多
- (void)loadMoreData{
    _currentPage++;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"cfrom"] = @"ios";
    parameters[@"channel"] = @"tzhongcp";
    parameters[@"page"] = @(_currentPage);
    parameters[@"version"] = @(1);
    [[SHNetworkTool shareInstance] getDiscoverCopyFollowsAllCelebrityListsWith:parameters Success:^(NSArray *celebrityListsArray) {
        [_listArray addObjectsFromArray:celebrityListsArray];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _listArray.count == 0;
    return _listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWAllCelebrityCell * cell = [tableView dequeueReusableCellWithIdentifier:TWAllCelebrityCellID forIndexPath:indexPath];
    cell.model = _listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHCelebrityDatailViewController * celebrityDatailVC = [[SHCelebrityDatailViewController alloc]init];
    // 传值过去
    celebrityDatailVC.authNameString = _listArray[indexPath.row].authName;
    [self.navigationController pushViewController:celebrityDatailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
