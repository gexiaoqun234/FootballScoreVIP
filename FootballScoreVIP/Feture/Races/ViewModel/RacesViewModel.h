//
//  RacesViewModel.h
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TWNewsModel;





typedef void(^RacesViewControllerDataSuccessHandle)(NSArray <TWNewsModel *> * newsModel);
typedef void(^RacesViewControllerDataFailureHandle)(NSError * error);

@interface RacesViewModel : NSObject


+ (void)configRacesViewControllerData:(RacesViewControllerDataSuccessHandle)success failure:(RacesViewControllerDataFailureHandle)failure;


@end
