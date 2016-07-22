//
//  ShopCell.m
//  06-团购案例
//
//  Created by shadandan on 16/7/9.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ShopCell.h"
#import "ShopModel.h"
//类扩展
@interface ShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelBuyCount;

@end
@implementation ShopCell
//重写set方法
-(void)setShop:(ShopModel *)shop{
    _shop=shop;
    //将模型的数据设置给子控件
    self.imageViewIcon.image=[UIImage imageNamed:shop.icon];
    self.labelTitle.text=shop.title;
    self.labelPrice.text=[NSString stringWithFormat:@"￥   %@",shop.price];
    self.labelBuyCount.text=[NSString stringWithFormat:@"%@人已购买",shop.buyCount];
}
//创建单元格
+(instancetype)shopCellWithTableView:(UITableView *)tableView{
    //单元格重用
    static NSString *ID=@"shop";
    ShopCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        //通过xib方式来创建单元格
        cell= [[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:nil options:nil]firstObject];
    }
    return cell;

}
@end
