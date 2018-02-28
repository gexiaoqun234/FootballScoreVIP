//
//  TWBuyToolView.m
//  105CP
//
//  Created by 田伟 on 2017/11/2.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWBuyToolView.h"

@interface TWBuyToolView()
@property(nonatomic, assign) NSInteger immediatelyCount;
@property(nonatomic, strong) UIButton * selectedButton;
@end

@implementation TWBuyToolView

+ (instancetype)createTWBuyToolView{
    return [[[NSBundle mainBundle] loadNibNamed:@"TWBuyToolView" owner:nil options:nil] firstObject];
}


- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 样式设置
    _multipleTextfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _multipleTextfield.layer.borderWidth = 0.5;
    
    _ImmediatelyButton.layer.cornerRadius = 3;
    _ImmediatelyButton.layer.masksToBounds = YES;
    
    _tenButton.layer.borderWidth = 0.5;
    _tenButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _twentyButton.layer.borderWidth = 0.5;
    _twentyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _fiftyButton.layer.borderWidth = 0.5;
    _fiftyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _hundredButton.layer.borderWidth = 0.5;
    _hundredButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _MinusButton.layer.borderColor = [UIColor redColor].CGColor;
    _MinusButton.layer.borderWidth = 1;
    _MinusButton.layer.cornerRadius = 10;
    _MinusButton.layer.masksToBounds = YES;
    
    _plusButton.layer.borderColor = [UIColor redColor].CGColor;
    _plusButton.layer.borderWidth = 1;
    _plusButton.layer.cornerRadius = 10;
    _plusButton.layer.masksToBounds = YES;
    
    // 初始值设置
    _immediatelyCount = 5;
    [self restartImmediately];
    
    _multipleTextfield.delegate = self;
}

// 修改倍数
- (void)restartImmediately{
    _multipleTextfield.text = [NSString stringWithFormat:@"%ld",_immediatelyCount];
    _totleLabel.text = [NSString stringWithFormat:@"共%ld元",_immediatelyCount * 2];
}

// 减
- (IBAction)MinusButtonClick:(UIButton *)sender {
    if (_immediatelyCount == 0) {
        _immediatelyCount = 0;
    } else {
        _immediatelyCount--;
    }
    [self restartImmediately];
}

// 加
- (IBAction)plusButtonClick:(UIButton *)sender {
    _immediatelyCount++;
    [self restartImmediately];
}

// 立即投注按钮
- (IBAction)ImmediatelyButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(immediatelyButtonDidClickWithImmediately:)]) {
        [self.delegate immediatelyButtonDidClickWithImmediately:_immediatelyCount];
    }
}

- (void)setSelectState:(UIButton *)button{
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor redColor].CGColor;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)setUnselectState:(UIButton *)button{
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

// 4个倍数按钮
- (IBAction)tenButtonClick:(UIButton *)sender {
    _immediatelyCount = 10;
    [self restartImmediately];
    if (_selectedButton == nil) {
        _selectedButton = sender;
        [self setSelectState:sender];
    } else {
        UIButton * temp = _selectedButton;
        _selectedButton = sender;
        [self setSelectState:sender];
        [self setUnselectState:temp];
    }
}

- (IBAction)twentyButtonClick:(UIButton *)sender {
    _immediatelyCount = 20;
    [self restartImmediately];
    if (_selectedButton == nil) {
        _selectedButton = sender;
        [self setSelectState:sender];
    } else {
        UIButton * temp = _selectedButton;
        _selectedButton = sender;
        [self setSelectState:sender];
        [self setUnselectState:temp];
    }
}

- (IBAction)fiftyButtonClick:(UIButton *)sender {
    _immediatelyCount = 50;
    [self restartImmediately];
    if (_selectedButton == nil) {
        _selectedButton = sender;
        [self setSelectState:sender];
    } else {
        UIButton * temp = _selectedButton;
        _selectedButton = sender;
        [self setSelectState:sender];
        [self setUnselectState:temp];
    }
}

- (IBAction)hundredButtonClick:(UIButton *)sender {
    _immediatelyCount = 100;
    [self restartImmediately];
    if (_selectedButton == nil) {
        _selectedButton = sender;
        [self setSelectState:sender];
    } else {
        UIButton * temp = _selectedButton;
        _selectedButton = sender;
        [self setSelectState:sender];
        [self setUnselectState:temp];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_multipleTextfield resignFirstResponder];
    _immediatelyCount = [textField.text integerValue];
    _totleLabel.text = [NSString stringWithFormat:@"共%ld元",_immediatelyCount * 2];
    return YES;
}


@end
