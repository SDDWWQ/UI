//
//  GroupModel.h
//  05-汽车品牌展示2
//
//  Created by shadandan on 16/7/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property(nonatomic,strong)NSArray *cars;
@property(nonatomic,copy)NSString *title;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)GroupWithDict:(NSDictionary *)dict;
@end
