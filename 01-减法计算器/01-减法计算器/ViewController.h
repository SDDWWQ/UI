//
//  ViewController.h
//  01-减法计算器
//
//  Created by shadandan on 16/6/16.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//用来监听按钮的点击
-(IBAction)count;
//凡是UI控件都用weak修饰
//用来监听按钮的点击
//第一个文本输入框
@property(nonatomic,weak)IBOutlet UITextField *textField1;
//第二个文本输入框
@property(nonatomic,weak)IBOutlet UITextField *textField2;
@property(nonatomic,weak)IBOutlet UILabel *differenceLabel;
@end

