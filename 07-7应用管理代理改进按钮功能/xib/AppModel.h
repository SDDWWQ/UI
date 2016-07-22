//
//  AppModel.h
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;

//将字典转模型封装在模型内部，好处是扩展性好，代码封装性好
//提供一个方法出来用来字典转化模型,在模型类中定义字典转化模型属性有利于多个View共用一个模型，若在View中定义字典转化模型会造成只能在该View中使用，其他View想使用还要重新定义，代码重复率高。

-(instancetype)initWithDict:(NSDictionary *)dict;//对象方法字典转化为模型

+(instancetype)appModelWithDict:(NSDictionary *)dict;//类方法字典转化为模型
@end
