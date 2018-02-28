//
//  TWForecastCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWForecastCell.h"
#import "TWForecastModel.h"

@implementation TWForecastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _experthotLabel.layer.cornerRadius = 2;
    _experthotLabel.layer.masksToBounds = YES;
    _experthotLabel.layer.borderColor = [UIColor redColor].CGColor;
    _experthotLabel.layer.borderWidth = 1;
}

- (void)setModel:(TWForecastModel *)model{
    _model = model;
    [_imageImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"tw_rec_explain_team_icon"]];
    _experttitleLabel.text = model.experttitle;
    _expertaddtitleLabel.text = model.expertaddtitle;
    _expertabstractLabel.text = model.expertabstract;
    if ([model.experthit isEqualToString:@"0"]) {
        _hitImageView.hidden = YES;
    } else if ([model.experthit isEqualToString:@"1"]) {
        _hitImageView.hidden = NO;
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 2;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
