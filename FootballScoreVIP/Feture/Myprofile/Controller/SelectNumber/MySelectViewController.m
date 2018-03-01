//
//  MySelectViewController.m
//  LotteryAssistant
//
//  Created by 田伟 on 2017/5/24.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "MySelectViewController.h"
#import "ShowInfoCell.h"
//#import "UIButton+TWButton.h"
#import "TWHelpViewController.h"

@interface MySelectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) UIButton * button;
@property (nonatomic,strong) UISegmentedControl * segmentedControl;
@property (nonatomic, strong) UIImageView * nojiluImageView;
@end

@implementation MySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    [self initNavigationBar];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.tableView];
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView addSubview:self.nojiluImageView];
    });
}

- (void)initNavigationBar{
    _button = [[UIButton alloc]init];
    [_button setImage:[UIImage imageNamed:@"tw_help"] forState:UIControlStateNormal];
    [_button sizeToFit];
    [_button addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_button];
}

- (void)editButtonClick{
    TWHelpViewController * hepl = [[TWHelpViewController alloc]init];
    [self.navigationController pushViewController:hepl animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShowInfoCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIImageView *)nojiluImageView{
    if (!_nojiluImageView) {
        UIImage * nojilu = [UIImage imageNamed:@"tw_NoJiLu"];
        _nojiluImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nojilu.size.width, nojilu.size.height)];
        _nojiluImageView.center = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5 - _nojiluImageView.frame.size.height * 0.5);
        _nojiluImageView.image = nojilu;
    }
    return _nojiluImageView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        NSArray * nameArray = @[@"未使用",@"已使用",@"已过期"];
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:nameArray];
        _segmentedControl.frame = CGRectMake(40, 10, TWScreenWidth - 80, 40);
        _segmentedControl.tintColor = TWThemeColor;
        _segmentedControl.tw_centerX = self.view.tw_centerX;
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedConteolDidValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)segmentedConteolDidValueChanged:(UISegmentedControl *)sender{
    [self.nojiluImageView removeFromSuperview];
    if ([self.tableView.mj_header isRefreshing]) {
        // 如果正在刷新，先暂停刷新，延迟一秒后再重新刷新
        [self.tableView.mj_header endRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupRefresh];
        });
    } else {
        [self setupRefresh];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, TWScreenWidth, TWScreenHeight - (TWNaviHeight) - (TWTabbarHeight)) style:UITableViewStylePlain];
        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShowInfoCell class]) bundle:nil] forCellReuseIdentifier:@"ShowInfoCell"];
    }
    return _tableView;
}

@end
