//
//  FooterView.m
//  06-团购案例
//
//  Created by shadandan on 16/7/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "FooterView.h"

@interface FooterView()
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *waitingView;
- (IBAction)btnLoadMoreClick;

@end
@implementation FooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//定义类方法，通过xib创建UITableViewCell
+(instancetype)footerView{
    //通过xib设置UITableView的footerView
    FooterView *footerView=[[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:nil]firstObject];
    
    return footerView;

}
//加载更多按钮的点击事件
- (IBAction)btnLoadMoreClick {
    //1.隐藏“加载更多”Label
    self.btnLoadMore.hidden=YES;
    //2.显示“等待指示器”所在的那个UIView
    self.waitingView.hidden=NO;
    
    //延迟1s之后执行代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //3.调用代理方法实现添加并更新数据
        if ([self.delegate respondsToSelector:@selector(footerViewUpdateData:)]){//判断是否实现了这个代理方法
            [self.delegate footerViewUpdateData:self];
        }
        //要把这部分代码也加到延迟当中，否则显示不出来等待指示器的内容
        //4.显示“加载更多”按钮
        self.btnLoadMore.hidden=NO;
        //5.隐藏“等待指示器”所在的UIView
        self.waitingView.hidden=YES;
    });
    }
@end
