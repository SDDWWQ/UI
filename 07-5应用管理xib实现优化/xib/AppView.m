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
@end

@implementation AppView
//重写AppView.h中模型的set方法，用参数来传递模型,将模型的赋值封装起来
-(void)setAppModel:(AppModel *)appModel{
    _appModel=appModel;
    self.headView.image=[UIImage imageNamed:appModel.icon];
    self.nameLabel.text=appModel.name;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
