//
//  NotificationListener.m
//  16-通知的发布与监听
//
//  Created by shadandan on 16/7/16.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "NotificationListener.h"

@implementation NotificationListener
-(void)listen:(NSNotification *)noteInfo{
    NSLog(@"Duang.....listen方法执行了");
    NSLog(@"%@",noteInfo);
    /**
     *  
     NSConcreteNotification 0x1002047e0 {name = sdd; object = <NotificationSender: 0x100400080>; userInfo = {
     content = "\U6210\U9f99Duang";
     title = "\U4e24\U4f1a";
     }}
     
     noteInfo.name:监听到的通知名称
     noteInfo.object:监听到的通知是哪个对象发布的
     noteInfo.userInfo:这是一个字典，这个字典中包含了通知的具体内容
     
     */
    
}
//移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"移除通知");
}
@end
