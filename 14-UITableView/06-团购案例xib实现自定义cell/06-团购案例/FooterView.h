//
//  FooterView.h
//  06-团购案例
//
//  Created by shadandan on 16/7/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FooterView;
@protocol FooterViewDelegate<NSObject>
@required
-(void)footerViewUpdateData:(FooterView *)footerView;
@end

@interface FooterView : UIView
@property(nonatomic,weak)id<FooterViewDelegate>delegate;
//定义类方法，通过xib创建UITableViewCell
+(instancetype)footerView;
@end
