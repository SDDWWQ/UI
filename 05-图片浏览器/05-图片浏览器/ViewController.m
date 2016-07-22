//
//  ViewController.m
//  05-图片浏览器
//
//  Created by shadandan on 16/6/20.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

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
    //为了性能问题，我们使用懒加载改进
//    // 建5个字典描述5条数据
//    NSMutableDictionary *dict1=[NSMutableDictionary dictionary];
//    dict1[@"icon"]=@"biaoqingdi";
//    dict1[@"desc"]=@"在他面前，其他神马表情都弱爆了";
//    NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
//    dict2[@"icon"]=@"wangba";
//    dict2[@"desc"]=@"哥们，为什么选八号呢？";
//    NSMutableDictionary *dict3=[NSMutableDictionary dictionary];
//    dict3[@"icon"] =@"bingli";
//    dict3[@"desc"]=@"这也忒狠了";
//    NSMutableDictionary *dict4=[NSMutableDictionary dictionary];
//    dict4[@"icon"]=@"chiniupa";
//    dict4[@"desc"]=@"这小姑娘吃个牛排比杀牛还费劲啊";
//    NSMutableDictionary *dict5=[NSMutableDictionary dictionary];
//    dict5[@"icon"]=@"danteng";
//    dict5[@"desc"]=@"亲，你能改下你的网名吗？";
//    //存入images数组
//    _images=@[dict1,dict2,dict3,dict4,dict5];
    
    
//    self.noLabel.text=@"1/5";
//    self.head.image=[UIImage imageNamed:@"biaoqingdi"];
//    self.descLabel.text=@"在他面前，其他神马表情都弱爆了";
//    self.previousBtn.enabled=NO;
    //改进
    self.index=0;//这句话也可以去掉，成员变量值默认为0
    [self changeData];
}

//懒加载（延迟加载，使用数据时才加载），重写get方法，
-(NSArray *)images{
    //核心思想：当数据不存在的时候加载
    if(_images==nil){
//        // 建5个字典描述5条数据
//        NSMutableDictionary *dict1=[NSMutableDictionary dictionary];
//        dict1[@"icon"]=@"biaoqingdi";
//        dict1[@"desc"]=@"在他面前，其他神马表情都弱爆了";
//        NSMutableDictionary *dict2=[NSMutableDictionary dictionary];
//        dict2[@"icon"]=@"wangba";
//        dict2[@"desc"]=@"哥们，为什么选八号呢？";
//        NSMutableDictionary *dict3=[NSMutableDictionary dictionary];
//        dict3[@"icon"] =@"bingli";
//        dict3[@"desc"]=@"这也忒狠了";
//        NSMutableDictionary *dict4=[NSMutableDictionary dictionary];
//        dict4[@"icon"]=@"chiniupa";
//        dict4[@"desc"]=@"这小姑娘吃个牛排比杀牛还费劲啊";
//        NSMutableDictionary *dict5=[NSMutableDictionary dictionary];
//        dict5[@"icon"]=@"danteng";
//        dict5[@"desc"]=@"亲，你能改下你的网名吗？";
//        //存入images数组
//        _images=@[dict1,dict2,dict3,dict4,dict5];
        
        //用plist文件存储数据来改进
        //1.获取plist文件的全路径
        //NSString *path=[[NSBundle mainBundle]pathForResource:@"images.plist" ofType:nil];
        NSString *path=[[NSBundle mainBundle]pathForResource:@"images" ofType:@"plist"];
        //2.读取plist文件
        _images=[NSArray arrayWithContentsOfFile:path];
        //3.字典转模型
        
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
    NSDictionary *dict=self.images[self.index];
    self.head.image=[UIImage imageNamed:dict[@"icon"]];
    self.descLabel.text=dict[@"desc"];
    //2.根据索引值设置数据
//    switch(self.index){
//        case 0:
//            //self.noLabel.text=@"1/5";
//            self.head.image=[UIImage imageNamed:@"biaoqingdi"];
//            self.descLabel.text=@"在他面前，其他神马表情都弱爆了";
//            break;
//        case 1:
//            //self.noLabel.text=@"2/5";
//            self.head.image=[UIImage imageNamed:@"wangba"];
//            self.descLabel.text=@"哥们，为什么选八号呢？";
//            break;
//        case 2:
//            //self.noLabel.text=@"3/5";
//            self.head.image=[UIImage imageNamed:@"bingli"];
//            self.descLabel.text=@"这也忒狠了";
//            break;
//        case 3:
//            //self.noLabel.text=@"4/5";
//            self.head.image=[UIImage imageNamed:@"chiniupa"];
//            self.descLabel.text=@"这小姑娘吃个牛排比杀牛还费劲啊";
//            break;
//        case 4:
//            //self.noLabel.text=@"5/5";
//            self.head.image=[UIImage imageNamed:@"danteng"];
//            self.descLabel.text=@"亲，你能改下你的网名吗？";
//            break;
//    }
    //3.设置按钮的状态
//    if(self.index==0){
//        self.previousBtn.enabled=NO;
//    }
//    else{
//        self.previousBtn.enabled=YES;
//    }
    //if else的改进
    self.previousBtn.enabled=(self.index==0)?NO:YES;
    //改进2：self.previousBtn.enabled=(self.index!=0);
//    if(self.index==4){
//        self.nextBtn.enabled=NO;
//    }
//    else{
//        self.nextBtn.enabled=YES;
//    }
    self.nextBtn.enabled=(self.index==(self.images.count-1))?NO:YES;

}
@end
