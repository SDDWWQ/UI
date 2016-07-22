//
//  FriendCell.m
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/18.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)FriendCellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"friend_cell";
    FriendCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[FriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;

}
-(void)setFriend:(FriendModel *)friend{
    self.textLabel.text=friend.name;
    self.imageView.image=[UIImage imageNamed:friend.icon];
    self.detailTextLabel.text=friend.intro;
    if (friend.isVip) {
        self.textLabel.textColor=[UIColor redColor];
    }else{
        self.textLabel.textColor=[UIColor blackColor];
    }

}
@end
