//
//  ViewController.m
//  04-用代码创建按钮
//
//  Created by shadandan on 16/6/20.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//视图加载完毕后自动调用
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建按钮
    UIButton *dingdang=[[UIButton alloc]init];
    //2.设置位置
    dingdang.frame=CGRectMake(100, 100, 120, 120);
    //3.添加
    [self.view addSubview:dingdang];
    //4.设置背景图片
    UIImage *normalImage=[UIImage imageNamed:@"btn_01"];
    //4.1设置普通状态的背景图片
    [dingdang setBackgroundImage:normalImage forState:UIControlStateNormal];
    UIImage *highlightedImage=[UIImage imageNamed:@"btn_02"];
    //4.2设置高亮状态的背景图片
    [dingdang setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    //5.设置文字
    NSString *title=@"点我啊";
    [dingdang setTitle:title forState:UIControlStateNormal];
    NSString *titleHighlighted=@"点我干啥";
    [dingdang setTitle:titleHighlighted forState:UIControlStateHighlighted];
    //6.设置文字的颜色
    UIColor *color=[UIColor blackColor];
    [dingdang setTitleColor:color forState:UIControlStateNormal];
    UIColor *highlightedcolor=[UIColor blueColor];
    [dingdang setTitleColor:highlightedcolor forState:UIControlStateHighlighted];
    //7.监听按钮点击的方法
    //addTarget:表示监听器，当前的监听器是控制器self
    //forControlEvents:监听到的事件
    //action:监听到事件后要做的事情，必须包装成SEL类型
    [dingdang addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    //8.添加一个加号
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:addBtn];
    //9.监听多个按钮点击
    [addBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)btn:(UIButton *)btn{
    NSLog(@"点击的按钮是%@",btn);
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
//内存泄露的时候才会用到
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
