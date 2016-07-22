//
//  HeaderView.h
//  18-QQ好友列表
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
@class HeaderView;
//创建代理方法
@protocol HeaderViewDelegate<NSObject>
-(void)headerViewClick:(HeaderView *)header;
@end

@interface HeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)GroupModel *group;
+(instancetype)GroupHeaderView:(UITableView *)tableView;
//增加一个代理属性
@property(nonatomic,weak)id<HeaderViewDelegate> delegate;
@end
