//
//  TWGetOrdersCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/29.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWGetOrdersCell.h"
#import "TWGetOrdersModel.h"
#import "TWOrderDetailModel.h"

@implementation TWGetOrdersCell

- (void)setModel:(TWGetOrdersModel *)model{
    _model = model;
    _orderNumberLabel.text = model.orderNumber;
    _orderStatusLabel.text = model.orderStatus;
    if ([model.orderStatus isEqualToString:@"待付款"]) {
        _orderStatusLabel.textColor = [UIColor redColor];
    } else if ([model.orderStatus isEqualToString:@"交易成功"]) {
        _orderStatusLabel.textColor = [UIColor blueColor];
    } else {
        _orderStatusLabel.textColor = [UIColor grayColor];
    }

    _createTimeLabel.text = model.creatTime;
    
    // 统计注数
    NSInteger count = 0;
    for (TWOrderDetailModel * orderDetail in model.orderDetail) {
        NSInteger x = [orderDetail.stake integerValue];
        count += x;
    }
    
    _totalCountLabel.text = [NSString stringWithFormat:@"共%ld注",count];
    _totalAmountLabel.text = [NSString stringWithFormat:@"¥ %@",model.totalAmount];
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
