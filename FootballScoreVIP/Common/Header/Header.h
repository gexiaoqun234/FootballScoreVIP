//
//  Header.h
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#ifndef Header_h
#define Header_h


// MARK:- 屏幕高宽
#define TWScreenWidth   [UIScreen mainScreen].bounds.size.width
#define TWScreenHeight  [UIScreen mainScreen].bounds.size.height
#define TWStateHeight   [UIApplication sharedApplication].statusBarFrame.size.height



// MARK:- 适配iPhone X
#define Is_Iphone           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_Iphone_X         (Is_Iphone && TWScreenHeight == 812.0)
#define TWNaviHeight        (Is_Iphone_X ? 88 : 64)
#define TWTabbarHeight      (Is_Iphone_X ? 83 : 49)
#define BottomHeight        (Is_Iphone_X ? 34 : 0)



// MARK:- 颜色
#define TWRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
#define TWColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define TWColorRGB(r,g,b) TWColorRGBA(r,g,b,1.0)

// 主色调
#define TWThemeColor        TWColorRGB(81, 167, 124)


// MARK:- 打印
#ifdef DEBUG
#define TWLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define TWLogFunc TWLog(@"%s",__func__);
#else
#define TWLog(...)
#define TWLogFunc
#endif

#endif /* Header_h */
