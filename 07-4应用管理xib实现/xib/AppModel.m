//
//  AppModel.m
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel
-(id)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.icon=dict[@"icon"];
        self.name=dict[@"name"];
    }
    return self;
}
+(id)appModelWithDict:(NSDictionary *)dict{
    //AppModel *appModel=[[AppModel alloc]initWithDict:dict];
    AppModel *appModel=[[self alloc]initWithDict:dict];//改成self便于子类创建，创建的就是子类的对象
    return appModel;
}
@end
