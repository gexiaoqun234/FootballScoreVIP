//
//  TWFamousListCollectionView.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWFamousListCollectionView.h"
#import "TWFamousListsModel.h"
#import "TWFamousListCollectionViewCell.h"

@interface TWFamousListCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;
@end

@implementation TWFamousListCollectionView

#define TWFamousListCollectionViewCellID @"TWFamousListCollectionViewCell"

- (void)setListArray:(NSMutableArray<TWFamousListsModel *> *)listArray{
    _listArray = listArray;
    [self reloadData];
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.itemSize = CGSizeMake(FamousListCollectionCellWeight, FamousListCollectionCellHeight);
    }
    return _flowLayout;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.collectionViewLayout = self.flowLayout;
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"TWFamousListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:TWFamousListCollectionViewCellID];
    }
    return self;
}

#pragma mark --代理方法--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TWFamousListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TWFamousListCollectionViewCellID forIndexPath:indexPath];
    cell.model = _listArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:TWFamousListsDidClickNotification object:_listArray[indexPath.row]];
}

@end
