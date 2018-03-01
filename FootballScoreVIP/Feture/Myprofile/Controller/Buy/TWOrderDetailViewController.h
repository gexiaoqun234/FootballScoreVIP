//
//  TWOrderDetailViewController.h
//  105CP
//
//  Created by 田伟 on 2017/12/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHBaseViewController.h"
@class TWGetOrdersModel;

@interface TWOrderDetailViewController : SHBaseViewController
@property (nonatomic, strong) TWGetOrdersModel * selectModel;
@end
