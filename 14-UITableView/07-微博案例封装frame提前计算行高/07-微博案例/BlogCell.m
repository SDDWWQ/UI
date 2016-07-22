//
//  BlogCell.m
//  07-微博案例
//
//  Created by shadandan on 16/7/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BlogCell.h"

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
-(void)setBlogFrame:(BlogFrame *)blogFrame{
    _blogFrame=blogFrame;
    //1.设置当前单元格中的子控件数据
    [self settingData];
    //2.设置当前单元格中的子控件的frame
    [self settingFrame];
}
//设置数据的方法，从BlogFrame模型中取出blog的数据赋值给各控件
-(void)settingData{
    BlogModel *blog=self.blogFrame.blog;
    self.imgViewIcon.image=[UIImage imageNamed:blog.icon];
    self.lblName.text=blog.name;
    //判断是否是会员，是否显示会员图标
    NSLog(@"%d",blog.isVip);
    if(blog.isVip){
        self.imgViewVip.hidden=NO;
        self.lblName.textColor=[UIColor redColor];

    }else{
        self.imgViewVip.hidden=YES;
        self.lblName.textColor=[UIColor blackColor];
    }
    self.lblText.text=blog.text;
    if (blog.image==nil) {
        self.imgViewPicture.hidden=YES;
    }else{
        self.imgViewPicture.image=[UIImage imageNamed:blog.image];
        self.imgViewPicture.hidden=NO;
    }
}
//设置frame的方法，将BlogFrame模型中的控件的位置、大小数据赋值给各控件
-(void)settingFrame{
   //1.头像
    self.imgViewIcon.frame=self.blogFrame.iconFrame;
    //2.昵称
    self.lblName.frame=self.blogFrame.nameFrame;
    //3.会员
    self.imgViewVip.frame=self.blogFrame.vipFrame;
    //4.正文
    self.lblText.frame=self.blogFrame.textFrame;
    //5.配图
    self.imgViewPicture.frame=self.blogFrame.imageFrame;
}
//创建单元格-单元格重用
+(instancetype)BlogCellWithTableView:(UITableView *)tableView{
    BlogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blog_cell"];
    if (cell==nil) {
        cell=[[BlogCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"blog_cell"];
    }
    return cell;
}

@end
