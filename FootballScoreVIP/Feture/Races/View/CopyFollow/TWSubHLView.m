//
//  TWSubHLView.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWSubHLView.h"
#import "TWTitleView.h"
#import "TitleNameModel.h"
#import "SHHotListModel.h"
#import "SHHotlistUserListModel.h"
#import "TWSubUserListCell.h"
#import "TWUserModel.h"

@interface TWSubHLView ()<TitleViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TWTitleView * segmentView;
@property (nonatomic, strong) TitleNameModel * model1;
@property (nonatomic, strong) TitleNameModel * model2;
@property (nonatomic,strong) NSMutableArray <TitleNameModel *> * titleArray;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIView * programView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) SHHotlistUserListModel * userListModel;
@property (nonatomic, strong) NSMutableArray <TWUserModel *> * userListArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIView * titleHeaderView;
@property (nonatomic, strong) UILabel * totleLabel;
@end

@implementation TWSubHLView


#define TWSubHLViewToolBarHeight        40
#define TWSubHLViewtitleHeaderViewH     50
#define TWSubUserListCellID             @"TWSubUserListCell"

#define TWpage          @"page"
#define TWpassword      @"password"
#define TWplanNo        @"planNo"
#define TWuser          @"user"
#define TWversion       @"version"

#pragma mark - ========懒加载=======
- (NSMutableArray<TitleNameModel *> *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        _model1 = [[TitleNameModel alloc]init];
        _model1.name = @"方案详情";
        _model2 = [[TitleNameModel alloc]init];
        _model2.name = @"跟单用户";
        [_titleArray addObject:_model1];
        [_titleArray addObject:_model2];
    }
    return _titleArray;
}

- (void)setProjidString:(NSString *)projidString{
    _projidString = projidString;
    // 70_CP70124319546
    [self setupRefresh];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _currentPage = 1;
        [self configUI];
    }
    return self;
}


#pragma mark - ========UI搭建=======
- (void)configUI{

    // 第二部分：标题栏
    _segmentView = [[TWTitleView alloc]initWithFrame:CGRectMake(0, 0, self.tw_width, TWSubHLViewToolBarHeight)];
    _segmentView.delegate = self;
    _segmentView.titleArray = self.titleArray;
    [self addSubview:_segmentView];
    
	// 第二部分：滚动展示视图
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TWSubHLViewToolBarHeight, self.tw_width, self.tw_height - TWSubHLViewToolBarHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.tw_width * 2, self.tw_height - TWSubHLViewToolBarHeight);
   
    // 方案详情 tw_suo
    _programView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.tw_width, _scrollView.tw_height)];
    _programView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_programView];
    
    // 默认显示带锁的视图，如果可以展示方案的活，直接覆盖这个视图19 23.6667)
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 19, 23.66)];
    imageView.image = [UIImage imageNamed:@"tw_suo"];
    imageView.center = CGPointMake(_programView.tw_centerX, _programView.tw_centerY - 20);
    [_programView addSubview:imageView];

    UILabel * hiddleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _scrollView.tw_width, 20)];
    hiddleLabel.textAlignment = NSTextAlignmentCenter;
    hiddleLabel.text = @"11-03 23:50J截止赛后公布";
    hiddleLabel.font = [UIFont systemFontOfSize:12];
    hiddleLabel.textColor = [UIColor darkGrayColor];
    hiddleLabel.center = CGPointMake(_programView.tw_centerX, _programView.tw_centerY + 10);
    [_programView addSubview:hiddleLabel];

    //TODO: - 方案详情展示是通过传来的模型里面的方案的数据来展示
    //        或者是通过开奖时间来展示————数据模型比对

    // 用户跟单
    // 1表视图的背景视图
    UIView * userView = [[UIView alloc]initWithFrame:CGRectMake(_scrollView.tw_width, 0, _scrollView.tw_width, _scrollView.tw_height)];
    [_scrollView addSubview:userView];
    
    // 2表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.tw_width, _scrollView.tw_height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    _tableView.contentInset = UIEdgeInsetsMake(TWSubHLViewtitleHeaderViewH, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:@"TWSubUserListCell" bundle:nil] forCellReuseIdentifier:TWSubUserListCellID];
    [userView addSubview:_tableView];
    
    // 3表式图上面的标题栏
    _titleHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.tw_width, TWSubHLViewtitleHeaderViewH)];
    _titleHeaderView.backgroundColor = [UIColor whiteColor];
    [userView addSubview:_titleHeaderView];
    
    // 4标题栏在分2部分，upView和downView
    UIView * upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.tw_width, TWSubHLViewtitleHeaderViewH * 0.5)];
    [_titleHeaderView addSubview:upView];
    UIView * redView = [[UIView alloc]initWithFrame:CGRectMake(20, 5, 3, 15)];
    redView.backgroundColor = [UIColor redColor];
    [upView addSubview:redView];
    _totleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, _scrollView.tw_width - 30, TWSubHLViewtitleHeaderViewH * 0.5)];
    _totleLabel.font = [UIFont systemFontOfSize:12];
    [upView addSubview:_totleLabel];
    // 5
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, TWSubHLViewtitleHeaderViewH * 0.5, _scrollView.tw_width, TWSubHLViewtitleHeaderViewH * 0.5)];
    downView.backgroundColor = TWColorRGB(242, 242, 242);
    [_titleHeaderView addSubview:downView];
    NSArray * nameArray = @[@"用户",@"跟单金额",@"跟单时间"];
    for (NSInteger i = 0; i < nameArray.count; i++) {
        CGFloat labelW = _scrollView.tw_width / 3.0;
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i * labelW, 0, labelW, TWSubHLViewtitleHeaderViewH * 0.5)];
        label.text = nameArray[i];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [downView addSubview:label];
    }
}

#pragma mark - ========刷新请求数据=======
- (void)setupRefresh{
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

// 下拉刷新数据
- (void)loadNewData{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[TWpage] = @(1);
    parameters[TWpassword] = @"";
    parameters[TWplanNo] = self.projidString;
    parameters[TWuser] = @"";
    parameters[TWversion] = @"24";
    [[SHNetworkTool shareInstance] getDiscoverCopyFollowHotListShowDetailUserListDataWith:parameters Success:^(SHHotlistUserListModel *userListsData) {
        _userListModel = userListsData;
        // 设置分页视图的标题栏
        _userListArray = [NSMutableArray arrayWithArray:_userListModel.copyusers];
        
        // 将label中的数字变成红色的
        NSString * labelString = [NSString stringWithFormat:@"当前跟单%@人，跟单金额%@元",_userListModel.copycount,_userListModel.copysum];
        _totleLabel.attributedText = [self detailNumberLabel:labelString];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

// 上拉加载更多
- (void)loadMoreData{
    _currentPage++;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[TWpage] = @(_currentPage);
    parameters[TWpassword] = @"";
    parameters[TWplanNo] = self.projidString;
    parameters[TWuser] = @"";
    parameters[TWversion] = @"24";
    [[SHNetworkTool shareInstance] getDiscoverCopyFollowHotListShowDetailUserListDataWith:parameters Success:^(SHHotlistUserListModel *userListsData) {
        [_userListArray addObjectsFromArray:_userListModel.copyusers];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSMutableAttributedString *)detailNumberLabel:(NSString *)lableString{
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:lableString];
    for (int i = 0; i < lableString.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [lableString substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

#pragma mark --UIScrollViewDelegate代理方法--
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = _scrollView.contentOffset.x / TWScreenWidth;
    [_segmentView titleButtonDidClick:(TWTitleButton *)_segmentView.subviews[index]];
}

#pragma mark --TitleViewDelegate代理方法--
- (void)TitleViewTitleButtonDidClick:(NSInteger)index{
    // 联动下面的scrollView,只需要左右滑动
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(index * TWScreenWidth, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {}];
}

- (void)TitleViewPreviousClickTitleButton:(NSInteger)index{
    TWLog(@"第%ld个标题按钮被重复点击",index);
}

#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _userListArray.count == 0;
    return _userListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWSubUserListCell * cell = [tableView dequeueReusableCellWithIdentifier:TWSubUserListCellID forIndexPath:indexPath];
    cell.model = _userListArray[indexPath.row];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : TWColorRGB(242, 242, 242);
    return cell;
}

@end
