//
//  HeroModel.m
//  04-LOL英雄-单组数据展示
//
//  Created by shadandan on 16/7/7.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)HeroWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
