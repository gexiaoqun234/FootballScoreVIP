//
//  SHRedUserView.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHRedUserView.h"
#import "SHRedUserCollectionCell.h"

@interface SHRedUserView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;
@end

@implementation SHRedUserView

#define SHRedUserCollectionCellID     @"SHRedUserCollectionCell"

- (void)setRedArray:(NSArray<SHRedUserModel *> *)redArray{
    _redArray = redArray;
    [self reloadData];
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.itemSize = CGSizeMake(RedUserCollectionCellWeight, RedUserCollectionCellHeight);
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
        [self registerNib:[UINib nibWithNibName:@"SHRedUserCollectionCell" bundle:nil] forCellWithReuseIdentifier:SHRedUserCollectionCellID];
    }
    return self;
}

#pragma mark --代理方法--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _redArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SHRedUserCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SHRedUserCollectionCellID forIndexPath:indexPath];
    cell.model = _redArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHRedUserViewRedUserDidClickNotification object:_redArray[indexPath.row]];
}


@end
