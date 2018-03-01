//
//  TWOrderDetailViewController.m
//  105CP
//
//  Created by 田伟 on 2017/12/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWOrderDetailViewController.h"
#import "TWGetOrdersModel.h"
#import "TWOrderDetailModel.h"
#import "TWOrderDetailTwoCell.h"
#import "TWGetOrdersDetailCell.h"
//#import "SHPayViewController.h"

static NSString * const TWGetOrdersDetailCellID = @"TWGetOrdersDetailCell";
static NSString * const TWOrderDetailTwoCellID = @"TWOrderDetailTwoCell";

@interface TWOrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * payButton;
@end

@implementation TWOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.tableView];
    
    if ([_selectModel.orderStatus isEqualToString:@"待付款"]) {
        // 没有支付完成时
        [self.view addSubview:self.payButton];
    }
}

#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _selectModel.orderDetail.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 95;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TWGetOrdersDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:TWGetOrdersDetailCellID forIndexPath:indexPath];
        cell.model = _selectModel;
        return cell;
    } else {
        TWOrderDetailTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:TWOrderDetailTwoCellID forIndexPath:indexPath];
        cell.model = _selectModel.orderDetail[indexPath.row - 1];
        return cell;
    }
}


#pragma mark - ========懒加载=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:@"TWGetOrdersDetailCell" bundle:nil] forCellReuseIdentifier:TWGetOrdersDetailCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWOrderDetailTwoCell" bundle:nil] forCellReuseIdentifier:TWOrderDetailTwoCellID];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, (TWTabbarHeight) + 10 + (TWTabbarHeight), 0);
    }
    return _tableView;
}

//- (UIButton *)payButton{
//    if (!_payButton) {
//        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _payButton.frame = CGRectMake(0, TWScreenHeight - (TWNaviHeight) - (TWTabbarHeight), TWScreenWidth, TWTabbarHeight);
//        _payButton.backgroundColor = SHThemeColor;
//        [_payButton setTitle:@"订单支付" forState:UIControlStateNormal];
//        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [[_payButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            SHPayViewController *VC= [[SHPayViewController alloc]init];
//            VC.type = _selectModel.orderDetail[0].tradeName; // 彩票类型
//            NSInteger count = 0;
//            for (TWOrderDetailModel * orderDetail in _selectModel.orderDetail) {
//                NSInteger x = [orderDetail.stake integerValue];
//                count += x;
//            }
//            VC.number = [NSString stringWithFormat:@"%ld",count]; // 总共注数
//            VC.Order_Numbder = _selectModel.orderNumber;
////            TWLog(@"彩票类型 %@,  共几注%ld, 订单号 %@",_selectModel.orderDetail[0].tradeName, count, _selectModel.orderNumber);
//            [self.navigationController pushViewController:VC animated:YES];
//        }];
//    }
//    return _payButton;
//}


@end
