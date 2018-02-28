//
//  TWAllCelebrityCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWAllCelebrityCell.h"
#import "TWFamousListsModel.h"

@implementation TWAllCelebrityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setModel:(TWFamousListsModel *)model{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.authheadImlUrl] placeholderImage:[UIImage imageNamed:@"tw_rec_circle_more"]];
    
    _authNameLabel.text = model.authName;
    
    _authdescriptionLabel.text = model.authdescription;
    
    // 彩种类型设置文字
    if ([model.jtype isEqualToString:@"0"]) {
        _jtypeImageView.image = [UIImage imageNamed:@"rec_type_football"];
    } else if ([model.jtype isEqualToString:@"1"]) {
        _jtypeImageView.image = [UIImage imageNamed:@"rec_type_basketball"];
    }
    
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
    
    _explansLabel.text = [NSString stringWithFormat:@"解读：%@",model.explans];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
