//
//  CarModel.m
//  05-汽车品牌展示2
//
//  Created by shadandan on 16/7/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)CarWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
