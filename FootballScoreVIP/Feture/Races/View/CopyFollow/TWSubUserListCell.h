//
//  TWSubUserListCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWUserModel;

@interface TWSubUserListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cimoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cadddateLabel;

@property (nonatomic, strong) TWUserModel * model;
@end
