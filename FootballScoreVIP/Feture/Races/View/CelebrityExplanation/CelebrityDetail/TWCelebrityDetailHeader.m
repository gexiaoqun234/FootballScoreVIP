//
//  TWCelebrityDetailHeader.m
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWCelebrityDetailHeader.h"
#import "SHCelebrityDetailModel.h"

@implementation TWCelebrityDetailHeader

- (RACSubject *)segmentedControlSingal{
    if (!_segmentedControlSingal) {
        _segmentedControlSingal = [RACSubject subject];
    }
    return _segmentedControlSingal;
}

- (IBAction)typeChange:(UISegmentedControl *)sender {
    [_segmentedControlSingal sendNext:sender];
}

+ (instancetype)cgreateTWCelebrityDetailHeader{
    return [[[NSBundle mainBundle] loadNibNamed:@"TWCelebrityDetailHeader" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _authheadImlUrlImageView.layer.cornerRadius = 25;
    _authheadImlUrlImageView.layer.masksToBounds = YES;
    
    _authadvantageOneLabel.layer.cornerRadius = 10;
    _authadvantageOneLabel.layer.masksToBounds = YES;
    _authadvantageTwoLabel.layer.cornerRadius = 10;
    _authadvantageTwoLabel.layer.masksToBounds = YES;
    _authadvantageThreeLabel.layer.cornerRadius = 10;
    _authadvantageThreeLabel.layer.masksToBounds = YES;
}

- (void)setModel:(SHCelebrityDetailModel *)model{
    _model = model;
    
    [_authheadImlUrlImageView sd_setImageWithURL:[NSURL URLWithString:model.authheadImlUrl] placeholderImage:[UIImage imageNamed:@"tw_rec_circle_more"]];
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
    
    
    // 设置擅长标签
    NSArray * authadvantageArr = [model.authadvantage componentsSeparatedByString:@","];
    _authadvantageOneLabel.hidden = NO;
    _authadvantageTwoLabel.hidden = NO;
    _authadvantageThreeLabel.hidden = NO;
    
    if (authadvantageArr.count >= 3) {
        [_authadvantageOneLabel setTitle:authadvantageArr[0] forState:UIControlStateNormal];
        [_authadvantageTwoLabel setTitle:authadvantageArr[1] forState:UIControlStateNormal];
        [_authadvantageThreeLabel setTitle:authadvantageArr[2] forState:UIControlStateNormal];
    } else if (authadvantageArr.count == 2) {
        [_authadvantageOneLabel setTitle:authadvantageArr[0] forState:UIControlStateNormal];
        [_authadvantageTwoLabel setTitle:authadvantageArr[1] forState:UIControlStateNormal];
        _authadvantageThreeLabel.hidden = YES;
    }  else if (authadvantageArr.count == 1) {
        [_authadvantageOneLabel setTitle:authadvantageArr[0] forState:UIControlStateNormal];
        _authadvantageTwoLabel.hidden = YES;
        _authadvantageThreeLabel.hidden = YES;
    } else {
        // 不存在擅长，直接隐藏
        _authadvantageOneLabel.hidden = YES;
        _authadvantageTwoLabel.hidden = YES;
        _authadvantageThreeLabel.hidden = YES;
    }
}

@end
