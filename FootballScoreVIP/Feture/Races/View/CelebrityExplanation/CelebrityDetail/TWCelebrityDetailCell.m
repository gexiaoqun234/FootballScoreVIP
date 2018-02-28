//
//  TWCelebrityDetailCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWCelebrityDetailCell.h"
#import "SHCelebrityDetailExplanlistsModel.h"

@implementation TWCelebrityDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SHCelebrityDetailExplanlistsModel *)model{
    _model = model;
    _tw_titleLabel.text = model.plantitle;
    
    // 彩种类型设置文字
    if ([model.lotterytype isEqualToString:@"1"]) {
        _lotterytypeLabel.text = @"竞彩足球";
    } else if ([model.lotterytype isEqualToString:@"2"]) {
        _lotterytypeLabel.text = @"竞彩蓝球";
    }
    
    TWLog(@"%@",model.isSee);
    
    // 是否开奖（timeType）
    if ([model.isSee isEqualToString:@"0"]) {
        _isSeeLabel.text = @"未开赛";
    } else if ([model.isSee isEqualToString:@"2"]) {
        _isSeeLabel.text = @"比赛中";
    } else if ([model.isSee isEqualToString:@"1"]) {
        _isSeeLabel.text = @"已完场";
    }
    
    _begintimeLabel.text = [NSString stringWithFormat:@"开赛时间：%@",model.begintime];
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
