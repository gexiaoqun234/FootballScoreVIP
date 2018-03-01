//
//  TWGetOrdersDetailCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/29.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWGetOrdersModel;

@interface TWGetOrdersDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tradeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeQihaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRemarksLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (nonatomic, strong) TWGetOrdersModel * model;
@end
