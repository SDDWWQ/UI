//
//  MessageCell.m
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
@interface MessageCell()
@property(nonatomic,weak)UILabel *lblTime;
@property(nonatomic,weak)UIImageView *iconView;
@property(nonatomic,weak)UIButton *btnText;
@end
@implementation MessageCell

//重写initwithStyle方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {//调用父类的初始化方法
        //创建子控件
        //显示时间的Label
        UILabel *lblTime=[[UILabel alloc]init];
        
        //设置字体大小
        lblTime.font=[UIFont systemFontOfSize:12];
        lblTime.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime=lblTime;
        //显示头像的UIImageView
        UIImageView *iconView=[[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView=iconView;
        //显示正文的按钮
        UIButton *btnText=[[UIButton alloc]init];
        //[btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       //
        //设置文字可以换行
        btnText.titleLabel.numberOfLines=0;
        [self.contentView addSubview:btnText];
        self.btnText=btnText;
    }
    //清除单元格的背景色
    self.backgroundColor=[UIColor clearColor];
    return self;
}
//重写frame模型的set方法
-(void)setMessageFrame:(MessageFrame *)messageFrame{
    _messageFrame=messageFrame;
    //获取数据模型
    MessageModel *message=messageFrame.message;
    //设置每个子控件的数据和frame
    //设置时间
    self.lblTime.text=message.time;
    self.lblTime.frame=messageFrame.timeFrame;
    self.lblTime.hidden=message.hideTime;
    //设置头像
    NSString *iconImageName=message.type?@"me.jpg":@"other.jpeg";
    self.iconView.image=[UIImage imageNamed:iconImageName];
    self.iconView.frame=messageFrame.iconFrame;
    //设置正文
    [self.btnText setTitle:message.text forState:UIControlStateNormal];
    //设置背景图
    NSString *chatBackgroundImage=message.type?@"chat_send_nor":@"chat_recive_nor";
    NSString *chatHighlightedImage=message.type?@"chat_send_press_pic":@"chat_recive_press_pic";
    UIImage *imgNormal=[UIImage imageNamed:chatBackgroundImage];
    UIImage *imgHighlighted=[UIImage imageNamed:chatHighlightedImage];
    
    //用平铺的方式拉伸图片
    imgNormal=[imgNormal stretchableImageWithLeftCapWidth:imgNormal.size.width*0.5 topCapHeight:imgNormal.size.height*0.5];
    imgHighlighted=[imgHighlighted stretchableImageWithLeftCapWidth:imgHighlighted.size.width*0.5 topCapHeight:imgHighlighted.size.height*0.5];
    [self.btnText setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imgHighlighted forState:UIControlStateHighlighted];
    
    self.btnText.titleLabel.font=textFont;
    
    //设置按钮中中文字的背景颜色
    //self.btnText.titleLabel.backgroundColor=[UIColor greenColor];
    //设置按钮的背景颜色
    //self.btnText.backgroundColor=[UIColor blueColor];
    
    //设置文字颜色
    if (message.type) {
        [self.btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    //设置文字距离按钮的内边距
    self.btnText.contentEdgeInsets=UIEdgeInsetsMake(15,20, 15, 20);
    self.btnText.frame=messageFrame.textFrame;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//封装一个创建自定义cell的方法
+(instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"massage_cell";
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
@end
