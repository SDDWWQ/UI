//
//  TableViewController.m
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "TableViewController.h"
#import "GroupModel.h"
#import "FriendCell.h"
#import "HeaderView.h"
@interface TableViewController()<HeaderViewDelegate>
@property(nonatomic,strong)NSArray *groups;
@end
@implementation TableViewController
#pragma mark-控制器的ViewDidLoad方法
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight=44;
}
#pragma mark-懒加载
-(NSArray *)groups{
    if (_groups==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"friends" ofType:@"plist"];
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
#pragma mark-实现数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GroupModel *group=self.groups[section];
    NSArray *friends=group.friends;
    //因为在这个方法中，要根据当前组的状态（是否展开），来设置不同的返回值，所以需要为GroupModel模型增加一个用来保存“是否展开”状态的属性
    NSLog(@"isvisible=%d",group.isVisible);
    if (group.isVisible) {
        return friends.count;
    }else{
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据
    GroupModel *group=self.groups[indexPath.section];
    FriendModel *friend=group.friends[indexPath.row];
    //创建单元格
    FriendCell *cell=[FriendCell FriendCellWithTableView:tableView];
    //将模型赋值给单元格
    cell.friend=friend;
    //返回单元格
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //获取数据模型
    GroupModel *group=self.groups[section];
    //创建标题栏
    HeaderView *header=[HeaderView GroupHeaderView:tableView];
    //将数据赋值给headerView
    header.group=group;
    /*在刚刚创建好的headerView中获取的headerView的frame都是0，因为刚刚创建好的headerView我们没有为其frame赋值，所以frame都是0，但是，程序运行起来后，我们看到的headerView是有frame的。原因是：在当前方法中，将headerView返回以后，UITableview在执行的时候，会用到headerView，UITableView既然要用headerView，那就必须将headerView添加到UITableView中，此时UITableView内部会根据一些设置来动态地为headerView的frame赋值，也就是是说在UITableView即将使用headerView的时候才会为headerView的frame赋值。
     */
    //设置headerView的代理为当前控制器
    header.delegate=self;
    //将当前组编号保存为header的tag值用于后边刷新某个组
    header.tag=section;
    return header;
}
#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark-实现自定义HeaderView的代理方法
-(void)headerViewClick:(HeaderView *)header{
    //[self.tableView reloadData];//刷新整个tableview

    //根据tag获取组对象
    NSIndexSet *idx=[NSIndexSet indexSetWithIndex:header.tag];
    //刷新某个组
    [self.tableView reloadSections:idx withRowAnimation:UITableViewRowAnimationFade];
}
@end
