//
//  TableViewController.m
//  19-应用管理
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "TableViewController.h"
#import "AppModel.h"
#import "AppCell.h"
@interface TableViewController ()<AppCellDelegate>
@property(nonatomic,strong)NSArray *apps;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.tableView.rowHeight=60;
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

    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppModel *app=self.apps[indexPath.row];
    static NSString *ID=@"app_cell";
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //缓冲池中没有cell，会自动根据storyboard上的cell进行创建
    //把模型赋值给单元格
    cell.app=app;
    //设置单元格的代理
    cell.delegate=self;
    
    return cell;
}

#pragma mark-懒加载
-(NSArray *)apps{
    if (_apps==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"app" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in dictArray) {
            AppModel *app=[AppModel AppWithDict:dict];
            [tempArray addObject:app];
        }
        _apps=tempArray;
    }
    return _apps;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark-AppCell代理方法的实现
//因为要在控制器上显示，所以要让控制器来实现，设置控制器为代理
-(void)appCellDidClickDownLoadButton:(AppCell *)appCell{
    //1.创建一个Label
    UILabel *label=[[UILabel alloc]init];
    label.backgroundColor=[UIColor blackColor];
    label.textColor=[UIColor redColor];
    label.font=[UIFont systemFontOfSize:12];
    label.textAlignment=NSTextAlignmentCenter;
    label.alpha=0.0;
    //设置圆角
    label.layer.cornerRadius=8;
    label.layer.masksToBounds=YES;
    label.text=@"正在下载...";
    CGFloat labelW=200;
    CGFloat labelH=30;
    CGFloat labelX=(self.view.frame.size.width-labelW)*0.5;
    CGFloat labelY=(self.view.frame.size.height-labelH)*0.5;
    label.frame=CGRectMake(labelX, labelY, labelW, labelH);
    //把Label加到tableView中，lable会随着tableView的滚动而滚动，因此Label会滚上去，不应该加到这里边，应该加到窗体里面
    //[self.tableView addSubview:label];
    [[[UIApplication sharedApplication]keyWindow]addSubview:label];
    //动画的形式显示和隐藏Label
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha=0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:5 options:UIViewAnimationOptionCurveLinear animations:^{
            label.alpha=0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
@end
