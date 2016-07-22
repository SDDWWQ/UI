//
//  BlogCell.m
//  07-微博案例
//
//  Created by shadandan on 16/7/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BlogCell.h"
#define NameLabelFontSize [UIFont systemFontOfSize:12]
#define TextLabelFontSize [UIFont systemFontOfSize:14]
@interface BlogCell()
@property(nonatomic,weak)UIImageView *imgViewIcon;
@property(nonatomic,weak)UILabel *lblName;
@property(nonatomic,weak)UIImageView *imgViewVip;
@property(nonatomic,weak)UILabel *lblText;
@property(nonatomic,weak)UIImageView *imgViewPicture;
@end
@implementation BlogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//重写UItableViewCell的initWithStyle方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建5个子控件
        //1.头像
        UIImageView *imgViewIcon=[[UIImageView alloc]init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon=imgViewIcon;//将控件定义为属性，是为了在其他函数中访问
        //2.昵称
        UILabel *lblName=[[UILabel alloc]init];
        [self.contentView addSubview:lblName];
        lblName.font=NameLabelFontSize;//用宏定义了用户名字体大小
        self.lblName=lblName;
        //3.会员
        UIImageView *imgViewVip=[[UIImageView alloc]init];
        [self.contentView addSubview:imgViewVip];
        imgViewVip.image=[UIImage imageNamed:@"vip.jpg"];//可以在这创建时就写死，因为所有会员的图标是一样的，不必每次都重新设置
        self.imgViewVip=imgViewVip;
        //4.正文
        UILabel *lblText=[[UILabel alloc]init];
        [self.contentView addSubview:lblText];
        lblText.font=TextLabelFontSize;//用宏设置正文字体大小
        //设置正文Label可以自动换行
        lblText.numberOfLines=0;
        self.lblText=lblText;
        //5.配图
        UIImageView *imgViewPicture=[[UIImageView alloc]init];
        [self.contentView addSubview:imgViewPicture];
        self.imgViewPicture=imgViewPicture;
    }
    return self;
}
#pragma mark-重写blog属性的set方法
-(void)setBlog:(BlogModel *)blog{
    _blog=blog;
    //1.设置当前单元格中的子控件数据
    [self settingData];
    //2.设置当前单元格中的子控件的frame
    [self settingFrame];
}
//设置数据的方法
-(void)settingData{
    BlogModel *blog=self.blog;
    self.imgViewIcon.image=[UIImage imageNamed:blog.icon];
    self.lblName.text=blog.name;
    //判断是否是会员，是否显示会员图标
    if(blog.isVip){
        NSLog(@"isvip");
        self.imgViewVip.hidden=NO;
    }else{
        self.imgViewVip.hidden=YES;
    }
    self.lblText.text=blog.text;
    if (blog.image==nil) {
        self.imgViewPicture.hidden=YES;
    }else{
        self.imgViewPicture.image=[UIImage imageNamed:blog.image];
        self.imgViewPicture.hidden=NO;
    }
}
//设置frame的方法
-(void)settingFrame{
   //1.头像
    CGFloat margin=10;
    CGFloat iconX=margin;
    CGFloat iconY=margin;
    CGFloat iconW=35;
    CGFloat iconH=35;
    self.imgViewIcon.frame=CGRectMake(iconX, iconY, iconW, iconH);
    //2.昵称
    //获取昵称字符串
    NSString *name=self.lblName.text;
    CGFloat nameX=CGRectGetMaxX(self.imgViewIcon.frame)+margin;
    
    //根据Label中文字的内容来动态计算Label的高和宽
    //NSDictionary *attr=@{NSFontAttributeName : NameLabelFontSize};
    //CGSize nameSize=[name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;//CGSizeMake(MAXFLOAT, MAXFLOAT)表示不限定大小，主要采用options:NSStringDrawingUsesLineFragmentOrigin来约束Label的宽高,attributes:attr用来设置字体,attributes必须是一个字典集合
    CGSize nameSize=[self sizeWithText:name andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameLabelFontSize];
    CGFloat nameW=nameSize.width;
    CGFloat nameH=nameSize.height;
    CGFloat nameY=iconY+(iconH-nameH)*0.5;
    self.lblName.frame=CGRectMake(nameX, nameY, nameW, nameH);
    //3.会员
    CGFloat vipW=20;
    CGFloat vipH=20;
    CGFloat vipX=CGRectGetMaxX(self.lblName.frame)+margin;
    CGFloat vipY=nameY;
    self.imgViewVip.frame=CGRectMake(vipX, vipY, vipW, vipH);
    //4.正文
    CGFloat textX=iconX;
    CGFloat textY=CGRectGetMaxY(self.imgViewIcon.frame)+margin;
    NSString *text=self.lblText.text;
    CGSize textSize=[self sizeWithText:text andMaxSize:CGSizeMake(300, MAXFLOAT) andFont:TextLabelFontSize];
    CGFloat textW=textSize.width;
    CGFloat textH=textSize.height;
    self.lblText.frame=CGRectMake(textX, textY, textW, textH);
    //5.配图
    CGFloat picW=100;
    CGFloat picH=100;
    CGFloat picX=margin;
    CGFloat picY=CGRectGetMaxY(self.lblText.frame)+margin;
    self.imgViewPicture.frame=CGRectMake(picX,picY,picW,picH);
    //6.计算每行的高度
    CGFloat rowHeight=0;
    if (self.blog.image) {//如果有配图，是配图的最大Y值+margin
        rowHeight=CGRectGetMaxY(self.imgViewPicture.frame)+margin;
    }else{//如果没有配图，那么行高等于正文的最大Y值+margin
        rowHeight=CGRectGetMaxY(self.lblText.frame)+margin;
    }
    
}

//封装计算文本框大小的方法
//根据给定的字符串、最大值的Size，给定的字体，来计算文字应该占用的大小
-(CGSize)sizeWithText:(NSString *) text andMaxSize:(CGSize) maxSize andFont:(UIFont *)font{
     NSDictionary *attr=@{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end
