//
//  ForumModel.m
//  QQCPNEW
//
//  Created by 田伟 on 2017/7/2.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "ForumModel.h"
#import "UILabel+TWLabel.h"

@implementation ForumModel

// 只展示部分的高度
- (CGFloat)cellHeight{
    // ⭐️缓存到成员变量里面去————如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    _cellHeight += 10 + 60 + 10 + 10 + 30 + 10 + 14.5 + 10;
    
    // titleH
    CGFloat titleH = [UILabel calculateHeight:_title withMaxSize:CGSizeMake(TWScreenWidth - 2 * TWMargin, MAXFLOAT) withFont:[UIFont systemFontOfSize:15]];
    _cellHeight += titleH + 10;
    
    // contentH
    CGFloat contentH = [UILabel calculateHeight:_content withMaxSize:CGSizeMake(TWScreenWidth - 2 * TWMargin, MAXFLOAT) withFont:[UIFont systemFontOfSize:14]];
    
    if (contentH >= 36) {   // 超过2行
        return _cellHeight += 36 + 10;
    } else {
        return _cellHeight += contentH + 10;
    }
}

// 完全展示的高度
- (CGFloat)cellAllHeight{
    if (_cellAllHeight) return _cellAllHeight;
    _cellAllHeight += 10 + 60 + 10 + 10 + 30 + 10 + 14.5 + 10;
    CGFloat titleH = [UILabel calculateHeight:_title withMaxSize:CGSizeMake(TWScreenWidth - 2 * TWMargin, MAXFLOAT) withFont:[UIFont systemFontOfSize:15]];
    _cellAllHeight += titleH + 10;
    CGFloat contentH = [UILabel calculateHeight:_content withMaxSize:CGSizeMake(TWScreenWidth - 2 * TWMargin, MAXFLOAT) withFont:[UIFont systemFontOfSize:14]];
    
    return _cellAllHeight += contentH + 10;
}

@end
