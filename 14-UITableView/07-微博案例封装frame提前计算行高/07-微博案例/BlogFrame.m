//
//  BlogFrame.m
//  07-微博案例
//
//  Created by shadandan on 16/7/13.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BlogFrame.h"
#import "BlogModel.h"

@implementation BlogFrame
//重写blog属性的set方法，根据数据计算每个空间的frame和行高
-(void)setBlog:(BlogModel *)blog{
    _blog=blog;
    //1.头像
    CGFloat margin=10;//间距
    CGFloat iconX=margin;
    CGFloat iconY=margin;
    CGFloat iconW=35;
    CGFloat iconH=35;
    _iconFrame=CGRectMake(iconX, iconY, iconW, iconH);
    //2.昵称
    //获取昵称字符串
    NSString *name=self.blog.name;
    CGFloat nameX=CGRectGetMaxX(_iconFrame)+margin;
    
    //根据Label中文字的内容来动态计算Label的高和宽
    //NSDictionary *attr=@{NSFontAttributeName : NameLabelFontSize};
    //CGSize nameSize=[name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;//CGSizeMake(MAXFLOAT, MAXFLOAT)表示不限定大小，主要采用options:NSStringDrawingUsesLineFragmentOrigin来约束Label的宽高,attributes:attr用来设置字体,attributes必须是一个字典集合
    CGSize nameSize=[self sizeWithText:name andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameLabelFontSize];
    CGFloat nameW=nameSize.width;
    CGFloat nameH=nameSize.height;
    CGFloat nameY=iconY+(iconH-nameH)*0.5;
    NSLog(@"nameX=%f",nameSize.width);
    _nameFrame=CGRectMake(nameX, nameY, nameW, nameH);
    //3.会员
    CGFloat vipW=20;
    CGFloat vipH=20;
    CGFloat vipX=CGRectGetMaxX(_nameFrame)+margin;
    CGFloat vipY=nameY;
    _vipFrame=CGRectMake(vipX, vipY, vipW, vipH);
    NSLog(@"vip=%f",_vipFrame.origin.x);
    //4.正文
    CGFloat textX=iconX;
    CGFloat textY=CGRectGetMaxY(_iconFrame)+margin;
    NSString *text=self.blog.text;
    CGSize textSize=[self sizeWithText:text andMaxSize:CGSizeMake(300, MAXFLOAT) andFont:TextLabelFontSize];
    CGFloat textW=textSize.width;
    CGFloat textH=textSize.height;
    _textFrame=CGRectMake(textX, textY, textW, textH);
    //5.配图
    CGFloat picW=100;
    CGFloat picH=100;
    CGFloat picX=margin;
    CGFloat picY=CGRectGetMaxY(_textFrame)+margin;
    _imageFrame=CGRectMake(picX,picY,picW,picH);
    //6.计算每行的高度
    CGFloat rowHeight=0;
    if (self.blog.image) {//如果有配图，是配图的最大Y值+margin
        rowHeight=CGRectGetMaxY(_imageFrame)+margin;
    }else{//如果没有配图，那么行高等于正文的最大Y值+margin
        rowHeight=CGRectGetMaxY(_textFrame)+margin;
    }
    //计算完行高，不要忘记给属性赋值
    _rowHeight=rowHeight;
    

}
//封装计算文本框大小的方法
//根据给定的字符串、最大值的Size，给定的字体，来计算文字应该占用的大小
-(CGSize)sizeWithText:(NSString *) text andMaxSize:(CGSize) maxSize andFont:(UIFont *)font{
    NSDictionary *attr=@{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}


@end
