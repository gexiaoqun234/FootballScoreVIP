//
//  TWBuyToolView.h
//  105CP
//
//  Created by 田伟 on 2017/11/2.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TWBuyToolViewDelegate <NSObject>
- (void)immediatelyButtonDidClickWithImmediately:(NSInteger)immediately;
@end

@interface TWBuyToolView : UIView<UITextFieldDelegate>
@property (nonatomic, weak)id <TWBuyToolViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *MinusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UITextField *multipleTextfield;
@property (weak, nonatomic) IBOutlet UILabel *totleLabel;
@property (weak, nonatomic) IBOutlet UIButton *ImmediatelyButton;
@property (weak, nonatomic) IBOutlet UIButton *tenButton;
@property (weak, nonatomic) IBOutlet UIButton *twentyButton;
@property (weak, nonatomic) IBOutlet UIButton *fiftyButton;
@property (weak, nonatomic) IBOutlet UIButton *hundredButton;

+ (instancetype)createTWBuyToolView;

- (IBAction)MinusButtonClick:(UIButton *)sender;
- (IBAction)plusButtonClick:(UIButton *)sender;
- (IBAction)ImmediatelyButtonClick:(UIButton *)sender;
- (IBAction)tenButtonClick:(UIButton *)sender;
- (IBAction)twentyButtonClick:(UIButton *)sender;
- (IBAction)fiftyButtonClick:(UIButton *)sender;
- (IBAction)hundredButtonClick:(UIButton *)sender;

@end
