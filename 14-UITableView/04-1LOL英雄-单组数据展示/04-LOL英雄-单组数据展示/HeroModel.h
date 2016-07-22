//
//  HeroModel.h
//  04-LOL英雄-单组数据展示
//
//  Created by shadandan on 16/7/7.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *icons;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)HeroWithDict:(NSDictionary *)dict;
@end
