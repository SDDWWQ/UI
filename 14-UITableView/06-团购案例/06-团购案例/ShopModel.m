//
//  ShopModel.m
//  06-团购案例
//
//  Created by shadandan on 16/7/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)ShopWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
