//
//  TWItemCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/10.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHPlanforecastitemsModel;

@interface TWItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *homeTeamIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *leagueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *guestTeamIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *guestTeamLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showDetailImageView;

@property (nonatomic, strong) SHPlanforecastitemsModel * model;
@end
