//
//  GroupModel.m
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //把self.friends数组转模型
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *subDict in self.friends) {
            FriendModel *friend=[FriendModel FriendsWithDict:subDict];
            [tempArray addObject:friend];
            NSLog(@"%d",self.friends.count);
        }
        self.friends=tempArray;
    }
    return self;
}
+(instancetype)GroupWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
