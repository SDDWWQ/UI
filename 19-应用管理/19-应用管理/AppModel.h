//
//  AppModel.h
//  19-应用管理
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject
@property(nonatomic,copy)NSString *size;
@property(nonatomic,copy)NSString *download;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,assign)BOOL isDownloaded;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)AppWithDict:(NSDictionary *)dict;
@end
