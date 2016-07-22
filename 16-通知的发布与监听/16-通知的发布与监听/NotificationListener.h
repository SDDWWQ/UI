//
//  NotificationListener.h
//  16-通知的发布与监听
//
//  Created by shadandan on 16/7/16.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
//通知的接收者
@interface NotificationListener : NSObject
//接收者名称
//@property(nonatomic,copy)NSString *name;
//用来监听通知的方法
-(void)listen:(NSNotification *)noteInfo;
@end
