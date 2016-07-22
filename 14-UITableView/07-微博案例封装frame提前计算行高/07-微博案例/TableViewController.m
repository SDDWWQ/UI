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
#import "BlogFrame.h"
@interface TableViewController ()<UITableViewDelegate>
//微博的frame模型数组
@property(nonatomic,strong)NSArray *blogFrames;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //统一设置cell的行高
    
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
    return self.blogFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.获取模型数据
    BlogFrame *blogFrame=self.blogFrames[indexPath.row];
    //2.创建单元格
    BlogCell *cell = [BlogCell BlogCellWithTableView:self.tableView];
    //3.设置单元格数据
    cell.blogFrame=blogFrame;
    NSLog(@"%f",cell.blogFrame.vipFrame.origin.x);
    //4.返回单元格
    return cell;
}

#pragma mark-懒加载
//因为直接用代理方法设置行高的函数会在计算行高的函数之前执行，因此无意义，要想在计算行高之后再调用设置行高的函数就要把，计算行高的代码提前，因此放在懒加载中，一加载完数据就创建frame并计算行高
-(NSArray *)blogFrames{
    if (_blogFrames==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"weibos" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            //创建一个数据模型
            BlogModel *blog=[BlogModel BlogWithDict:dict];
            //创建一个frame模型
            BlogFrame *blogFrame=[[BlogFrame alloc]init];
            //把数据模型赋值给BlogFrame中的blog属性
            blogFrame.blog=blog;
            [tempArray addObject:blogFrame];
        }
        _blogFrames=tempArray;
    }
    return _blogFrames;
}
#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark-Table View代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BlogFrame *blogFrame=self.blogFrames[indexPath.row];
    return blogFrame.rowHeight;
}
@end
