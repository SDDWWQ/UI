//
//  FriendCell.h
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"
@interface FriendCell : UITableViewCell
@property(nonatomic,strong)FriendModel *friend;
+(instancetype)FriendCellWithTableView:(UITableView *)tableView;
@end
