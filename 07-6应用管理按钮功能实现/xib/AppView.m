//
//  AppView.m
//  xib
//
//  Created by shadandan on 16/6/28.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "AppView.h"

//创建延展类（匿名分类）
@interface AppView()
@property (weak, nonatomic) IBOutlet UIImageView *headView;//关联图片控件，用于后面给它赋值
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//关联label控件，用于后面给它赋值
- (IBAction)downLoad:(UIButton *)btn;
@end

@implementation AppView
//重写AppView.h中模型的set方法，用参数来传递模型,将模型的赋值封装起来
-(void)setAppModel:(AppModel *)appModel{
    _appModel=appModel;
    self.headView.image=[UIImage imageNamed:appModel.icon];
    self.nameLabel.text=appModel.name;
}

//加载appView
+(instancetype)loadView{
    return [[NSBundle mainBundle]loadNibNamed:@"appView" owner:nil options:nil][0];;

}

- (IBAction)downLoad:(UIButton *)btn {
    //1.让按钮不能点击
    btn.enabled=NO;
    //2.创建一个用来显示信息的Label
    UILabel *msgLabel=[[UILabel alloc]init];
    CGFloat msgLabelW=150;
    CGFloat msgLabelX=(self.superview.frame.size.width-msgLabelW)*0.5;
    CGFloat msgLabelH=30;
    CGFloat msgLabelY=(self.superview.frame.size.height-msgLabelH)*0.5;
    msgLabel.frame=CGRectMake(msgLabelX, msgLabelY, msgLabelW, msgLabelH);
    msgLabel.backgroundColor=[UIColor brownColor];
    [self.superview addSubview:msgLabel];
    msgLabel.alpha=0.0;//改变透明度
    msgLabel.text=@"正在下载";
    [msgLabel setTextColor:[UIColor redColor]];
    msgLabel.textAlignment=NSTextAlignmentCenter;
    //设置label框为圆角矩形
    //设置半径
    msgLabel.layer.cornerRadius=8;
    //切掉多余部分
    msgLabel.layer.masksToBounds=YES;
    //3.设置动画
    //animateWithDuration:动画执行的时间
    //animations:执行动画代码
    //completion:动画完成之后要做的事情
    [UIView animateWithDuration:2.0 animations:^{
        msgLabel.alpha=0.6;
    } completion:^(BOOL finished) {
        if(finished){
            //淡出Label
            // delay:延迟几秒后开始动画
            // options:执行动画方式，包括先快后慢等UIViewAnimationOptionCurveLinear表示匀速
            [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
                msgLabel.alpha=0.0;
            } completion:^(BOOL finished) {
                if (finished){
                //将控件从父控件中移出
                    [msgLabel removeFromSuperview];
                
                }
            }];
        }
    }];
}
@end
