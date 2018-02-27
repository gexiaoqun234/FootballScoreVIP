//
//  UIViewController+Extention.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "UIViewController+Extention.h"
#import <objc/runtime.h>

@implementation UIViewController (Extention)

+ (void)load{
    
    Method viewDidLoad = class_getClassMethod(self, @selector(viewDidLoad));
    Method tw_viewDidLoad = class_getClassMethod(self, @selector(tw_viewDidLoad));
    method_exchangeImplementations(viewDidLoad, tw_viewDidLoad);
    
    // ARC forbids use of 'dealloc' in a @selector
    Method dealloc = class_getClassMethod(self, NSSelectorFromString(@"dealloc"));
    Method tw_dealloc = class_getClassMethod(self, @selector(tw_dealloc));
    method_exchangeImplementations(dealloc, tw_dealloc);
}

- (void)tw_viewDidLoad{
    self.view.backgroundColor = [UIColor orangeColor];
    NSLog(@"%@ method did changed!", self);
    [self tw_viewDidLoad];
}

- (void)tw_dealloc{
    NSLog(@"%@ method did dealloc", self);
    [self tw_dealloc];
}

@end
