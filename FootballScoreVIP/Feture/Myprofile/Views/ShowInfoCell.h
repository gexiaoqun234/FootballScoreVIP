//
//  ShowInfoCell.h
//  LotteryAssistant
//
//  Created by 田伟 on 2017/5/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveSelectorModel.h"

@interface ShowInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *redLable;

@property (weak, nonatomic) IBOutlet UILabel *blueLabel;

// 红色的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLabelWidthCons;

@property (nonatomic,strong) SaveSelectorModel * model;

@end
