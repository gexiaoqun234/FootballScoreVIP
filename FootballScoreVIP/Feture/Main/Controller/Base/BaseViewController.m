//
//  BaseViewController.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - ========代理=======
#pragma mark - ========DZNEmptyDataSetSource代理=======
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor colorWithRed:0.984 green:0.984 blue:0.984 alpha:1.00];
}

// 设置空白页面的图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) {
        // 圆形加载图片
        return [UIImage imageNamed:@"emptyRefreshImage"];
    } else {
        // 静止默认图片
        return [UIImage imageNamed:@"emptyImage"];
    }
}

// 图片动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    animation.duration = 0.5f;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    // 段落样式
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    return [[NSAttributedString alloc]initWithString:@"网络不给力?" attributes:@{
                                                                            NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                                                                            NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                                            NSParagraphStyleAttributeName:paragraph,
                                                                            }];
}


- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [[NSAttributedString alloc]initWithString:@"点击重新加载！" attributes:@{
                                                                             NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f],
                                                                             NSForegroundColorAttributeName:TWThemeColor
                                                                             }];
}

#pragma mark - ========DZNEmptyDataSetDelegate代理=======
// 是否开启动画
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    return self.isLoading;
}

// 子类需要重写
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    self.loading = YES;
}

#pragma mark - ========tableView代理=======
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - ========setter=======
- (void)setLoading:(BOOL)loading{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    // 每次 loading 状态被修改，就刷新空白页面。
    [self.tableView reloadEmptyDataSet];
}

#pragma mark - ========getter=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TWScreenHeight - TWTabbarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        
        // 适配ios11
        self.extendedLayoutIncludesOpaqueBars = YES;// 默认情况下, 扩展布局不包含导航栏
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(TWNaviHeight, 0, 0, 0);
        
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"TWFamousListCell" bundle:nil] forCellReuseIdentifier:TWFamousListCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWExplainListCell" bundle:nil] forCellReuseIdentifier:TWExplainListCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWNewsCell" bundle:nil] forCellReuseIdentifier:TWNewsCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWForecastCell" bundle:nil] forCellReuseIdentifier:TWForecastCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"SHSectionOneCell" bundle:nil] forCellReuseIdentifier:CFSectionOneCell];
        [_tableView registerNib:[UINib nibWithNibName:@"SHSectionTwoCell" bundle:nil] forCellReuseIdentifier:CFSectionTwoCell];
        [_tableView registerNib:[UINib nibWithNibName:@"TWHotLstCell" bundle:nil] forCellReuseIdentifier:CFTWHotLstCell];
        
    }
    return _tableView;
}

- (void)dealloc{
    self.loading = NO;
}

@end
