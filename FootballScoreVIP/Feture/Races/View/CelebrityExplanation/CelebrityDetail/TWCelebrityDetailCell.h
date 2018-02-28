//
//  TWCelebrityDetailCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHCelebrityDetailExplanlistsModel;

@interface TWCelebrityDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tw_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lotterytypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *isSeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *begintimeLabel;

@property (nonatomic, strong) SHCelebrityDetailExplanlistsModel * model;

@end
