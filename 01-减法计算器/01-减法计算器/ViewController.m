//
//  ViewController.m
//  01-减法计算器
//
//  Created by shadandan on 16/6/16.
//  Copyright © 2016年 SDD. All rights reserved.
//
//test guthub
#import "ViewController.h"
//延展类（扩展类）:一般用来存放只是在内部使用的方法或属性，好处：安全、封装
@interface ViewController ()

@end

@implementation ViewController
-(IBAction)count{
    NSLog(@"我看到一个美女");
    //1.拿到两个文本输入框的值
    NSString *text1=self.textField1.text;
    NSString *text2=self.textField2.text;
    //2.相减
    int num1=[text1 intValue];
    int num2=[text2 intValue];
    int difference=0;
    if (num1>num2||num1==num2) {
        difference=num1-num2;
    }
    else{//弹框
        //2.1创建弹框
        //initWithTitle表示标题 message：详细信息cancelButtonTitle:取消按钮的文字
        /*UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入数字不合理" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
         */
       //2.2提示
        //[alert show];
        //ios8的弹框
        //2.3.1创建一个弹框
        UIAlertController *alertVc=[UIAlertController alertControllerWithTitle:@"提示" message:@"输入的数字不合理" preferredStyle:UIAlertControllerStyleAlert];
        //2.3.2添加取消按钮
        [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        //2.3.3显示弹框
        [self presentViewController:alertVc animated:NO completion:nil];
    }
    //3.把相减的值显示到右边的文本标签中
    self.differenceLabel.text=[NSString stringWithFormat:@"%d",difference];//因为difference是int类型不能直接赋值给text，text是NSString类型，所以使用stringWithFormat来格式化拼接成字符串
    //4.退出键盘
    //第一响应者：能够调出键盘的控件叫第一响应者，可以有多个第一响应者
    //4.1释放第一响应者(第一种方法)
    //[self.textField1 resignFirstResponder];
    //[self.textField2 resignFirstResponder];
    //4.2结束可能成为第一响应者的父控件的编辑状态（第二种方法）
    [self.view endEditing:YES];
}


@end
