//
//  ShopModel.h
//  06-团购案例
//
//  Created by shadandan on 16/7/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *buyCount;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)ShopWithDict:(NSDictionary *)dict;
@end
