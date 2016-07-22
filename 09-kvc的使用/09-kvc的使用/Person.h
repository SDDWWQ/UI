//
//  Person.h
//  09-kvc的使用
//
//  Created by shadandan on 16/7/1.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;
@interface Person : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int age;
@property(nonatomic,strong)Book *book;
@end
