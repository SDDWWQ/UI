//
//  ViewController.m
//  10-大图展示
//
//  Created by shadandan on 16/7/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
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
@end
