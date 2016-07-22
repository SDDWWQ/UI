//
//  ViewController.m
//  21-代码实现autoresizing
//
//  Created by shadandan on 16/7/20.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)btnClick;
@property(nonatomic,weak)UIView *blueView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建蓝色View
    UIView *blueView=[[UIView alloc]init];
    CGFloat blueX=0;
    CGFloat blueY=0;
    CGFloat blueW=200;
    CGFloat blueH=200;
    blueView.frame=CGRectMake(blueX, blueY, blueW, blueH);
    blueView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:blueView];
    self.blueView=blueView;
    //创建红色View
    UIView *redView=[[UIView alloc]init];
    CGFloat redX=0;
    CGFloat redW=blueW;
    CGFloat redH=80;
    CGFloat redY=blueH-redH;
    redView.frame=CGRectMake(redX, redY, redW, redH);
    redView.backgroundColor=[UIColor redColor];
    [blueView addSubview:redView];
    //设置autoresizing
    //设置红色view距离蓝色view底部距离保持不变
    /*
    UIViewAutoresizingNone                 = 0,
    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,//表示距离父控件左边是可伸缩的，相当于把右边的横杠选中了
    UIViewAutoresizingFlexibleWidth        = 1 << 1,//表示宽度会随着父控件宽度的变化而变化，相当于把中间的横杠选中了
    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
    UIViewAutoresizingFlexibleHeight       = 1 << 4,
    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
     */
    redView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;//设置上方距离不变，宽度可变，因为是位枚举，所以用|连接


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick{
    //增加蓝色View的高度和宽度
    CGRect blueFrame=self.blueView.frame;
    blueFrame.size.height+=20;
    blueFrame.size.width+=20;
    self.blueView.frame=blueFrame;
}
@end
