//
//  TWPFDetailTwoCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWPhoneFollowDetailModel;

@interface TWPFDetailTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recentRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
// weekhit
@property (weak, nonatomic) IBOutlet UILabel *weekhitLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthHitLabel;
@property (weak, nonatomic) IBOutlet UILabel *iawardLabel;

@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIImageView *state1;
@property (weak, nonatomic) IBOutlet UIImageView *state2;
@property (weak, nonatomic) IBOutlet UIImageView *state3;
@property (weak, nonatomic) IBOutlet UIImageView *state4;
@property (weak, nonatomic) IBOutlet UIImageView *state5;

@property (nonatomic, strong) TWPhoneFollowDetailModel * model;
@end
