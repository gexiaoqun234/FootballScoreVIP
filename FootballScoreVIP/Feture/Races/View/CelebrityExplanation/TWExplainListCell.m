//
//  TWExplainListCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWExplainListCell.h"
#import "TWExplainListModel.h"

@implementation TWExplainListCell

- (void)setModel:(TWExplainListModel *)model{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.authheadImlUrl] placeholderImage:[UIImage imageNamed:@"tw_rec_circle_more"]];
    
    _authNameLabel.text = model.authName;
    
    // 彩种类型图片设置
    // 人物tag设置
    
    // 先隐藏
    _salepeiceLabel.text = [NSString stringWithFormat:@"%@元",model.salepeice];
    _salepeiceLabel.hidden = YES;
    

    _authdescriptionLabel.text = model.authdescription;
    
    // +10积分 什么鬼
    _label10pusl.hidden = YES;
    
    _tw_titleLabel.text = model.title;
    
    // 彩种类型设置文字
    if ([model.lotterytype isEqualToString:@"1"]) {
        _lotterytypeLabel.text = @"竞彩足球";
        _lotterytypeImageView.image = [UIImage imageNamed:@"rec_type_football"];
    } else if ([model.lotterytype isEqualToString:@"2"]) {
        _lotterytypeLabel.text = @"竞彩蓝球";
        _lotterytypeImageView.image = [UIImage imageNamed:@"rec_type_basketball"];
    }
    
    // 是否开奖（timeType）
    if ([model.isSee isEqualToString:@"0"]) {
        _isSeeLabel.text = @"未开赛";
    } else if ([model.isSee isEqualToString:@"1"]) {
        _isSeeLabel.text = @"比赛中";
    } else if ([model.isSee isEqualToString:@"2"]) {
        _isSeeLabel.text = @"已完场";
    }

    
    _begintimeLabel.text = [NSString stringWithFormat:@"开赛时间：%@",model.begintime];
    
    
    // 人物标签
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
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
    
    _salepeiceLabel.layer.cornerRadius = 3;
    _salepeiceLabel.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)topTapButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(topTapButtonDidClickDelegate:)]) {
        [self.delegate topTapButtonDidClickDelegate:self];
    }
}
@end
