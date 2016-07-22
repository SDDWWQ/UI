//
//  MessageModel.h
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义枚举
typedef enum{
    MessageTypeOther=0,
    MessageTypeMe=1
}MessageType;

@interface MessageModel : NSObject

@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)MessageType type;//表示是自己发的消息还是对方发的消息
@property(nonatomic,assign)BOOL hideTime;//记录是否要显示时间Label

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)MessageWithDict:(NSDictionary *)dict;

@end
