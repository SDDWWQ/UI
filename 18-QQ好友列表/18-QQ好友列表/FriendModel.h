//
//  FriendModel.h
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,assign,getter=isVip)BOOL vip;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)FriendsWithDict:(NSDictionary *)dict;
@end
