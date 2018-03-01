//
//  TWOrderDetailTwoCell.m
//  105CP
//
//  Created by 田伟 on 2017/12/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWOrderDetailTwoCell.h"
#import "TWOrderDetailModel.h"

@implementation TWOrderDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TWOrderDetailModel *)model{
    _model = model;
    _multipleLabel.text = [NSString stringWithFormat:@"%@ 倍",model.multiple];
    _stakeLable.text = [NSString stringWithFormat:@"%@ 注",model.stake];
    _priceLaebl.text = [NSString stringWithFormat:@"¥ %@",model.price];
    _tradeNumberLable.text = model.tradeNumber;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
