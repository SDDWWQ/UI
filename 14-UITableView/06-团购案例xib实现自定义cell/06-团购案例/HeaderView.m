//
//  HeaderView.m
//  06-团购案例
//
//  Created by shadandan on 16/7/11.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePage;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)headerView{
    HeaderView *headerView=[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:nil options:nil]firstObject];
    return headerView;
}
//相当于在控制器的viewDidLoad下写代码
-(void)awakeFromNib{
    CGFloat imageW=300;
    CGFloat imageH=150;
    CGFloat imageY=0;
    for (int i=0; i<5; i++) {
        //1.1创建一个图片对象
        CGFloat imageX=i*imageW;
        UIImageView *imageView=[[UIImageView alloc]init];
        //1.2设置frame
        imageView.frame=CGRectMake(imageX, imageY, imageW, imageH);
        //1.3将图片添加到scrollView中
        [self.scrollView addSubview:imageView];
        //1.4设置imageView的图片
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ad_%02d.jpg",i]]];
    }
    //2.设置滚动范围
    self.scrollView.contentSize=CGSizeMake(4*imageW, imageH);
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
    self.imagePage.numberOfPages=4;
    [self addTimer];
    
}
//用于调节pageControl的显示和scrollView跳转到下一页（通过设置contentOffset实现）
-(void)nextImage{
    NSInteger page=self.imagePage.currentPage;
    if (page==3) {
        page=0;
    }else{
        page++;
    }
    self.page=page;
    //通过设置偏移量位置跳转到下一页
    [self.scrollView setContentOffset:CGPointMake(page*self.scrollView.frame.size.width, 0) animated:YES];
}

#pragma mark-scrollView的代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endTimer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算当前页码数，设置给pageControl显示
    CGPoint offset=self.scrollView.contentOffset;
    CGFloat offsetX=offset.x;
    CGFloat scrollW=self.scrollView.frame.size.width;
    int page=(offsetX+0.5*scrollW)/scrollW;
    self.imagePage.currentPage=page;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
-(void)addTimer{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer=timer;
}
-(void)endTimer{
    [self.timer invalidate];
    self.timer=nil;
}
@end
