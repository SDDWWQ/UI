//
//  ViewController.m
//  06-TomCat
//
//  Created by shadandan on 16/6/23.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
- (IBAction)drink;
//猫
@property (weak, nonatomic) IBOutlet UIImageView *Tom;
- (IBAction)sleep;
-(void)runAnimationWithName:(NSString *)name andCount:(int)count;
@property(nonatomic,strong)AVAudioPlayer *play;
-(void)playSound:(NSString *)fileName;
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

    [self runAnimationWithName:@"drink"andCount:81];
    //[self playSound];
    //带有延时的调用
    [self performSelector:@selector(playSound:) withObject:@"p_drink_milk" afterDelay:0];
}
- (IBAction)sleep {
    [self runAnimationWithName:@"knockout"andCount:81];

    [self performSelector:@selector(playSound:) withObject:@"p_belly1" afterDelay:0];
       // [NSThread cancelPreviousPerformRequestsWithTarget:self.Tom selector:@selector(playSound:) object:@"p_belly1"];//修复同时点击两个按钮的声音覆盖bug，但未修改成功
}
-(void)runAnimationWithName:(NSString *)imageName andCount:(int)count{
    //0.判断是否在执行动画,若在执行就不响应新动画，为了不打断正在执行的动画
    if(self.Tom.isAnimating){
        return;
    }
    //1.获取图片
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<count; i++) {
        NSString *name=[NSString stringWithFormat:@"%@_%02d.jpg",imageName,i];
        
        //imagenamed加载完图片后图片驻留内存，不会释放，特别耗内存
        //UIImage *headImage=[UIImage imageNamed:name];
        //[images addObject:headImage];
        
        //imageWithContentsOfFile:图片不会驻留内存
        NSString *imagePath=[[NSBundle mainBundle]pathForResource:name ofType:nil];
        UIImage *head=[UIImage imageWithContentsOfFile:imagePath];
        [images addObject:head];
    }
    //2.告诉tom要播放哪些图片
    self.Tom.animationImages=images;
    //2.1设置播放动画的次数
    self.Tom.animationRepeatCount=1;
    //2.2设置时间
    self.Tom.animationDuration=images.count*0.05;//0.05表示每两张图片的间隔
    //3.播放
    [self.Tom startAnimating];
    //4.清空内存（当动画执行完毕后清空）
    //self.Tom.animationImages=nil;这种清空内存的方式是不正确的，因为动画的播放需要时间，此处相当于动画还没播放完就把图片清空了，就不会播放动画了
    //performSelector：表示要执行的方法
    //afterDelay:表示一段时间
    //withObject:表示方法的参数
    //第一种：
    //[self performSelector:@selector(clearCaceh) withObject:nil afterDelay:images.count*0.05];
    //第二种：
    [self.Tom performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:images.count*0.05];
    
}
//清空缓存
//-(void)clearCaceh{
//    self.Tom.animationImages=nil;
//    [self.Tom setAnimationImages:nil];
//}
-(void)playSound:(NSString *)fileName{
    //1.获取音效资源的路径
    NSString *path=[[NSBundle mainBundle]pathForResource:fileName ofType:@"wav"];
    //2.转换path为url
    NSURL *url=[NSURL fileURLWithPath:path];
    //3.创建播放器
    NSError *error=nil;
    AVAudioPlayer *play=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    self.play=play;//必须用强指针引用,直接[play play]调用是不可以的因为play是函数内部的局部变量，动画和音频的播放都是多线程的，交替执行的，不是按顺序依次执行，所以会出现局部变量在函数外部失效，发不出声音的现象
    //4.播放
    [self.play play];
}
@end
