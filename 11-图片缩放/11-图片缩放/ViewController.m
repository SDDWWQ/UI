//
//  ViewController.m
//  11-图片缩放，按住option键用鼠标拖,松开鼠标，就可以实现缩放
//
//  Created by shadandan on 16/7/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scaleScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scaleScrollView.delegate=self;//设置代理
    //设置缩放比例
    self.scaleScrollView.maximumZoomScale=2;
    self.scaleScrollView.minimumZoomScale=0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  通过实现代理方法告诉scroll缩放哪个控件
 */
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{//如果有多个UIScrollView，可以用控件的tag值加以区分，加入判断if(scrollView.tag=10)
    
    return self.image;
}
@end
