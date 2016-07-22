//
//  ViewController.m
//  06-团购案例
//
//  Created by shadandan on 16/7/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"
#import "ShopCell.h"
#import "FooterView.h"
#import "HeaderView.h"
@interface ViewController ()<UITableViewDataSource,FooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *shops;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置UITableView的footerView
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.backgroundColor=[UIColor redColor];
//    btn.frame=CGRectMake(20, 50, 30, 100);//tableView 的footerView只能修改x和height的值，Y和width修改无效。
//    self.tableView.tableFooterView=btn;
    
    //通过xib设置UITableView的footerView
    //xib创建footerView
    FooterView *footerView=[FooterView footerView];
    //设置footerView的代理
    footerView.delegate=self;
    self.tableView.tableFooterView=footerView;
    
    //加载HeaderView广告
    HeaderView *headerView=[HeaderView headerView];
    self.tableView.tableHeaderView=headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-懒加载
-(NSMutableArray *)shops{
    if (_shops==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"tgs" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        //NSLog(@"%ld",dictArray.count);
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
    
    //通过xib方式创建单元格，调用xib类自定义的类方法
    ShopCell *cell=[ShopCell shopCellWithTableView:tableView];
    //将数据设置给单元格
    cell.shop=shop;
    return cell;
    
}
#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark-设置FooterView的代理方法
-(void)footerViewUpdateData:(FooterView *)footerView{
    //3.增加一条数据
    //3.1创建一个模型对象
    ShopModel *model=[[ShopModel alloc]init];
    model.title=@"驴肉火烧";
    model.price=@"6.0";
    model.buyCount=@"200";
    model.icon=@"37d3d539b6003af3d7d18084332ac65c1138b6ef.jpg";
    //3.2把模型对象加到控制器的shops集合当中
    [self.shops addObject:model];
    //4.刷新UITableView
    [self.tableView reloadData];
    //5.把UITableView的最后一行数据滚动到top、middle、bottom
    NSIndexPath *idxPath=[NSIndexPath indexPathForRow:self.shops.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}
@end
