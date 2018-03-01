//
//  TWOrderDetailModel.h
//  105CP
//
//  Created by 田伟 on 2017/12/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWOrderDetailModel : NSObject

@property (nonatomic, copy) NSString * typeName;        // 商品类型名
@property (nonatomic, copy) NSString * tradeQihao;      // 彩票期号
@property (nonatomic, copy) NSString * tradeNumber;     // 彩票号码
@property (nonatomic, copy) NSString * price;           // 彩票单价
@property (nonatomic, copy) NSString * stake;           // 购买注数
@property (nonatomic, copy) NSString * multiple;        // 购买倍数
@property (nonatomic, copy) NSString * tradeName;       // 彩种名
@property (nonatomic, copy) NSString * maxAmount;       // 最大中奖金额
@property (nonatomic, copy) NSString * detailRemarks;   // 备注信息

@end
