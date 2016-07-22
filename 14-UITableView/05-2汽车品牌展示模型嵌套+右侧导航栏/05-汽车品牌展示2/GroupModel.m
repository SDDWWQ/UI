//
//  GroupModel.m
//  05-汽车品牌展示2
//
//  Created by shadandan on 16/7/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "GroupModel.h"
#import "CarModel.h"
@implementation GroupModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        //[self setValuesForKeysWithDictionary:dict];//对于cars属性，这样赋值相当于数组中还是字典，而我们实际上想要的是模型的数组，所以这种方式不行
        //模型的嵌套
        self.title=dict[@"title"];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *carDict in dict[@"cars"]){
            [tempArray addObject:[CarModel CarWithDict:carDict]];
        }
        self.cars=tempArray;
        
    }
    return self;
}
+(instancetype)GroupWithDict:(NSDictionary *)dict{
    return [[self alloc ]initWithDict:dict];
}
@end
