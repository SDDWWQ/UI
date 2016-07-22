//
//  MessageFrame.h
//  15-QQ聊天布局
//
//  Created by shadandan on 16/7/14.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MessageModel.h"
#define textFont [UIFont systemFontOfSize:12]//定义字体大小的宏
@interface MessageFrame : NSObject

@property(nonatomic,strong)MessageModel *message;//获取模型中的数据
@property(nonatomic,assign,readonly)CGRect textFrame;
@property(nonatomic,assign,readonly)CGRect timeFrame;
@property(nonatomic,assign,readonly)CGRect iconFrame;
@property(nonatomic,assign,readonly)CGFloat rowHeight;

@end
