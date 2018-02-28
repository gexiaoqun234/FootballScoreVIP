//
//  TWFamousListCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWFamousListCollectionView;
@class TWFamousListsModel;

@interface TWFamousListCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray <TWFamousListsModel *> * listArray;
@property (weak, nonatomic) IBOutlet TWFamousListCollectionView *tw_contentView;
@end
