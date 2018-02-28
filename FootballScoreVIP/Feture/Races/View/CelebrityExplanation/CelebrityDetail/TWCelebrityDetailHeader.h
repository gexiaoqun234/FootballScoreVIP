//
//  TWCelebrityDetailHeader.h
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHCelebrityDetailModel;

@interface TWCelebrityDetailHeader : UIView

@property (weak, nonatomic) IBOutlet UIImageView *authheadImlUrlImageView;
@property (weak, nonatomic) IBOutlet UILabel *authNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jtypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *authTagImageView;
@property (weak, nonatomic) IBOutlet UIButton *authadvantageOneLabel;
@property (weak, nonatomic) IBOutlet UIButton *authadvantageTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *authadvantageThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authdescriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) RACSubject * segmentedControlSingal;
- (IBAction)typeChange:(UISegmentedControl *)sender;

+ (instancetype)cgreateTWCelebrityDetailHeader;
@property (nonatomic, strong) SHCelebrityDetailModel * model;

@end
