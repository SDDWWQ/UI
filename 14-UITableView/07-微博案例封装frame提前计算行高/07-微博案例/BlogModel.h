//
//  BlogModel.h
//  07-微博案例
//
//  Created by shadandan on 16/7/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogModel : NSObject
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign,getter=isVip) BOOL vip;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)BlogWithDict:(NSDictionary *)dict;
@end
