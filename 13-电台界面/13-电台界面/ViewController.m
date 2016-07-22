//
//  ViewController.m
//  13-电台界面
//
//  Created by shadandan on 16/7/5.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *lastImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.设置滚动范围
    //self.scrollView.contentSize=CGSizeMake(0, self.lastImageView.frame.size.height+self.lastImageView.frame.origin.y);
    self.scrollView.contentSize=CGSizeMake(0, CGRectGetMaxY(self.lastImageView.frame));//可以直接获取控件的下边界y值
    //2.设置额外滚动范围
    self.scrollView.contentInset=UIEdgeInsetsMake(64, 0, 60, 0);
    //3.设置初始偏移
    self.scrollView.contentOffset=CGPointMake(0, -64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
