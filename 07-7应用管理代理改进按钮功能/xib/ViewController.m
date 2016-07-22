//
//  ViewController.m
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
#import "AppView.h"
@interface ViewController ()<appViewDelegate>//遵循协议
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
        //添加一个xib，该函数返回值是数组，因为一个xib中可以添加多个空间，以数组的形式存储的，xib与AppView相关联，所以是AppView类型的，取xib就取第0个元素，或firstObjec或lastObject
        //AppView *appView=[[NSBundle mainBundle]loadNibNamed:@"appView" owner:nil options:nil][0];//封装到xib的类方法中来改进
        
        AppView *appView=[AppView loadView];//调用AppView的类方法加载xib
        
        int col=i%3;//列数
        int row=i/3;//行数
        //设置位置
        CGFloat appViewX=leftXmargin+(appViewW+spaceXmargin)*col;
        CGFloat appViewY=topYmargin+(appViewH+spaceYmargin)*row;
        appView.frame=CGRectMake(appViewX, appViewY, appViewW, appViewH);
        //给appView设置代理
        appView.delegate=self;
        
        //3.添加UIView
        [self.view addSubview:appView];
        AppModel *appViewModel=self.apps[i];
        appView.appModel=appViewModel;//给AppView的对象中的模型赋值，即是给xib赋值
        
        //由于xib可能在多处被重复调用，因此下面的代码可能会需要重复多次，因此将其封装到AppView中进行改进
        /*
        //4.获取xib中的子控件并赋值
        //方法1：设置xib中子控件的tag值，在程序中用tag值设置图片
        //方法2：xib中的子控件也是在数组中存储的，用数组取子控件
        UIImageView *headView=(UIImageView *)appView.subviews[0];
        headView.image=[UIImage imageNamed:appViewModel.icon];
        UILabel *nameLabel=(UILabel *)appView.subviews[1];
        nameLabel.text=appViewModel.name;
         */
        

    }
}
/**
 *  实现代理方法
 */
-(void)appViewBtnClick:(AppView *)appview {
    //2.创建一个用来显示信息的Label
    UILabel *msgLabel=[[UILabel alloc]init];
    CGFloat msgLabelW=150;
    CGFloat msgLabelX=(self.view.frame.size.width-msgLabelW)*0.5;
    CGFloat msgLabelH=30;
    CGFloat msgLabelY=(self.view.frame.size.height-msgLabelH)*0.5;
    msgLabel.frame=CGRectMake(msgLabelX, msgLabelY, msgLabelW, msgLabelH);
    msgLabel.backgroundColor=[UIColor brownColor];
    [self.view addSubview:msgLabel];
    msgLabel.alpha=0.0;//改变透明度
    msgLabel.text=@"正在下载";
    [msgLabel setTextColor:[UIColor redColor]];
    msgLabel.textAlignment=NSTextAlignmentCenter;
    //设置label框为圆角矩形
    //设置半径
    msgLabel.layer.cornerRadius=8;
    //切掉多余部分
    msgLabel.layer.masksToBounds=YES;
    //3.设置动画
    //animateWithDuration:动画执行的时间
    //animations:执行动画代码
    //completion:动画完成之后要做的事情
    [UIView animateWithDuration:2.0 animations:^{
        msgLabel.alpha=0.6;
    } completion:^(BOOL finished) {
        if(finished){
            //淡出Label
            // delay:延迟几秒后开始动画
            // options:执行动画方式，包括先快后慢等UIViewAnimationOptionCurveLinear表示匀速
            [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
                msgLabel.alpha=0.0;
            } completion:^(BOOL finished) {
                if (finished){
                    //将控件从父控件中移出
                    [msgLabel removeFromSuperview];
                    
                }
            }];
        }
    }];

}
@end
