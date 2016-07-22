//
//  main.m
//  16-通知的发布与监听
//
//  Created by shadandan on 16/7/16.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationSender.h"
#import "NotificationListener.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 创建一个通知的发布者
        NotificationSender *sender=[[NotificationSender alloc]init];
        //创建一个通知的监听者
        NotificationListener *listener=[[NotificationListener alloc]init];
        //先获取NSNotificationCenter对象
        NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
        
        //先监听，再发布才能收到通知
        
        //监听一个通知
        //参数1：要监听通知的对象
        //参数2：该对象的哪个方法用来监听这个通知
        //参数3：被监听的通知的名称，如果写nil表示参数4的对象发布的所有的通知都能监听
        //参数4：发布通知的对象，如果写nil表示无论哪个对象发布的，只要是与参数3相同的名称的通知都会被监听得到
        [notificationCenter addObserver:listener selector:@selector(listen:) name:@"sdd" object:sender];
        
        //让sender对象发布一个通知
        //通过NSNotificationCenter发布一个通知
        //参数1:通知名称
        //参数2：通知发布者（发布通知对象）
        //参数3：通知具体内容
        [notificationCenter postNotificationName:@"sdd" object:sender userInfo:@{
                                                                                 @"title":@"两会",
                                                                                 @"content":@"成龙Duang"
                                                                                 }];
    }
    return 0;
}
