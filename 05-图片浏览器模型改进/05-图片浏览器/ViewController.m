//
//  ViewController.m
//  05-图片浏览器
//
//  Created by shadandan on 16/6/20.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "imageModel.h"
@interface ViewController ()
- (IBAction)previous;
- (IBAction)next;
//索引值
@property(nonatomic,assign)int index;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
-(void)changeData;
//放置数据,一般的OC对象用strong，否则创建出来就会销毁，UI控件用weak
@property(nonatomic,strong)NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index=0;//这句话也可以去掉，成员变量值默认为0
    [self changeData];
}

//懒加载（延迟加载，使用数据时才加载），重写get方法，
-(NSArray *)images{
    //核心思想：当数据不存在的时候加载
    if(_images==nil){
        //1.获取plist文件的全路径
        //NSString *path=[[NSBundle mainBundle]pathForResource:@"images.plist" ofType:nil];
        NSString *path=[[NSBundle mainBundle]pathForResource:@"images" ofType:@"plist"];
        //2.读取plist文件
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        //3.字典转模型
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
           imageModel *imageModel1= [[imageModel alloc]init];
            imageModel1.icon=dict[@"icon"];//取的是对应键的值，赋值给模型的属性
            imageModel1.desc=dict[@"desc"];
            [tempArray addObject:imageModel1];
            
            
        }
        _images=tempArray;//存储的是模型，不再是字典了
    }
    return _images;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previous {
    //1.索引值-1
    self.index--;
    //2.根据索引值设置数据
    [self changeData];
}

- (IBAction)next {
    //1.索引值+1
    self.index++;
    //2.根据索引值设置数据
    [self changeData];
    
}
-(void)changeData{
    //改进
    self.noLabel.text=[NSString stringWithFormat:@"%d/%lu",self.index+1,self.images.count];
    //NSDictionary *dict=self.images[self.index];
    imageModel *imgModel=self.images[self.index];
    self.head.image=[UIImage imageNamed:imgModel.icon];
    self.descLabel.text=imgModel.desc;
//    self.head.image=[UIImage imageNamed:dict[@"icon"]];
//    self.descLabel.text=dict[@"desc"];
    self.previousBtn.enabled=(self.index==0)?NO:YES;
    self.nextBtn.enabled=(self.index==(self.images.count-1))?NO:YES;

}
@end
