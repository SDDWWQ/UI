//
//  ViewController.m
//  05-汽车品牌展示2
//
//  Created by shadandan on 16/7/8.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "GroupModel.h"
#import "CarModel.h"
@interface ViewController ()<UITableViewDelegate>
@property(nonatomic,strong)NSArray *groups;
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
-(NSArray *)groups{
    if (_groups==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"cars_total" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            GroupModel *group=[GroupModel GroupWithDict:dict];
            [tempArray addObject:group];
        }
        _groups=tempArray;
    }
    return _groups;
}
#pragma mark-数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GroupModel *group=self.groups[section];
    return group.cars.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据源
    GroupModel *group=self.groups[indexPath.section];
    CarModel *car=group.cars[indexPath.row];
    
    //单元格重用
    //1.在创建单元格的时候指定一个“重用ID”
    static NSString *ID=@"car_cell";//声明一个英雄单元格的重用ID
    //2.当需要一个新的单元格的时候，先去“缓存池”中根据“重用ID”去查找是否有可用的单元格
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    //3.判断是否找到
    if (cell==nil) {
        NSLog(@"创建新的单元格");
        //3.1.如果没有需要的单元格，就需要重新创建一个单元格，并指定重用ID，当此单元格滚出tableView时就会自动进到缓存池中。
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //3.2.如果有，则直接从缓存池中取出这个单元格，进行使用（修改这个单元格中显示的数据、样式），系统会自动调用，不需要我们手动更改
    //输出单元格地址
    NSLog(@"%p",cell);
    
    //把模型中的数据设置给单元格中的子控件
    cell.textLabel. text=car.name;
    cell.imageView.image=[UIImage imageNamed:car.icon];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    GroupModel *group=self.groups[section];
    return group.title;
}
//右侧索引栏
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.groups valueForKeyPath:@"title"];//kvc的方法

}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
