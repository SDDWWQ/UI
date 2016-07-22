//
//  FriendModel.m
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)FriendsWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
