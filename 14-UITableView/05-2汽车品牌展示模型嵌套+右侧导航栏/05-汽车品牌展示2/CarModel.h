//
//  CarModel.h
//  05-汽车品牌展示2
//
//  Created by shadandan on 16/7/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)CarWithDict:(NSDictionary *)dict;
@end
