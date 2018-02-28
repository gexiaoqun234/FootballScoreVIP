//
//  TWExplanationDetailSectionOne.m
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWExplanationDetailSectionOne.h"
#import "TWExplanationDetailModel.h"

@implementation TWExplanationDetailSectionOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
    
    _begintimeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _begintimeButton.layer.borderWidth = 1;
}

- (void)setModel:(TWExplanationDetailModel *)model{
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.authheadImlUrl] placeholderImage:[UIImage imageNamed:@"tw_rec_circle_more"]];
    
    _authNameLabel.text = model.authName;
    
    _authTagImageView.hidden = NO;
    if ([model.authTag isEqualToString:@"媒体名记"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_media_reporter"];
    } else if ([model.authTag isEqualToString:@"专业玩家"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_ professional_player"];
    } else if ([model.authTag isEqualToString:@"篮球名人"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_basketball_famous"];
    } else if ([model.authTag isEqualToString:@"篮球名将"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_basketball_star"];
    } else if ([model.authTag isEqualToString:@"社区名人"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_community_famous"];
    } else if ([model.authTag isEqualToString:@"足球名将"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_football_star"];
    } else if ([model.authTag isEqualToString:@"彩票分析师"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_lottery_analyser"];
    } else if ([model.authTag isEqualToString:@"TV大咖"]) {
        _authTagImageView.image = [UIImage imageNamed:@"rec_tag_tv_ka"];
    } else {
        _authTagImageView.hidden = YES;
    }
    
    // 彩种类型设置图片
    if ([model.lotterytype isEqualToString:@"1"]) {
        _lotterytypeImageView.image = [UIImage imageNamed:@"rec_type_football"];
    } else if ([model.lotterytype isEqualToString:@"2"]) {
        _lotterytypeImageView.image = [UIImage imageNamed:@"rec_type_basketball"];
    }
    
    _authdescriptionLabel.text = model.authdescription;
    
    _plantitleLabel.text = model.plantitle;
    
    // 彩种类型设置文字
    if ([model.lotterytype isEqualToString:@"1"]) {
        _lotterytypeLabel.text = @"竞彩足球";
    } else if ([model.lotterytype isEqualToString:@"2"]) {
        _lotterytypeLabel.text = @"竞彩蓝球";
    }
    
    
    if ([model.isSee isEqualToString:@"0"]) {
        _isSeeLabel.text = @"未开赛";
    }
    
    _releaseTimeLabel.text = [NSString stringWithFormat:@"发布时间：%@",model.releaseTime];
    
    [_begintimeButton setTitle:[NSString stringWithFormat:@"开赛时间：%@",model.begintime] forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
