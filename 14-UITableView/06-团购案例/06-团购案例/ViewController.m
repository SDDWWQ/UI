//
//  ViewController.m
//  06-团购案例
//
//  Created by shadandan on 16/7/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"
@interface ViewController ()<UITableViewDataSource>
@property(nonatomic,strong)NSArray *shops;
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
-(NSArray *)shops{
    if (_shops==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"tgs" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ShopModel *shop=[ShopModel ShopWithDict:dict];
            [tempArray addObject:shop];
        }
        _shops=tempArray;
    }
    return _shops;
}
#pragma mark-数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shops.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取所在cell
    ShopModel *shop=self.shops[indexPath.row];
    
    //单元格重用
     static NSString *ID=@"shop";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.imageView.image=[UIImage imageNamed:shop.icon];
    cell.textLabel.text=shop.title;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"￥ %@     %@人已购买",shop.price,shop.buyCount];

    return cell;
    
}
#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
