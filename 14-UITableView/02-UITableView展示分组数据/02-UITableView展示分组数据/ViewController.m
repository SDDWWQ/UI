//
//  ViewController.m
//  02-UITableView展示分组数据
//
//  Created by shadandan on 16/7/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>

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
//分几组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//每组几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }
    else if(section==1){
        return 2;
    }
    else{
        return 1;
    }

}
//设置cell中的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //indexPath有两个属性：
    //indexPath.section表示组数
    //indexPath.row表示每组的行数
    //创建单元格对象
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section==0){
        if(indexPath.row==0){//第一组：亚洲
            cell.textLabel.text=@"中国";
        }
        else if(indexPath.row==1){
            cell.textLabel.text=@"日本";
        }
        else{
            cell.textLabel.text=@"韩国";
        }
    }
    else if(indexPath.section==1){//第二组：非洲
        if (indexPath.row==0) {
            cell.textLabel.text=@"南非";
        }
        else{
            cell.textLabel.text=@"索马里";
        }
    }
    else{//第三组：欧洲
        cell.textLabel.text=@"荷兰";
    }
    return cell;
}
//每一组的组标题显示什么
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //根据当前组的索引section，返回不同组的标题
    if (section==0) {
        return @"亚洲";
    }
    else if (section==1){
        return @"非洲";
    }
    else{
        return @"欧洲";
    }
}
//每一组的组尾显示什么（组描述）
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    //根据当前组的索引section，返回不同组的描述信息
    if (section==0) {
        return @"亚细亚洲，日出的地方";
    }
    else if(section==1){
        return @"阿里非加州，阳光灼热的地方";
    }
    else{
        return @"欧罗巴洲，鲜花盛开的地方，日落的地方";
    }
}
@end
