//
//  ForumModel.h
//  QQCPNEW
//
//  Created by 田伟 on 2017/7/2.
//  Copyright © 2017年 个人. All rights reserved.
//  论坛

#import <Foundation/Foundation.h>

@interface ForumModel : NSObject
/** 论坛标题 */
@property (nonatomic,copy) NSString * title;
/** 论坛内容 */
@property (nonatomic,copy) NSString * content;
/** 论坛id */
@property (nonatomic,assign) NSInteger forumId;
/** 论坛发表时间 */
@property (nonatomic,copy) NSString * createTime;
/** 论坛作者Id */
@property (nonatomic,assign) NSInteger userId;
/** 论坛作者昵称 */
@property (nonatomic,copy) NSString * username;
/** 阅读数 */
@property (nonatomic,assign) NSInteger readCount;
/** 论坛作者头像 */
@property (nonatomic,copy) NSString * imgPath;
/** 点赞数 */
@property (nonatomic,assign) NSInteger hitTotal;
/** 评论数 */
@property (nonatomic,assign) NSInteger commentCount;
/** 该论坛用户是否点过赞（0：未赞，1：已赞） */
@property (nonatomic,assign) NSInteger isThumb;

// MARK:- 自定义属性
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGFloat cellAllHeight;

@end
