//
//  MessageModel.m
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)MessageWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
