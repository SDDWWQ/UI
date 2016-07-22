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
       // appView.backgroundColor=[UIColor blueColor];
        //取出数据
        AppModels *appModel=self.apps[i];
        
        //5.添加控件
        //5.1添加图片
        NSString *imageName=appModel.icon;
        UIImage *image=[UIImage imageNamed:imageName];
        UIImageView *imageView=[[UIImageView alloc]init];
        
        CGFloat imageViewW=60;
        CGFloat imageViewH=50;
        CGFloat imageViewX=(appViewW-imageViewW)*0.5;
        CGFloat imageViewY=0;

        imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        [imageView initWithImage:image];
        [appView addSubview:imageView];
        //imageView.backgroundColor=[UIColor redColor];
        
        //5.2添加名称
        UILabel *nameLabel=[[UILabel alloc]init];
        CGFloat nameLabelX=0;
        CGFloat nameLabelY=imageViewY+imageViewH;
        CGFloat nameLabelW=appViewW;
        CGFloat nameLabelH=30;
        nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
        nameLabel.text=appModel.name;
        nameLabel.textAlignment=NSTextAlignmentCenter;//文本居中
        nameLabel.font=[UIFont systemFontOfSize:14];//设置文本大小
        [appView addSubview:nameLabel];
        //nameLabel.backgroundColor=[UIColor yellowColor];
        
        //5.3添加按钮
        UIButton *button=[[UIButton alloc]init];
        CGFloat buttonX=10;
        CGFloat buttonY=nameLabelY+nameLabelH+10;
        CGFloat buttonW=appViewW-2*buttonX;
        CGFloat buttonH=30;
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //button.backgroundColor=[UIColor greenColor];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        [appView addSubview:button];
        [button setTitle:@"下载" forState:UIControlStateNormal];
    }
    
}


@end
