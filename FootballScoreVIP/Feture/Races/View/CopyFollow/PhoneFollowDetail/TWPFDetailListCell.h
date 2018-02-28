//
//  TWPFDetailListCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWFollowUserListModel;


@interface TWPFDetailListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cendtimeLable;
@property (weak, nonatomic) IBOutlet UILabel *isoverLabel;
@property (weak, nonatomic) IBOutlet UILabel *perMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *zjmoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *canCopyNumLabel;

// 显示中奖信息
@property (weak, nonatomic) IBOutlet UIImageView *bonusImageView;
@property (weak, nonatomic) IBOutlet UIButton *resultButton;
@property (weak, nonatomic) IBOutlet UILabel *winMoneyLabel;


@property (nonatomic,strong) TWFollowUserListModel * model;
@end
