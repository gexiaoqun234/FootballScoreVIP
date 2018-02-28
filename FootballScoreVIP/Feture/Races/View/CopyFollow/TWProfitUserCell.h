//
//  TWProfitUserCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWProfitModel;

@interface TWProfitUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *serialNumberButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekOrMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *prohitLabel;
@property (weak, nonatomic) IBOutlet UIButton *canCopyNumButton;
@property (weak, nonatomic) IBOutlet UIButton *tw_copyNumButton;
@property (nonatomic, strong) TWProfitModel * model;

@end
