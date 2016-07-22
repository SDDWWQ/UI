//
//  ShopCell.h
//  06-团购案例
//
//  Created by shadandan on 16/7/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopModel;
@interface ShopCell : UITableViewCell
@property(nonatomic,strong)ShopModel *shop;
//封装一个创建自定义cell的方法
+(instancetype)shopCellWithTableView:(UITableView *)tableView;
@end
