//
//  ViewController.m
//  02-按钮的基本使用
//
//  Created by shadandan on 16/6/17.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//上
-(IBAction)up;
//下
-(IBAction)down;
//左
-(IBAction)left;
//右
-(IBAction)right;
//放大
-(IBAction)bigger;
//缩小
-(IBAction)smaller;
@property(nonatomic,weak)IBOutlet UIButton *dingdang;
//移动
-(IBAction)move:(UIButton *)btn;
@end

@implementation ViewController

//上
-(IBAction)up{
    //self.dingdang.frame.origin.y=self.dingdang.frame.origin.y-10;//错误。不能直接访问对象的 结构体属性的 成员变量，能够访问对象的结构体属性
    //可以用frame属性来移动，也可以用center属性来移动
    //1.拿到对象的结构体属性frame，赋值给临时变量
    CGRect tempFrame=self.dingdang.frame;
    //2.修改临时变量的值
    tempFrame.origin.y-=10;
    //3.用临时变量的值覆盖原来的变量
    self.dingdang.frame=tempFrame;
}
//下
-(IBAction)down{
    //1.拿到对象的结构体属性frame，赋值给临时变量
    CGRect tempFrame=self.dingdang.frame;
    NSLog(@"%f",self.dingdang.frame.origin.y);
    //2.修改临时变量的值
    tempFrame.origin.y+=10;
    //3.用临时变量的值覆盖原来的变量
    self.dingdang.frame=tempFrame;

}
//左
-(IBAction)left{
    CGRect tempFrame=self.dingdang.frame;
    tempFrame.origin.x-=10;
    self.dingdang.frame=tempFrame;
}
//右
-(IBAction)right{
    //1.拿到对象的结构体属性frame，赋值给临时变量
    CGRect tempFrame=self.dingdang.frame;
    //2.修改临时变量的值
    tempFrame.origin.x+=10;
    //3.用临时变量的值覆盖原来的变量
    self.dingdang.frame=tempFrame;

}
//放大
-(IBAction)bigger{
    //bounds以中心点不变来放大，frame以左上角的点不变来放大
    CGRect tempFrame=self.dingdang.frame;
    tempFrame.size.width+=10;
    tempFrame.size.height+=10;
    self.dingdang.frame=tempFrame;
}
//缩小
-(IBAction)smaller{
    CGRect tempFrame=self.dingdang.frame;
    tempFrame.size.width-=10;
    tempFrame.size.height-=10;
    self.dingdang.frame=tempFrame;
}
//移动，当用一个方法监听按钮点击的时候，如果传入一个参数，我们会把点击的按钮当成参数传递
-(IBAction)move:(UIButton*)btn{
    NSLog(@"移动");
    //0.开启动画
    [UIView beginAnimations:nil context:nil];
    //0.1设置动画的时间
    [UIView setAnimationDuration:2.0];
    //1.拿到对象的结构体属性frame，赋值给临时变量
    CGRect tempFrame=self.dingdang.frame;
    //2.根据按钮修改临时变量的值
    CGFloat margin=10;
    switch(btn.tag){
        case 10:
             tempFrame.origin.y-=margin;
            break;
        case 20:
            tempFrame.origin.x+=margin;
            break;
        case 30:
            tempFrame.origin.y+=margin;
            break;
        case 40:
            tempFrame.origin.x-=margin;
            break;
    }
    //3.用临时变量的值覆盖原来的变量
    self.dingdang.frame=tempFrame;
    //4.提交动画
    [UIView commitAnimations];
}
@end
