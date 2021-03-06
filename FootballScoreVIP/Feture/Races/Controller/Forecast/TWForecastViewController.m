//
//  TWForecastViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWForecastViewController.h"
#import "TWTitleView.h"
#import "TitleNameModel.h"
#import "TWFootballViewController.h"
#import "TWbasketballViewController.h"

@interface TWForecastViewController ()<UIScrollViewDelegate, TitleViewDelegate>
@property (nonatomic, strong) TWTitleView * titleView;
@property (nonatomic, strong) NSMutableArray <TitleNameModel *> * titleArray;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) TWFootballViewController * footballVC;
@property (nonatomic, strong) TWbasketballViewController * baseballVC;
@end

@implementation TWForecastViewController

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        TitleNameModel * model1 = [[TitleNameModel alloc]init];
        model1.name = @"足球";
        TitleNameModel * model2 = [[TitleNameModel alloc]init];
        model2.name = @"篮球";
        [_titleArray addObject:model1];
        [_titleArray addObject:model2];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日竞彩";
    [self initAllSubViewController];
    [self initScrollView];
    [self initTitleView:self.titleArray];
    [self addChildVcWithIndex];
}

#pragma mark - ========UI界面=======
/** 添加子控制器 */
- (void)initAllSubViewController{
    _footballVC = [[TWFootballViewController alloc]init];
    [self addChildViewController:_footballVC];
    _baseballVC = [[TWbasketballViewController alloc]init];
    [self addChildViewController:_baseballVC];
}

- (void)initScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(self.titleArray.count * TWScreenWidth, 0);
}

- (void)initTitleView:(NSMutableArray *)titleArray{
    _titleView = [[TWTitleView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TitleViewHeight)];
    _titleView.titleArray = _titleArray;
    _titleView.delegate = self;
    [self.view addSubview:_titleView];
}

#pragma mark --代理方法--
#pragma mark --UIScrollViewDelegate代理方法--
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = _scrollView.contentOffset.x / TWScreenWidth;
    [_titleView titleButtonDidClick:(TWTitleButton *)_titleView.subviews[index]];
    [self addChildVcWithIndex];
}

#pragma mark --TitleViewDelegate代理方法--
- (void)TitleViewTitleButtonDidClick:(NSInteger)index{
    // 联动下面的scrollView,只需要左右滑动
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(index * TWScreenWidth, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVcWithIndex];
    }];
    // 设置index对应的tableView.scrollTotop为YES，其他为NO
    NSInteger i = 0;
    for (UIViewController * childVc in self.childViewControllers) {
        if (![childVc isViewLoaded]) {
            // 如果这个控制器没有被创建，那就不处理
            continue;
        }
        UIScrollView * tempScrollView = (UIScrollView *)childVc.view;
        if (![tempScrollView isKindOfClass:[UIScrollView class]]) {
            // 如果不是scrollView（tableView也属于scrollView），就不处理
            continue;
        }
        tempScrollView.scrollsToTop = (i == index) ? YES : NO;
        i++;
    }
}

- (void)TitleViewPreviousClickTitleButton:(NSInteger)index{
    //    TWLog(@"第%ld个标题按钮被重复点击",index);
}

#pragma mark --私有方法--
// 自动添加控制器的view
- (void)addChildVcWithIndex{
    NSInteger index = _scrollView.contentOffset.x / TWScreenWidth;
    UIView * childView = self.childViewControllers[index].view;
    if ([childView window] != nil) {
        return;
    }
    childView.frame = _scrollView.bounds;
    [_scrollView addSubview:childView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
