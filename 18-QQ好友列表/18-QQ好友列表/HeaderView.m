//
//  HeaderView.m
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()
@property(nonatomic,weak)UIButton *button;
@property(nonatomic,weak)UILabel *label;
@end
@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)GroupHeaderView:(UITableView *)tableView{
    static NSString *ID=@"header_view";
    HeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header==nil) {
        header=[[HeaderView alloc]initWithReuseIdentifier:ID];
    }
    return header;

}
//重写initWithReuseIdentifier方法
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithReuseIdentifier:reuseIdentifier]){
        //创建按钮
        UIButton *button=[[UIButton alloc]init];
        [self.contentView addSubview:button];
        [button setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置左对齐
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        //设置button整体内容的边界
        button.contentEdgeInsets=UIEdgeInsetsMake(0,10, 0, 0);
        //设置button中title的边界
        button.titleEdgeInsets=UIEdgeInsetsMake(0,10, 0, 0);
        //给按钮增加一个点击事件
        [button addTarget:self action:@selector(titleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        self.button=button;
        //创建Label
        UILabel *label=[[UILabel alloc]init];
        [self.contentView addSubview:label];
        self.label.textAlignment=NSTextAlignmentRight;
        self.label=label;
    }
    return self;
}
//重写group的set方法
-(void)setGroup:(GroupModel *)group{
    _group=group;
    //设置按钮上的文字
    [self.button setTitle:group.name forState:UIControlStateNormal];
    //设置Label上的文字
    self.label.text=[NSString stringWithFormat:@"%d/%ld",self.group.online,self.group.friends.count];
    //设置frame的代码不要写在这里，因为此时的frame值都是0
    
    //解决按钮中的图片旋转问题（由于单元格重用，如果不把tup重新设置会出现，和之前的单元格一样保持旋转的状态错误问题）
    if (self.group.isVisible) {
        //让组标题中的图片旋转90°
        self.button.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.button.imageView.transform=CGAffineTransformMakeRotation(0);
    }

}
//当当前控件的frame发生变化的时候，此方法会被调用，重新布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置frame
    self.button.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGFloat labelH=40;
    CGFloat labelW=100;
    CGFloat margin=10;
    self.label.frame=CGRectMake((self.frame.size.width-margin-labelW), (self.frame.size.height-labelH)*0.5, self.frame.size.width, self.frame.size.height);
}
//按钮点击执行的方法
-(void)titleBtnDidClick{
    //设置组的状态

    self.group.visible=!self.group.isVisible;//每点击一次，组的状态都和当前状态值相反
    
    //刷新tableView，通过代理来实现
    if([self.delegate respondsToSelector:@selector(headerViewClick:)]){
        [self.delegate headerViewClick:self];
    }
    //
   // self.button.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
}
//当一个新的HeaderView已经加到某个父控件中的时候执行这个方法
-(void)didMoveToSuperview{
    if (self.group.isVisible) {
        //让组标题中的图片旋转90°
        self.button.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.button.imageView.transform=CGAffineTransformMakeRotation(0);
    }
}
@end
