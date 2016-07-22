//
//  main.m
//  09-kvc的使用
//
//  Created by shadandan on 16/7/1.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Book.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Person *person1=[[Person alloc]init];
        //普通的方式赋值
        person1.name=@"张三";
        person1.age=28;
        
        //设置值
        [person1 setValue:@"zhangsan" forKey:@"name"];
        [person1 setValue:@"28" forKey:@"age"];
        [person1 setValue:@28 forKey:@"age"];
        //取值
        NSString *name=[person1 valueForKeyPath:@"name"];
        int age=[[person1 valueForKeyPath:@"age"]intValue];
         NSLog(@"%d",age);
        
        //设置值
        NSDictionary *dict=@{
                             @"name":@"sdd",
                             @"age":@24,
                             @"book":@{@"name":@"放风筝的人"}
                             };
        [person1 setValuesForKeysWithDictionary:dict];
        NSDictionary *bookDict=(NSDictionary *)person1.book;
        NSLog(@"%@-----%d------%@",person1.name,person1.age,bookDict[@"name"]);
        
        //把对象转化成字典,数组里面放key值的集合
        NSDictionary *tempDictionary=[person1 dictionaryWithValuesForKeys:@[@"name",@"age"]];
        NSLog(@"%@",tempDictionary);// {age = 28;name = zhangsan;}

        
        Person *person2=[[Person alloc]init];
        person2.name=@"lisi";
        person2.age=24;
        
        Person *person3=[[Person alloc]init];
        person3.name=@"wangwu";
        person3.age=27;
        NSArray *persons=@[person1,person2,person3];
        //以前的方式获取所有Person的name的数组
//        NSMutableArray *tempArray=[NSMutableArray array];
//        for (Person *person in persons) {
//            NSString *name=person.name;
//            [tempArray addObject:name];
//        }//(zhangsan,lisi,wangwu)

        //如果对象没有对应的属性，系统会检测对象的真实类型，如果是数据，那么会遍历数组中的每一个元素，然后取得每一元素的对应的属性值，放在一个数组中
        NSArray *tempArray2=[persons valueForKeyPath:@"name"];//persons是数组类型，而键name是字符串，就是没有对应的数组类型的name属性，所以系统遍历persons数组中的每一个元素对应的name属性值，放在数组中赋值给tempArray2.
        NSLog(@"%@",tempArray2);//(zhangsan,lisi,wangwu)
        Book *book=[[Book alloc]init];
        book.name=@"九阴真经";
        person1.book=book;
        NSString *bookName=[person1.book valueForKeyPath:@"name"];
        NSString *bookName2=[person1 valueForKeyPath:@"book.name"];//这种方式也可以，因为ForKeyPath会层层遍历
        NSString *bookName3=[person1.book valueForKey:@"name"];//可以
        //NSString *bookName4=[person1 valueForKey:@"book.name"];//不可以，因为是ForKey,不会往下遍历
        NSLog(@"%@",bookName);//九阴真经
        NSLog(@"%@",bookName2);//九阴真经
        


        
    }
    return 0;
}
