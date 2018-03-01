//
//  TWGetOrdersModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/29.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWOrderDetailModel.h"

@interface TWGetOrdersModel : NSObject
@property (nonatomic, copy) NSString * orderNumber;     //订单号
@property (nonatomic, copy) NSString * creatTime;      //下单时间
@property (nonatomic, copy) NSString * totalAmount;     //总金额
@property (nonatomic, copy) NSString * orderStatus;     //交易状态
@property (nonatomic, copy) NSArray <TWOrderDetailModel *> * orderDetail;     //交易状态
@end
