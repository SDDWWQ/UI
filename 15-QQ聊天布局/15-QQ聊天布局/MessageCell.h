//
//  MessageCell.h
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFrame.h"

@interface MessageCell : UITableViewCell
//为自定义单元格增加一个frame模型属性
@property(nonatomic,strong)MessageFrame *messageFrame;
+(instancetype)messageCellWithTableView:(UITableView *)tableView;
@end
