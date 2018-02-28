//
//  SHCelebrityDetailModel.m
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHCelebrityDetailModel.h"

@implementation SHCelebrityDetailModel

// 数组对应的模型
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"explanlists":@"SHCelebrityDetailExplanlistsModel"};
}

- (CGFloat)headerViewHeight{
//    if (_headerViewHeight) return _headerViewHeight;
    
    TWLog(@"%@",self.authdescription);
    
    // 其他固定控件的高度+间距
    _headerViewHeight += 120;
    
    // 中间文本的高度
    CGSize textMaxSize = CGSizeMake(TWScreenWidth - 40, MAXFLOAT);
    _headerViewHeight += [self.authdescription boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return _headerViewHeight + 50; 
}

@end
