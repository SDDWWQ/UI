//
//  AppCell.h
//  19-应用管理
//
//  Created by shadandan on 16/7/19.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@class AppCell;

@protocol AppCellDelegate<NSObject>
-(void)appCellDidClickDownLoadButton:(AppCell *)appCell;
@end

@interface AppCell : UITableViewCell
@property(nonatomic,strong)AppModel *app;
@property(nonatomic,weak)id<AppCellDelegate> delegate;
@end
