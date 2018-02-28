//
//  TWPFDetailOneCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWPhoneFollowDetailModel;

@interface TWPFDetailOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *icopyawardLabel;
@property (weak, nonatomic) IBOutlet UILabel *ihitnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *ifoucsnumLabel;
@property (nonatomic, strong) TWPhoneFollowDetailModel * model;
@end
