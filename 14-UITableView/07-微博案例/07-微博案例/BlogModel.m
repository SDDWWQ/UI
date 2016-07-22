//
//  BlogModel.m
//  07-微博案例
//
//  Created by shadandan on 16/7/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)BlogWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
