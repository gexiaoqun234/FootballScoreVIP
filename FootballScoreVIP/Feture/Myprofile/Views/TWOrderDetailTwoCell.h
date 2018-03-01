//
//  TWOrderDetailTwoCell.h
//  105CP
//
//  Created by 田伟 on 2017/12/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWOrderDetailModel;

@interface TWOrderDetailTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *multipleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stakeLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLaebl;
@property (weak, nonatomic) IBOutlet UILabel *tradeNumberLable;
@property (nonatomic, strong) TWOrderDetailModel * model;
@end
