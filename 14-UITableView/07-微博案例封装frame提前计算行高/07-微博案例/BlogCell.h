//
//  BlogCell.h
//  07-微博案例
//
//  Created by shadandan on 16/7/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogModel.h"
#import "BlogFrame.h"
@interface BlogCell : UITableViewCell

@property(nonatomic,strong)BlogFrame *blogFrame;
//创建单元格-单元格重用
+(instancetype)BlogCellWithTableView:(UITableView *)tableView;
@end
