//
//  TWHitUserCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWHitModel;

/*
 序号和近7/30天战绩这两个控件的值由VC传递过来，model里面不带这两个参数
 其中：序号就是cell的编号，自1开始计
 */

@interface TWHitUserCell : UITableViewCell
// 序号
@property (weak, nonatomic) IBOutlet UIButton *SerialNumberButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
// 近7/30天战绩
@property (weak, nonatomic) IBOutlet UILabel *weekOrMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *allHitLabel;
@property (weak, nonatomic) IBOutlet UIButton *canCopyNumButton;
@property (weak, nonatomic) IBOutlet UIButton *tw_copyNumButton;

@property (nonatomic, strong) TWHitModel * model;

@end
