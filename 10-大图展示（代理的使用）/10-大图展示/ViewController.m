//
//  ViewController.m
//  10-大图展示
//
//  Created by shadandan on 16/7/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
//遵循协议
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;
- (IBAction)scroll:(id)Btn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.设置滚动范围
    //方式1：self.imageScroll.contentSize=CGSizeMake(470,700);
    //方式2：
    CGSize imageSize=self.scanImageView.frame.size;
    self.imageScroll.contentSize=imageSize;
    
    //2.设置偏移量
    self.imageScroll.contentOffset=CGPointMake(100, 100);
    //3.增加上左下右的额外滚动范围
    self.imageScroll.contentInset=UIEdgeInsetsMake(20, 40, 80, 100);
    //4.设置代理
    self.imageScroll.delegate=self;//设置代理为当前控制器
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scroll:(id)Btn {
   // 1.获取scroll的偏移量
    CGPoint imageOffset=self.imageScroll.contentOffset;
    CGFloat offsetX=imageOffset.x+10;
    CGFloat offsetY=imageOffset.y+10;
    //方式1：
    self.imageScroll.contentOffset=CGPointMake(offsetX, offsetY);
    //方式2：动画的方式移动
    CGPoint newImageOffset=CGPointMake(offsetX, offsetY);
    [self.imageScroll setContentOffset:newImageOffset animated:YES];
}
/**
 *  实现开始拖拽方法,只要鼠标拖拽图片就会调用此方法
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"开始拖拽了");
}
/**
 *  实现正在拖拽方法
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"x=%f",scrollView.contentOffset.x);
}
/**
 *  实现停止拖拽方法,松开鼠标就是停止了
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"停止了");
}
@end
