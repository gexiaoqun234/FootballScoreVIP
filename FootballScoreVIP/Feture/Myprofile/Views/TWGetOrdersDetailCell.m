//
//  TWGetOrdersDetailCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/29.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWGetOrdersDetailCell.h"
#import "TWGetOrdersModel.h"

@implementation TWGetOrdersDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
}


- (void)setModel:(TWGetOrdersModel *)model{
    _model = model;
    
    NSString * typeName = model.orderDetail[0].tradeName;
    if ([typeName isEqualToString:@"重庆时时彩"]) {
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_CQSSC"];
    }else if ([typeName isEqualToString:@"排列三"]){
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_PL3"];
    }else if ([typeName isEqualToString:@"排列五"]){
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_PL5"];
    }else if ([typeName isEqualToString:@"11选5"]){
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_11X5"];
    }else if ([typeName isEqualToString:@"福彩3D"]){
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_3D"];
    }else if ([typeName isEqualToString:@"七乐彩"]){
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_QLC"];
    }else if ([typeName isEqualToString:@"七星彩"]){
        _iconImageView.image = [UIImage imageNamed:@"SH_HOME_QXC"];
    }
    
    _tradeNameLabel.text = model.orderDetail[0].tradeName;
    _tradeQihaoLabel.text =  [NSString stringWithFormat:@"期号：%@",model.orderDetail[0].tradeQihao];
    _detailRemarksLabel.text = model.orderDetail[0].detailRemarks;
    _maxAmountLabel.text = [NSString stringWithFormat:@"¥ %@",model.orderDetail[0].maxAmount];
    _orderNumberLabel.text = model.orderNumber;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
