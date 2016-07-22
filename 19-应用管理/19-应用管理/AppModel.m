//
//  AppModel.m
//  19-应用管理
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)AppWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
