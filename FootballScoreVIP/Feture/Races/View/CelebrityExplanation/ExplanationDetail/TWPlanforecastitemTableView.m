//
//  TWPlanforecastitemTableView.m
//  105CP
//
//  Created by 田伟 on 2017/11/10.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPlanforecastitemTableView.h"
#import "TWExplanationDetailModel.h"
#import "SHPlanforecastitemsModel.h"
#import "TWItemCell.h"

static NSString * const TWItemCellID = @"TWItemCell";

@interface TWPlanforecastitemTableView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <SHPlanforecastitemsModel *> * dataArray;
@end

@implementation TWPlanforecastitemTableView

- (void)setModel:(TWExplanationDetailModel *)model{
    _model = model;
    _dataArray = [NSMutableArray arrayWithArray:model.planforecastitems];
    [self reloadData];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"TWItemCell" bundle:nil] forCellReuseIdentifier:TWItemCellID];
    }
    return self;
}

#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TWPlanforecastitemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWItemCell * cell = [tableView dequeueReusableCellWithIdentifier:TWItemCellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 展开
    
}

@end
