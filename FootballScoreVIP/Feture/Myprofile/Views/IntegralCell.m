//
//  IntegralCell.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "IntegralCell.h"
#import "integralModel.h"

@implementation IntegralCell

- (void)setModel:(integralModel *)model{
    _model = model;
    
    _timeLabel.text = model.createTime;
    _thingLabel.text = model.name;
    _nunberLable.text = model.score;
    
    if ([model.mark isEqualToString:@"0"]) {
        _jiajianImageView.image = [UIImage imageNamed:@"tw_add"];
        _nunberLable.textColor = [UIColor redColor];
    } else if ([model.mark isEqualToString:@"1"]) {
        _jiajianImageView.image = [UIImage imageNamed:@"tw_jianshao"];
        _nunberLable.textColor = [UIColor blueColor];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= TWMargin;
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
