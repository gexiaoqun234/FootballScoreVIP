//
//  IntegralCell.h
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class integralModel;

@interface IntegralCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jiajianImageView;
@property (weak, nonatomic) IBOutlet UILabel *nunberLable;
@property (nonatomic,strong) integralModel * model;
@end
