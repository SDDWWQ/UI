//
//  BlogFrame.h
//  07-微博案例
//
//  Created by shadandan on 16/7/13.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#define NameLabelFontSize [UIFont systemFontOfSize:12]
#define TextLabelFontSize [UIFont systemFontOfSize:14]

@class BlogModel;
@interface BlogFrame : NSObject
//保存数据的属性
@property(nonatomic,strong)BlogModel *blog;
//保存头像frame的属性
@property(nonatomic,assign,readonly)CGRect iconFrame;
@property(nonatomic,assign,readonly)CGRect nameFrame;
@property(nonatomic,assign,readonly)CGRect vipFrame;
@property(nonatomic,assign,readonly)CGRect textFrame;
@property(nonatomic,assign,readonly)CGRect imageFrame;
//行高
@property(nonatomic,assign,readonly)CGFloat rowHeight;
@end
