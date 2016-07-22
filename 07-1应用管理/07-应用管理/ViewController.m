//
//  ViewController.m
//  07-应用管理
//
//  Created by shadandan on 16/6/27.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "AppModels.h"
@interface ViewController ()
//用来存放数据
@property(nonatomic,strong)NSArray *apps;
@end

@implementation ViewController
//懒加载,并使用模型
-(NSArray *)apps{
    if(_apps==nil){
        //1.获取全路径
        NSString *path=[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil];
        //2.读取plist文件
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        //3.字典转型
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            AppModels *appModel=[[AppModels alloc]init];
            appModel.icon=dict[@"icon"];
            appModel.name=dict[@"name"];
            [tempArray addObject:appModel];
            
        }
        _apps=tempArray;
        
    }
    return _apps;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat appViewW=100;
    CGFloat appViewH=120;
    CGFloat spaceXmargin=10;//列之间的间隙值
    CGFloat spaceYmargin=20;//行之间的间隙值
    //左边界长度
    CGFloat leftXmargin=(self.view.frame.size.width-appViewW*3-spaceXmargin*2)*0.5;
    //上边界长度
    CGFloat topYmargin=(self.view.frame.size.height-appViewH*4-spaceYmargin*3)*0.5;
    NSLog(@"%ld",self.apps.count);
    for (int i=0; i<self.apps.count; i++) {
        int col=i%3;//列数
        int row=i/3;//行数
        //1.添加格子
        UIView *appView=[[UIView alloc]init];
        //2.设置位置
        CGFloat appViewX=leftXmargin+(appViewW+spaceXmargin)*col;
        CGFloat appViewY=topYmargin+(appViewH+spaceYmargin)*row;

        appView.frame=CGRectMake(appViewX, appViewY, appViewW, appViewH);
        //3.添加UIView
        [self.view addSubview:appView];
        //4.更改颜色
        appView.backgroundColor=[UIColor blueColor];
    }
    
}


@end
