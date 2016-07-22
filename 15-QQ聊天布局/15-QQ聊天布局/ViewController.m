//
//  ViewController.m
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/13.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"
#import "MessageModel.h"
#import "MessageFrame.h"
#import "MessageCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *messageFrames;//记录模型
@property (weak, nonatomic) IBOutlet UITableView *tableView;//表格视图
@property (weak, nonatomic) IBOutlet UITextField *txtInput;//最下边的输入文本框
//记录自动回复的字典
@property(nonatomic,strong)NSDictionary *replyDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //设置tableView的背景色，要想使背景色显示出来必须清除单元格的背景色，要不然显示不出来，会覆盖上
    self.tableView.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    //设置单元格不允许被选中
    self.tableView.allowsSelection=NO;
    //为了实现底部输入的文本框光标距离左侧有一段间距，不紧贴边界，就在最左侧添加一个UIView控件
    UIView *leftVw=[[UIView alloc]init];
    leftVw.frame=CGRectMake(0, 0, 5, 1);
    self.txtInput.leftView=leftVw;
    self.txtInput.leftViewMode=UITextFieldViewModeAlways;//设置左边的View什么时候显示（一直都显示，只在编辑时显示等）
    //监听键盘的弹出事件
    //1.创建一个NSNotificationCenter对象
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.监听键盘的弹出通知
    [center addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];//表示监听任意对象的键盘将要改变frame事件，执行keyBoardWillChangeFrame方法
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark-懒加载
-(NSMutableArray *)messageFrames{
    if (_messageFrames==nil) {
        NSString *path=[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        //NSLog(@"%ld",dictArray.count);
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            MessageModel *model=[MessageModel MessageWithDict:dict];
            
            //设置时间Label是否隐藏的标志，注意此步骤要在将数据模型设置给frame模型之前做
            //获取上一个数据模型
            MessageModel  *lastModel=(MessageModel *)[[tempArray lastObject]message];
            //判断当前模型的“消息发送时间”是否和上一个模型的“消息发送时间”一致，如果一致做个标记
            if ([model.time isEqualToString:lastModel.time]) {
                model.hideTime=YES;
            }else{
                model.hideTime=NO;
            }

            //将数据模型设置给frame模型
            MessageFrame *messageFrame=[[MessageFrame alloc]init];
            messageFrame.message=model;
            
            [tempArray addObject:messageFrame];
        }
        _messageFrames=tempArray;
    }
    return _messageFrames;
}
-(NSDictionary *)replyDict{
    if (_replyDict==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"AutoReply" ofType:@"plist"];
        _replyDict=[NSDictionary dictionaryWithContentsOfFile:path];
        
    }
    return _replyDict;
}
#pragma mark-实现数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据
    MessageFrame *messageFrame=self.messageFrames[indexPath.row];
    //创建cell
    MessageCell *cell=[MessageCell messageCellWithTableView:tableView];
    //给cell赋值
    cell.messageFrame=messageFrame;
    //返回cell
    return cell;
}
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}
//重写设置cell行高的方法，返回每一行行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MessageFrame *messageFrame=self.messageFrames[indexPath.row];
    return  messageFrame.rowHeight;
}
#pragma mark-监听键盘相关
-(void)keyBoardWillChangeFrame:(NSNotification *)noteInfo{
    //NSLog(@"通知名称：%@",noteInfo.name);
    //NSLog(@"通知的发布者：%@",noteInfo.object);
    //NSLog(@"通知的具体内容：%@",noteInfo.userInfo);
    /**
     通知的具体内容：{
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 676}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 460}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 216}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 352}, {320, 216}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     }
     */
    
    //1.获取键盘的Y值
    CGRect rectEnd=[noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyboardY=rectEnd.origin.y;
    CGFloat transformValue=keyboardY-self.view.frame.size.height;//无论键盘是弹出还是收回，整个视图需要平移的量正好等于键盘当前y值-整个view的高度值。
    [UIView animateWithDuration:0.25 animations:^{
        //让控制器的View执行一次平移
        self.view.transform=CGAffineTransformMakeTranslation(0, transformValue);
    }];
    
    
    //让UITableView的最后一行滚动到最上面,使用scrollToRowAtIndexPath方法滚动到指定行来实现
    NSIndexPath *lastRowIdxPath=[NSIndexPath indexPathForRow:self.messageFrames.count-1 inSection:0];//第1组的最后一行
    [self.tableView scrollToRowAtIndexPath: lastRowIdxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];//将最后一行滚到最上边
    
}
//重写dealloc方法
-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark-UIScrollView的代理方法
//实现滚动聊天记录是，键盘自动收回
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     //让控制器所管理的UIView结束编辑
    [self.view endEditing:YES];
}
#pragma mark-文本框的代理方法
//当键盘上的return键时被触发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //1.获取用户输入的文本
    NSString *text=textField.text;
    //调用发送消息方法
    [self sendMessageWithType:text andType:MessageTypeMe];
    //根据发送的内容回复信息
    BOOL autoReply;
    for(int i=0;i<text.length;i++){
        NSString *temp=[text substringWithRange:NSMakeRange(i, 1)];
        if (self.replyDict[temp]) {//如果存在以当前字符串为键的键值对，那么就回复当前键的值
            [self sendMessageWithType:self.replyDict[temp] andType:MessageTypeOther];
            autoReply=YES;
            break;
        }
    }
    if (autoReply==NO) {
        [self sendMessageWithType:@"好的" andType:MessageTypeOther];
    }
    
    //发送完毕清空文本框
    textField.text=nil;
    return YES;
}
/**
 *  发送消息
 *
 *  @param text 要发送的内容
 *  @param type 发送人类型（自己还是对方）
 */
-(void)sendMessageWithType:(NSString *)text andType:(MessageType)type{
    //2.创建一个数据模型和frame模型
    MessageModel *message=[[MessageModel alloc]init];
    //获取当前时间
    NSDate *nowDate=[NSDate date];
    //创建一个日期时间格式化器
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    //设置格式
    formatter.dateFormat=@"今天 HH:mm";
    message.time=[formatter stringFromDate:nowDate];
    message.type=type;
    message.text=text;
    //创建一个frame模型
    MessageFrame *messageFrame=[[MessageFrame alloc]init];
    messageFrame.message=message;
    //根据当前数据的时间和上一条数据的时间，判断时间是否隐藏
    MessageFrame *lastMessageFrame=self.messageFrames.lastObject;
    NSString *lastTime=lastMessageFrame.message.time;
    if ([message.time isEqualToString:lastTime]) {
        message.hideTime=YES;
    }
    //3.把fram模型加到集合中
    [self.messageFrames addObject:messageFrame];
    //4.刷新
    [self.tableView reloadData];
    //5.把最后一行滚动到最上面
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.messageFrames.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
