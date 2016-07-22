//
//  CarModel.h
//  03-汽车品牌展示
//
//  Created by shadandan on 16/7/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)NSArray *cars;
//字典转模型
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)carsWithDict:(NSDictionary *)dict;
@end
