//
//  QuestionModel.h
//  08-猜图游戏
//
//  Created by shadandan on 16/6/29.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject
//NSString 和block 用copy，其他Object类型都用strong，基本类型用assign
@property(nonatomic,copy)NSString *answer;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *options;
/**
 *  字典转模型
 */
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)questionWithDict:(NSDictionary *)dict;
@end
