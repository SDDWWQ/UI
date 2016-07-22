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
    //2.调用代理方法
    if ([self.delegate respondsToSelector:@selector(appViewBtnClick:)]) {
        [self.delegate appViewBtnClick:self];
    }
}
@end
