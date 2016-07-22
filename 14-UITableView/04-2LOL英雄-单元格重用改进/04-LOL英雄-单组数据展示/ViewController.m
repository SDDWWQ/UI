//
//  ViewController.m
//  04-LOL英雄-单组数据展示
//
//  Created by shadandan on 16/7/6.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "HeroModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *heros;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //统一设置UITableView的所有行行高
    self.tableView.rowHeight=60;
    //对于每行的行高不一样的情况，无法通过tableView.rowHeight来实现，此时只能通过一个代理方法来实现
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-懒加载
-(NSArray *)heros{
    if (_heros==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"heros" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            HeroModel *hero=[HeroModel HeroWithDict:dict];
            [tempArray addObject:hero];
        }
        _heros=tempArray;
    }
    return _heros;
}
#pragma mark-数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.heros.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据源
    HeroModel *hero=self.heros[indexPath.row];
    
    //创建单元格
//    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    //单元格重用
    //1.在创建单元格的时候指定一个“重用ID”
        static NSString *ID=@"hero_cell";//声明一个英雄单元格的重用ID
    //2.当需要一个新的单元格的时候，先去“缓存池”中根据“重用ID”去查找是否有可用的单元格
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    //3.判断是否找到
    if (cell==nil) {
        NSLog(@"创建新的单元格");
        //3.1.如果没有需要的单元格，就需要重新创建一个单元格，并指定重用ID，当此单元格滚出tableView时就会自动进到缓存池中。
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //3.2.如果有，则直接从缓存池中取出这个单元格，进行使用（修改这个单元格中显示的数据、样式），系统会自动调用，不需要我们手动更改
    //输出单元格地址
    NSLog(@"%p",cell);
    
    //把模型中的数据设置给单元格中的子控件
    cell.textLabel. text=hero.name;
    cell.imageView.image=[UIImage imageNamed:hero.icons];
    cell.detailTextLabel.text=hero.intro;
    //要在单元格最右边显示一个小箭头，所以要设置单元格对象的某个属性
    //cell.accessoryType
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//还有四种可选状态：UITableViewCellAccessoryNone、UITableViewCellAccessoryCheckmark、UITableViewCellAccessoryDetailButton、 UITableViewCellAccessoryDetailDisclosureButton
    
    //可以自定义单元格右边的accessory
    //cell.accessoryView=[[UISwitch alloc]init];//accessoryView可以添加各种控件，比accessoryType的种类更多
    
    //设置单元格背景颜色
    cell.backgroundColor=[UIColor yellowColor];
    
    //设置单元格选中时的背景颜色，因为cell没有selectedBackgroundColor属性，所以通过selectedBackgroundView属性来设置
    UIView *bgView=[[UIView  alloc]init];
    bgView.backgroundColor=[UIColor greenColor];
    cell.selectedBackgroundView=bgView;
    
    
    return cell;
}
//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark -代理方法
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int rowNum=indexPath.row;
    if (rowNum%2==0) {
        return 60;
    }else{
        return 70;
    }
}
@end
