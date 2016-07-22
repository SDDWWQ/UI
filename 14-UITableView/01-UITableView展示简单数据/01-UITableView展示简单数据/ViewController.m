//
//  ViewController.m
//  01-UITableView展示简单数据
//
//  Created by shadandan on 16/7/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置数据源
    self.tableView.dataSource=self;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/****************UITableView的数据源方法****************/
//1.告诉UITableView要显示几组，这个方法可以不实现，不实现默认就是分1组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//2.告诉UITableView每组显示几条（几行）数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
//3.告诉UITableView每一组的每一行显示什么单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //表示当前是第几组
    //indexPath.section
    //表示当前是第几行
    //indexPath.row
    //创建单元格对象并返回
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=@"hello";
    return cell;
}

@end
