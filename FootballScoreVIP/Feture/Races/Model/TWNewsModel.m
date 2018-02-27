//
//  TWNewsModel.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWNewsModel.h"

@implementation TWNewsModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.contents forKey:@"contents"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.pubdate forKey:@"pubdate"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.url forKey:@"url"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.contents = [aDecoder decodeObjectForKey:@"contents"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.pubdate = [aDecoder decodeObjectForKey:@"pubdate"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
    }
    return self;
}

@end
