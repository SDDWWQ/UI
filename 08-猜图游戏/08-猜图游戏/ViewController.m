//
//  ViewController.m
//  08-猜图游戏
//
//  Created by shadandan on 16/6/29.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "QuestionModel.h"
@interface ViewController ()<UIAlertViewDelegate>//遵循协议
- (IBAction)next;
/**
 *  索引值
 */
@property(nonatomic,assign)int index;
/**
 *  记录数据,数组里存储的是模型
 */
@property(nonatomic,strong)NSArray *questions;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *headView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)big;
@property(weak,nonatomic)IBOutlet UIButton *cover;
- (IBAction)headClick;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;
- (IBAction)tipClick;

@end

@implementation ViewController
/**
 *  懒加载，读取plist文件
 */
-(NSArray *)questions{
    if (_questions==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"questions" ofType:@"plist"];
        //dictArray中存储的是整个plist文件的内容
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        
        //NSLog(@"%@",dictArray);
        /**
         *  字典转模型
         */
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            QuestionModel *question=[QuestionModel questionWithDict:dict];
            [tempArray  addObject:question];
        }
        _questions=tempArray;
        //NSLog(@"%@",_questions);
        
    }
    return _questions;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.index=-1;
    [self next];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next{
    //0.判断是否越界
    if (self.index==9) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你通关了" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"知道了",@"拜拜", nil];
        //设置代理
        alert.delegate=self;
        [alert show];
        return;
    }
    //1.索引值加1
    self.index++;
    //2.设置数据
    QuestionModel *question=self.questions[self.index];
    [self setData:question];
    //3.添加答案按钮
    [self addAnswerBtn:question];
    //4.添加待选项按钮
    [self addOptionBtn:question];
    //ios8以后的弹框方法
//    UIAlertController *alertViewController=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜你通关了" preferredStyle:UIAlertControllerStyleAlert];//preferredStyle:表示弹出的框的位置，UIAlertControllerStyleAlert表示中间弹框
//    //弹出框
//    [self presentViewController:alertViewController animated:NO completion:nil];//completion:表示弹框完成以后做什么
//    //添加取消按钮，并设置响应方法
//    [alertViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了取消");
//    }]];
    }
/**
 * 变成小图
 */
-(void)smallImage{
    //修改头像的frame，使其变小
    
    //2.让阴影消失(可以用传参数的方式操控cover button，也可以创建一个button的成员变量指向创建的cover button，来操控它
    [UIView animateWithDuration:1.5 animations:^{
        self.headView.frame=CGRectMake(97, 108, 180, 180);
        self.cover.alpha=0.0;
    }completion:^(BOOL finished) {
        if (finished) {
            [self.cover removeFromSuperview];
            //此处不用写self.cover=nil;因为weak成员变量移除后会自动赋值成nil
            
        }
    }];
    
}
- (IBAction)big {
    /**
     *  1.阴影
     */
    UIButton *cover=[[UIButton alloc]initWithFrame:self.view.bounds];
    self.cover=cover;
    cover.backgroundColor=[UIColor blackColor];
    cover.alpha=0.0;
    [self.view addSubview:cover];
    [cover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
    /**
     *  2.调整位置（让图片到前面）
     */
    [self.view bringSubviewToFront:self.headView];
    /**
     *  3.修改头像frame
     */
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    cover.alpha=0.6;
    CGFloat headViewW=self.view.frame.size.width;
    CGFloat headViewH=headViewW;
    CGFloat headViewX=0;
    CGFloat headViewY=(self.view.frame.size.height-headViewH)*0.5;
    self.headView.frame=CGRectMake(headViewX, headViewY, headViewW, headViewH);
    NSLog(@"%f",self.headView.frame.size.width);

    [UIView commitAnimations];
    
}
/**
 *  头像点击
 */
- (IBAction)headClick {
    if(self.cover==nil){//self.cover等于空表示没有阴影，那么此时是小图,则放大
        [self big];
    }
    else{//此时是大图，应缩小
        [self smallImage];
    }
}
/**
 *  点击下一题时设置数据
 *
 *  @param question 问题模型中的对应索引值的数据
 */
-(void)setData:(QuestionModel *)question{
    self.noLabel.text=[NSString stringWithFormat:@"%d/%ld",self.index+1,self.questions.count];
    self.descLabel.text=question.title;
    [self.headView setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    //设置到最后一张图片时，下一题按钮不可点击了，避免index值继续+1造成数组越界问题
    self.nextBtn.enabled=(self.index!=self.questions.count-1);
}

-(void)addAnswerBtn:(QuestionModel *)question{
    NSInteger answerLength=question.answer.length;
    CGFloat ansSpaceXmargin=10;
    CGFloat answerBtnW=40;
    CGFloat answerBtnH=answerBtnW;
    CGFloat answerBtnY=0;
    CGFloat ansLeftMargin=(self.view.frame.size.width-answerLength*answerBtnW-ansSpaceXmargin*(answerLength-1))*0.5;
    for (UIButton *answerBtn in self.answerView.subviews) {
        [answerBtn removeFromSuperview];
    }
    
    
    for (int i=0; i<answerLength; i++) {
        //3.1创建按钮
        UIButton *answerBtn=[[UIButton alloc]init];
        //3.2设置frame
        CGFloat answerBtnX=ansLeftMargin+i*(answerBtnW+ansSpaceXmargin);
        answerBtn.frame=CGRectMake(answerBtnX, answerBtnY, answerBtnW, answerBtnH);
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [answerBtn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //3.4添加
        [self.answerView addSubview:answerBtn];
        [answerBtn addTarget:self action:@selector(answerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }

}
/**
 *  添加选项按钮
 *
 *  @param question 问题模型中的对应索引值的数据
 */
-(void)addOptionBtn:(QuestionModel *)question{
    NSInteger optionLehgth=question.options.count;
    int totalColumn=7;
    CGFloat optionBtnW=40;
    CGFloat optionBtnH=optionBtnW;
    CGFloat optSpace=10;
    CGFloat optLeftMargin=(self.view.frame.size.width-totalColumn*optionBtnW-(totalColumn-1)*optSpace)*0.5;
    for (UIButton *optionBtn in self.optionView.subviews) {
        [optionBtn removeFromSuperview];
    }
    for (int i=0; i<optionLehgth; i++) {
        UIButton *optionBtn=[[UIButton alloc]init];
        CGFloat optionBtnX=optLeftMargin+(i%7)*(optionBtnW+optSpace);
        CGFloat optionBtnY=i/totalColumn*(optionBtnH+optSpace);
        optionBtn.frame=CGRectMake(optionBtnX, optionBtnY, optionBtnW, optionBtnH);
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [optionBtn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        [optionBtn setTitle:question.options[i] forState:UIControlStateNormal];
        [optionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.optionView addSubview:optionBtn];
        //给选项按钮添加点击事件
        [optionBtn addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }

}




/**
 *  监听待选项按钮的点击
 */
-(void)optionClick:(UIButton *)optionBtn{
    //1.让点击的按钮隐藏
    NSString *optionTitle=[optionBtn titleForState:UIControlStateNormal];
    optionBtn.hidden=YES;
    //2.把点击的待选项按钮的文字显示到答案的第一个为空的答案按钮中
    for (UIButton *answerBtn in self.answerView.subviews) {
        NSString *answerTitle=[answerBtn titleForState:UIControlStateNormal];
        if (answerTitle==nil) {
            [answerBtn setTitle:optionTitle
                       forState:UIControlStateNormal];
            break;
        }
    }
    /**
     *  判断是否满了
     *
     *  @return <#return value description#>
     */
    BOOL full=YES;
    NSMutableString *tempString=[NSMutableString string];
    for (UIButton *answerBtn in self.answerView.subviews) {
        NSString *answerTitle=[answerBtn titleForState:UIControlStateNormal];
        if (answerTitle.length==0) {
            full=NO;
            break;
        }
        if(answerTitle){
            [tempString appendString:answerTitle];
        }
        
    }
    //4.如果答案满了，判断是否正确
    QuestionModel *question=self.questions[self.index];
    NSString *answer=question.answer;
    if (full) {
        if ([tempString isEqualToString:answer]) {
            NSLog(@"对了");
            //加分
            [self changeScore:100];
            //下一题
            [self performSelector:@selector(next) withObject:nil afterDelay:0.5];
            
        }
        else{
            NSLog(@"错了");
            for (UIButton *answerBtn in self.answerView.subviews) {
                [answerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }

        }
        //for (UIButton *optionBtn in self.optionView.subviews) {
            //optionBtn.enabled=NO;
        //}
    }
}
/**
 *  监听答案按钮的点击
 *
 *  @param answerBtn 点击的答案按钮
 */
-(void)answerBtnClick:(UIButton *)answerBtn{
    //让答案按钮变成黑色
    for (UIButton *answerBtn in self.answerView.subviews) {
        [answerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    NSString *answerTitle=[answerBtn titleForState:UIControlStateNormal];
    
    for (UIButton *optionBtn in self.optionView.subviews) {
        NSString *optionTitle=[optionBtn titleForState:UIControlStateNormal];

        if(optionBtn.hidden){
            NSLog(@"option%@",optionTitle);
            NSLog(@"answer%@",answerTitle);
            if ([optionTitle isEqualToString:answerTitle]) {
                optionBtn.hidden=NO;
                [answerBtn setTitle:nil forState:UIControlStateNormal];
                break;
            }
            
        }
        
    }
}
/**
 *  提示功能的实现
 */
- (IBAction)tipClick {
    //将答案中的文字都清空
    for (UIButton *answerBtn in self.answerView.subviews) {
        [self answerBtnClick:answerBtn];
    }
    //显示第一个答案
    QuestionModel *question=self.questions[self.index];
    NSString *answer=question.answer;
    answer=[answer substringToIndex:1];
    for (UIButton *optionBtn in self.optionView.subviews) {
        NSString *optionTitle=[optionBtn titleForState:UIControlStateNormal];
        if ([answer isEqualToString:optionTitle]) {
            [self optionClick:optionBtn];
            break;
        }
    }
    //扣分
    [self changeScore:-100];
}
-(void)changeScore:(int) score{
    int totalScore=[[self.scoreBtn titleForState:UIControlStateNormal]intValue];
    [self.scoreBtn setTitle:[NSString stringWithFormat:@"%d",totalScore+score] forState:UIControlStateNormal];
}
//实现代理方法监听alertView中按钮的点击
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        NSLog(@"点击了取消按钮");
    }
        
}

@end
