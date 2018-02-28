//
//  SHRedUserView.h
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHRedUserModel;

@interface SHRedUserView : UICollectionView
@property (nonatomic, strong) NSArray <SHRedUserModel *> * redArray;
@end
