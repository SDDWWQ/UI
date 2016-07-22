//
//  CarModel.m
//  03-汽车品牌展示
//
//  Created by shadandan on 16/7/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
//字典转模型
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)carsWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
