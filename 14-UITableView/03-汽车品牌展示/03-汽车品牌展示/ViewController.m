//
//  ViewController.m
//  03-汽车品牌展示
//
//  Created by shadandan on 16/7/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "CarModel.h"
@interface ViewController ()<UITableViewDataSource>

@property(nonatomic,strong)NSArray *carGroups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
#pragma mark-懒加载
-(NSArray *)carGroups{
    if (_carGroups==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"cars_simple" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        //字典转模型
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CarModel *cars=[CarModel carsWithDict:dict];
            [tempArray addObject:cars];
        }
        _carGroups=tempArray;
    }
    return _carGroups;
}
#pragma mark-数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"%ld",_carGroups.count);//0,5,5,因为初始的时候没有调用get方法，初始值为0
    //NSLog(@"%ld",self.carGroups.count);//5,5,5，此处调用get方法，数据加载进去，值为5
    return self.carGroups.count;//必须用self.carGroups，不能用_carGroups
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据组索引（section）获取组对象
    CarModel *cargroup=self.carGroups[section];
    return cargroup.cars.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.获取模型数据
    //通过section获取组模型
    CarModel *cargroup=self.carGroups[indexPath.section];
    //通过row获取对应的汽车品牌
    NSString *brand=cargroup.cars[indexPath.row];
    //2.创建单元格
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //3.把模型中的数据设置给单元格中的子控件,即把汽车品牌设置给单元格中的Label
    cell.textLabel.text=brand;
    //4.返回单元格
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CarModel *cargroup= self.carGroups[section];
    return cargroup.title;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    CarModel *cargoup=self.carGroups[section];
    return cargoup.desc;
}
#pragma mark-隐藏状态栏
//不需要调用，加入此函数即可
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
