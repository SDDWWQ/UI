//
//  GroupModel.h
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"
@interface GroupModel : NSObject
@property(nonatomic,strong)NSArray *friends;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int online;
@property(nonatomic,assign,getter=isVisible)BOOL visible;//是否展开分组
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)GroupWithDict:(NSDictionary *)dict;
@end
