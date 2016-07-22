//
//  ViewController.m
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
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
            AppModel *appModel=[AppModel appModelWithDict:dict];//类方法字典转化为模型
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
    //NSLog(@"%ld",self.apps.count);
    for (int i=0; i<self.apps.count; i++) {
        //添加一个xib，该函数返回值是数组，因为一个xib中可以添加多个空间，以数组的形式存储的，取xib就取第0个元素，或firstObjec或lastObject
        UIView *appView=[[NSBundle mainBundle]loadNibNamed:@"appView" owner:nil options:nil][0];

        
        int col=i%3;//列数
        int row=i/3;//行数
        //设置位置
        CGFloat appViewX=leftXmargin+(appViewW+spaceXmargin)*col;
        CGFloat appViewY=topYmargin+(appViewH+spaceYmargin)*row;
        appView.frame=CGRectMake(appViewX, appViewY, appViewW, appViewH);
        //3.添加UIView
        [self.view addSubview:appView];
        AppModel *appModel=self.apps[i];
        //4.获取xib中的子控件并赋值
        //方法1：设置xib中子控件的tag值，在程序中用tag值设置图片
        //方法2：xib中的子控件也是在数组中存储的，用数组取子控件
        UIImageView *headView=(UIImageView *)appView.subviews[0];
        headView.image=[UIImage imageNamed:appModel.icon];
        UILabel *nameLabel=(UILabel *)appView.subviews[1];
        nameLabel.text=appModel.name;
    }

}

@end
