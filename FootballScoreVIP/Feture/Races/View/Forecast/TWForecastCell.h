//
//  TWForecastCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWForecastModel;

@interface TWForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;
@property (weak, nonatomic) IBOutlet UILabel *experttitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *experthotLabel;
@property (weak, nonatomic) IBOutlet UILabel *expertaddtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *expertabstractLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hitImageView;

@property (nonatomic, strong) TWForecastModel * model;

@end
