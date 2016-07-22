//
//  ViewController.m
//  03-QQ登录
//
//  Created by shadandan on 16/6/20.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)login;
@property (weak, nonatomic) IBOutlet UITextField *qq;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login {
    NSLog(@"qq:%@,密码：%@",self.qq.text,self.pwd.text);
    //关掉键盘
    [self.view endEditing:YES];

}
@end
