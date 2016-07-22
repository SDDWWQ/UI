//
//  ViewController.m
//  12-图片轮播器
//
//  Created by shadandan on 16/7/4.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imagescroll;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePage;
@property(nonatomic,strong)NSTimer *timer;//定时器
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.
    CGFloat imageViewY=0;
    CGFloat imageViewW=self.imagescroll.frame.size.width;
    CGFloat imageViewH=self.imagescroll.frame.size.height;
    
    for(int i=0;i<5;i++){
        //1.1创建一个图片对象
        UIImageView *imageView=[[UIImageView alloc]init];
        //1.2设置frame
        CGFloat imageViewX=i*imageViewW;
        imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        //1.3将图片添加到scrollView中
        [self.imagescroll insertSubview:imageView atIndex:0];//添加到最底层
        //1.4设置imageView的图片
        NSString *imageName=[NSString stringWithFormat:@"img_0%d",i+1];//5张图片横着排列
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    //2.设置滚动范围
    self.imagescroll.contentSize=CGSizeMake(imageViewW*5, 0);
    //3.设置分页滚动
    self.imagescroll.pagingEnabled=YES;//以UIScrollView的宽度来分页的，并不是以图片的大小
    //4.设置总的页码数
    self.imagePage.numberOfPages=5;
    //5.设置代理
    self.imagescroll.delegate=self;
    
    //self.imagePage.currentPage=4;
    
    //6.添加定时器
    [self addTimer];

}
/**
 *  监听滚动
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    CGFloat offsetX=offset.x;
    CGFloat scrollW=scrollView.frame.size.width;
    //算出页码
    //int page=offsetX/scrollW;//x方向的偏移量除以imageView宽度就是当前页编号
    int page=(offsetX+0.5*scrollW)/scrollW;//当滑动超过一半时进到下一页，当下于一半时，回到上一页
    self.imagePage.currentPage=page;
}
/**
 *  跳到下一页
 */
-(void)nextImage{
    NSInteger page=self.imagePage.currentPage;
    //确定页数
    if (page==4) {
        page=0;
    }
    else{
        page++;
    }
    //根据页数确定滚动范围
    CGFloat scrollViewW=self.imagescroll.frame.size.width;
    //self.imagescroll.contentOffset=CGPointMake(scrollViewW*page, 0);
    CGPoint offset=CGPointMake(scrollViewW*page, 0);
    [self.imagescroll setContentOffset:offset animated:YES];
    
}
/**
 *  监听开始拖拽
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //调用停止定时器方法
    [self endTimer];
}
/**
 *  监听停止拖拽
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
/**
 *  添加定时器
 */
-(void)addTimer{
    //[NSTimer scheduledTimerWithTimeInterval:表示每隔多长时间执行方法
    //target:表示谁来调用这个方法
    //selector:表示要执行的方法
    //userInfo:
    //repeats:表示是否重复
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer=timer;//成员变量引用局部变量，实现局部变量值的存储
    //修改定时器的模式，让处理滚动操作如果不加这句话，当滚动文字时，定时器会暂停，即图片轮播会暂停，加上这句话就更改了定时源的模式，使其给定时器分流（分时间），当滚动文字时，定时器不会暂停，图片轮播器继续滚动
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  停止定时器
 */
-(void)endTimer{
    //停止定时器，定时器停止后，不能重新开启，要想再次使用，必须重新创建定时器
    [self.timer invalidate];
    self.timer=nil;//清空定时器
}
@end
