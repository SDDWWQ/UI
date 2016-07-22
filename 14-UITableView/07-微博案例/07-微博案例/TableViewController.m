//
//  TableViewController.m
//  07-微博案例
//
//  Created by shadandan on 16/7/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "TableViewController.h"
#import "BlogModel.h"
#import "BlogCell.h"
@interface TableViewController ()
@property(nonatomic,strong)NSArray *blogs;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //统一设置cell的行高
    self.tableView.rowHeight=200;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.获取模型数据
    BlogModel *blog=self.blogs[indexPath.row];
    //2.创建单元格
    BlogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blog_cell"];
    if (cell==nil) {
        cell=[[BlogCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"blog_cell"];
    }
    //3.设置单元格数据
    cell.blog=blog;
    //4.返回单元格
    return cell;
}

#pragma mark-懒加载
-(NSArray *)blogs{
    if (_blogs==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"weibos" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            BlogModel *blog=[BlogModel BlogWithDict:dict];
            [tempArray addObject:blog];
        }
        _blogs=tempArray;
    }
    return _blogs;
}
#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
