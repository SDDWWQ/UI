//
//  QuestionModel.m
//  08-猜图游戏
//
//  Created by shadandan on 16/6/29.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    //kvc
    if (self=[super init]) {
//        self.icon=dict[@"icon"];
//        self.answer=dict[@"answer"];
//        self.options=dict[@"options"];
//        self.title=dict[@"title"];
        //上面四句等价于下面四句
//        [self setValue:dict[@"icon"]  forKeyPath:@"icon"];
//        [self setValue:dict[@"answer"] forKey:@"answer"];
//        [self setValue:dict[@"options"]  forKeyPath:@"options"];
//        [self setValue:dict[@"title"]  forKeyPath:@"title"];
        //上面四句等价于下面一句
        [self setValuesForKeysWithDictionary:dict];//遍历整个字典，给对应名称的类的成员属性赋值

    }
    return self;
}
+(instancetype)questionWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];//调对象方法
}
@end
