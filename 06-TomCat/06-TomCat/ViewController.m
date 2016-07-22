//
//  ViewController.m
//  06-TomCat
//
//  Created by shadandan on 16/6/23.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)drink;
//猫
@property (weak, nonatomic) IBOutlet UIImageView *Tom;
- (IBAction)sleep;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drink {
    //1.获取图片
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<81; i++) {
        NSString *name=[NSString stringWithFormat:@"drink_%02d.jpg",i];
        UIImage *headImage=[UIImage imageNamed:name];
        [images addObject:headImage];
    }
    //2.告诉tom要播放哪些图片
    self.Tom.animationImages=images;
    //2.1设置播放动画的次数
    self.Tom.animationRepeatCount=1;
    //2.2设置时间
    self.Tom.animationDuration=images.count*0.05;//0.05表示每两张图片的间隔
    //3.播放
    [self.Tom startAnimating];
}
- (IBAction)sleep {
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<81; i++) {
        NSString *name=[NSString stringWithFormat:@"knockout_%02d.jpg",i];
        UIImage *headImage=[UIImage imageNamed:name];
        [images addObject:headImage];
    }
    self.Tom.animationImages=images;
    self.Tom.animationRepeatCount=1;
    self.Tom.animationDuration=images.count*0.05;
    [self.Tom startAnimating];
}
@end
