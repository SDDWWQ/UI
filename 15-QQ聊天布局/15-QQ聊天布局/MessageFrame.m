//
//  MessageFrame.m
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "MessageFrame.h"
#import "NSString+NSStringExt.h"
@implementation MessageFrame
//重写数据的set方法
-(void)setMessage:(MessageModel *)message{
    _message=message;
    //计算每个控件的frame和行高
    //获取屏幕宽度
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat margin=5;
    //计算时间Label的frame
    CGFloat timeX=0,timeY=0,timeW=screenW,timeH=15;
    if (!message.hideTime) {//如果当前时间不隐藏，则设置时间Label的frame值，如果隐藏了，则不需要设置当前Label的frame，默认就都是0
         _timeFrame=CGRectMake(timeX, timeY, timeW, timeH);
    }
   
    //计算头像的frame
    CGFloat iconW=30,iconH=30,iconY=CGRectGetMaxY(_timeFrame)+margin;
    
    CGFloat iconX=(message.type==MessageTypeOther)?margin:screenW-margin-iconW;
    _iconFrame=CGRectMake(iconX, iconY, iconW, iconH);
    //计算聊天内容
    //先计算正文的大小，再计算X值Y值
    CGSize textSize=[message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) font:textFont];
    CGFloat textW=textSize.width+40,textH=textSize.height+30;
    CGFloat textX=(message.type==MessageTypeOther)?CGRectGetMaxX(_iconFrame):(screenW
    -margin-iconW-textW);
    CGFloat textY=iconY;
    _textFrame=CGRectMake(textX, textY, textW, textH);
    
    //计算行高，头像和正文最大Y值中较大的哪一个+margin
    CGFloat maxY=MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight=maxY+margin;
    
}

@end
