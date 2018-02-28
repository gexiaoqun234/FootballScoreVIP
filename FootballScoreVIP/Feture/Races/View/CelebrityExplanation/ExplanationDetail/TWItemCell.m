//
//  TWItemCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/10.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWItemCell.h"
#import "SHPlanforecastitemsModel.h"

@implementation TWItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    
    _guestTeamIconImageView.layer.cornerRadius = 20;
    _guestTeamIconImageView.layer.masksToBounds = YES;
    _homeTeamIconImageView.layer.cornerRadius = 20;
    _homeTeamIconImageView.layer.masksToBounds = YES;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setModel:(SHPlanforecastitemsModel *)model{
    _model = model;
    
    _homeTeamLabel.text = model.homeTeam;
    [_homeTeamIconImageView sd_setImageWithURL:[NSURL URLWithString:model.homeTeamIcon] placeholderImage:[UIImage imageNamed:@"tw_rec_explain_team_icon"]];
    
    _leagueNameLabel.text = model.leagueName;
    _matchTimeLabel.text = model.matchTime;
    
    [_guestTeamIconImageView sd_setImageWithURL:[NSURL URLWithString:model.guestTeamIcon] placeholderImage:[UIImage imageNamed:@"tw_rec_explain_team_icon"]];
    _guestTeamLabel.text = model.guestTeam;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
